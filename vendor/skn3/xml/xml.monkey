#rem
	MIT License.
	http://opensource.org/licenses/MIT
	
	Copyright (c) 2013 SKN3
	
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
	documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
	the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
	and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all copies or substantial portions 
	of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
	TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
	THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
	CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
	DEALINGS IN THE SOFTWARE.
#end

'XML for monkey - Written by skn3 (Jon Pittock)
'A single file xml lib for monkey that supports comments,cdata,self-closing tags,relaxed line breaks,unquoted attributes,attributes without assignment,single + double quotes,
'whitespace trimming.
'The only string manipulation performed is for tag value data (anything outside of a tag) that gets chopped off by a child tag. All other string manipulation is buffered in an
'int array so you will not have a ton of newly created temporary strings. Most text parsing has been designed to compare asc integer values instead of strings.
'Each node will have its document line,column and offset values added to it for each debugging. Error messages will also report correct document details.
'The lib was written from scratch with no reference.

'version 10
' - renamed the attribute query and stringbuffer classes
'version 9
' - added HasChildren() method to node
'version 8
' - fixed bool to string bug in SetAttribute
' - fixed GetNextSibling and GetPreviousSibling to return nullnode instead of null (make sure to check return object for valid instead of null .. eg while node.valid instead of while node)
'version 7
' - added GetChild() (with no name or attributes) this will allow to get first child of a node
' - added SetAttribute() and GetAttribute() overloads for bool,int,float, string and no value so don't have to do value conversion in user code!
'version 6
' - fix by David (DGuy) to fix unreocgnised tag end when case was different. Also added licenses.
'version 5
' - added GetNextSibling() and GetPreviousSibling() for searching for siblings adjacent that match tag-name and/or attributes.
'version 4
' - changed readonly to valid to make more sense. Can now check for valid nodes like so If doc.GetChild("").valid
'version 3
' - speed improvement repalced string.Find with HasStringAtOffset() for searching for tag starts
'version 2
' - changed Find___ functions to Get___
' - added GetDescendants() for getting all descendants of node
' - add path lookup ability see GetChildAtPath() and GetChildrenAtPath()
' - added default null return nodes so function chaining wont crash app
' - made it so node can be valid, used for the default null node
' - added GetParent() for safe traversal of teh node strucutre
' - added special @value into query string to look for a nodes value
'version 1
' - first release
Strict

Import monkey.list
Import monkey.map

Const XML_STRIP_WHITESPACE:= 1'this will remove whitespace characters from NON attribute data

Private
Const XML_FORMAT_OPEN:= "<?xml"
Const XML_FORMAT_CLOSE:= "?>"
Const COMMENT_OPEN:= "<!--"
Const COMMENT_CLOSE:= "-->"
Const CDATA_OPEN:= "<![CDATA["
Const CDATA_CLOSE:= "]]>"

Class XMLStringBuffer
	Field data:int[]
	Field chunk:Int = 128
	Field count:Int
	Field dirty:Int = False
	Field cache:String
	
	'constructor/destructor
	Method New(chunk:Int = 128)
		Self.chunk = chunk
	End
	
	'properties
	Method value:String() Property
		' --- get the property ---
		'rebuild cache
		If dirty
			dirty = False
			If count = 0
				cache = ""
			Else
				cache = String.FromChars(data[0 .. count])
			EndIf
		EndIf
		
		'return cache
		Return cache
	End
	
	'api
	Method Add:Void(asc:Int)
		' --- add single asc to buffer ---
		'resize
		If count = data.Length data = data.Resize(data.Length + chunk)
		
		'fill data
		data[count] = asc
		
		'move pointer
		count += 1
		
		'flag dirty
		dirty = True
	End
	
	Method Add:Void(text:String)
		' --- add text to buffer ---
		If text.Length = 0 Return
		
		'resize
		If count + text.Length >= data.Length data = data.Resize(data.Length + (chunk * Ceil(Float(text.Length) / chunk)))
		
		'fill data
		For Local textIndex:= 0 Until text.Length
			data[count] = text[textIndex]
			
			'move pointer
			count += 1
		Next
		
		'flag dirty
		dirty = True
	End
	
	Method Add:Void(text:String, offset:Int, suggestedLength:Int = 0)
		' --- add text clipping to buffer ---
		'figure out real length of the import
		Local realLength:= text.Length - offset
		If suggestedLength > 0 And suggestedLength < realLength realLength = suggestedLength
		
		'skip
		If realLength = 0 Return
		
		'resize
		If count + realLength >= data.Length data = data.Resize(data.Length + (chunk * Ceil(Float(realLength) / chunk)))
		
		'fill data
		For Local textIndex:= offset Until offset + realLength
			data[count] = text[textIndex]
			
			'move pointer
			count += 1
		Next
		
		'flag dirty
		dirty = True
	End
	
	Method Clear:Void()
		' --- clear the buffer ---
		count = 0
		cache = ""
		dirty = False
	End
	
	Method Shrink:Void()
		' --- shrink the data ---
		Local newSize:Int
		
		'get new size
		If count = 0
			newSize = chunk
		Else
			newSize = Ceil(float(count) / chunk)
		EndIf
		
		'only bother resizing if its changed
		If newSize <> data.Length data = data.Resize(newSize)
	End
	
	Method Trim:Bool()
		' --- this will trim whitespace from the start and end ---
		'skip
		If count = 0 Return False
		
		'quick trim
		If (count = 1 and (data[0] = 32 or data[0] = 9)) or (count = 2 And (data[0] = 32 or data[0] = 9) And (data[1] = 32 or data[1] = 9))
			Clear()
			Return True
		EndIf
		
		'full trim
		'get start trim
		Local startIndex:Int
		For startIndex = 0 Until count
			If data[startIndex] <> 32 And data[startIndex] <> 9 Exit
		Next
		
		'check if there was only whitespace
		If startIndex = count
			Clear()
			Return True
		EndIf
		
		'get end trim
		Local endIndex:Int
		For endIndex = count - 1 To 0 Step - 1
			If data[endIndex] <> 32 And data[endIndex] <> 9 Exit
		Next

		'check for no trim
		If startIndex = 0 And endIndex = count - 1 Return False
		
		'we have to trim so set new length (count)
		count = endIndex - startIndex + 1
		
		'do we need to shift data left?
		If startIndex > 0
			For Local trimIndex:= 0 Until count
				data[trimIndex] = data[trimIndex + startIndex]
			Next
		EndIf
		
		'return that we trimmed
		Return True
	End
	
	Method Length:Int() Property
		' --- return length ---
		Return count
	End
	
	Method Last:Int(defaultValue:Int = -1)
		' --- return the last asc ---
		'skip
		If count = 0 Return defaultValue
		
		'return
		Return data[count - 1]
	End
End

Class XMLAttributeQuery
	Field chunk:Int = 32
	Field items:XMLAttributeQueryItem[]
	Field count:Int
	
	'constructor/destructor
	Method New(query:String)
		' --- this will create a new query object ---
		'query is in the format of 'title1=value1&title2=value2'
		'the = and & character can be escaped with a \ character
		'a value pair can also be shortcut like 'value1&value2&value3'
		Local queryIndex:Int
		Local queryAsc:Int
		
		Local buffer:= New XMLStringBuffer(256)
		
		Local isEscaped:= False
		
		Local processBuffer:= False
		Local processItem:= False
		
		Local hasId:= False
		Local hasValue:= False
		Local hasEquals:= False
		Local hasSepcial:= False
		
		Local itemId:String
		Local itemValue:String
		
		For queryIndex = 0 Until query.Length
			'looking for title
			queryAsc = query[queryIndex]
			
			If isEscaped
				'escaped character
				isEscaped = False
				buffer.Add(queryAsc)
			Else
				'test character
				Select queryAsc
					Case 38'&
						processBuffer = True
						processItem = True
						
					Case 61'=
						processBuffer = True
						hasEquals = True
						
					Case 64'@
						If hasId = False
							'switch on special value
							If buffer.Length = 0 hasSepcial = True
						Else
							'value so just add it
							buffer.Add(queryAsc)
						EndIf
						
					Case 92'\
						isEscaped = True
						
					Default
						'skip character if we are building id and there is not valid alphanumeric
						If hasId or (queryAsc = 95 or (queryAsc >= 48 and queryAsc <= 57) or (queryAsc >= 65 and queryAsc <= 90) or (queryAsc >= 97 and queryAsc <= 122)) buffer.Add(queryAsc)
				End
			EndIf
			
			'check for end condition
			If queryIndex = query.Length - 1
				processBuffer = True
				processItem = True
				
				'add escape character if it was left over
				If isEscaped And hasId buffer.Add(92)
				
				'check for blank =
				If hasEquals And buffer.Length = 0 hasValue = True
			EndIf
			
			'process the buffer
			If processBuffer
				'unflag process
				processBuffer = False
				
				'check condition
				If hasId = False
					itemId = buffer.value
					buffer.Clear()
					hasId = itemId.Length > 0
				Else
					itemValue = buffer.value
					buffer.Clear()
					hasValue = True
				EndIf
			EndIf
			
			'process the item
			If processItem
				'unflag process
				processItem = False
				
				'check condition
				If hasId
					'insert new value
					'resize
					If count = items.Length items = items.Resize(items.Length + chunk)
					
					'create new item
					items[count] = New XMLAttributeQueryItem(itemId, itemValue, hasValue, hasSepcial)
					
					'increase count
					count += 1
					
					'reset
					itemId = ""
					itemValue = ""
					hasId = False
					hasValue = False
					hasSepcial = False
				EndIf
			EndIf
		Next
	End
	
	'api
	Method Test:Bool(node:XMLNode)
		' --- this will test the given node against the query ---
		Local attribute:XMLAttribute
		
		For Local index:= 0 Until count
			If items[index].special = False
				'attribute comparison
				'get attribute
				attribute = node.GetXMLAttribute(items[index].id)
				
				'check conditions for fail
				If attribute = Null or (items[index].required And attribute.value <> items[index].value) Return False
			Else
				'special query
				Select items[index].id
					Case "value"
						'check conditions for fail
						If (items[index].required And node.value <> items[index].value) Return False
				End
			EndIf
		Next
		
		'success
		Return True
	End
End

Class XMLAttributeQueryItem
	Field id:String
	Field value:String
	Field required:Bool
	Field special:Bool
	
	'constructor/destructor
	Method New(id:String, value:String, required:Bool, special:Bool)
		Self.id = id
		Self.value = value
		Self.required = required
		Self.special = special
	End
End

Function HasStringAtOffset:Bool(needle:String, haystack:String, offset:Int)
	' --- quick function for testing a string at given offset ---
	'skip
	If offset + needle.Length > haystack.Length Return False
	
	'scan characters
	For Local index:= 0 Until needle.Length
		If needle[index] <> haystack[offset + index] Return False
	Next
	
	'return success
	Return True
End
Public

Class XMLDoc Extends XMLNode
	Field nullNode:XMLNode
	Field version:String
	Field encoding:String
	Field paths:= New StringMap<List<XMLNode>>
	
	'constructor/destructor
	Method New(name:String, version:String = "", encoding:String = "")
		' --- create node with name ---
		valid = True
		
		'create null node
		nullNode = New XMLNode("", False)
		nullNode.doc = Self
		
		'fix casing
		Self.name = name.ToLower()
		Self.version = version
		Self.encoding = encoding
		
		'setup path
		path = name
		pathList = New List<XMLNode>
		pathList.AddLast(Self)
		paths.Insert(path, pathList)
	End
	
	'api
	Method Export:String(options:Int = XML_STRIP_WHITESPACE)
		' --- convert the node to a string ---
		'create a buffer
		Local buffer:= New XMLStringBuffer(1024)
		
		'add xml details
		'add open
		buffer.Add(XML_FORMAT_OPEN)
		
		'add version
		If version.Length
			buffer.Add(" version=")
			buffer.Add(34)
			buffer.Add(version)
			buffer.Add(34)
		EndIf
		
		'add encoding
		If encoding.Length
			buffer.Add(" encoding=")
			buffer.Add(34)
			buffer.Add(encoding)
			buffer.Add(34)
		EndIf
		
		'add close
		buffer.Add(XML_FORMAT_CLOSE)
		
		'call internal export
		Super.Export(options, buffer, 0)
		
		'return
		Return buffer.value
	End
End

Class XMLNode
	Field valid:Bool
	Field name:String
	Field value:String
	Field path:String
	Field doc:XMLDoc
	Field parent:XMLNode
	Field nextSibling:XMLNode
	Field previousSibling:XMLNode
	Field firstChild:XMLNode
	Field lastChild:XMLNode
	Field line:Int
	Field column:Int
	Field offset:Int
	Field children:= New List<XMLNode>
	Field attributes:= New StringMap<XMLAttribute>
	
	Private
	Field pathList:List<XMLNode>
	Public
	
	'constructor/destructor
	Method New(name:String, valid:Bool = True)
		' --- create node with name ---
		If name.Length Self.name = name.ToLower()'fix casing
		Self.valid = valid
	End
	
	Method Free:Void()
		' --- used when the node is removed the doc ---
		'remove from paths list
		pathList.Remove(Self)
		
		'recurse
		If firstChild
			Local child:= firstChild
			While child
				child.Free()
				child = child.nextSibling
			Wend
		EndIf
	End
	
	'internal
	Private
	Method Export:Void(options:Int, buffer:XMLStringBuffer, depth:Int)
		' --- convert the node to a string ---
		'make sure there is a buffer to work with
		If buffer = Null buffer = New XMLStringBuffer(1024)
		
		Local index:Int
		
		'add opening tag
		'ident
		If options & XML_STRIP_WHITESPACE = False
			For index = 0 Until depth
				buffer.Add(9)
			Next
		EndIf
		
		buffer.Add(60)
		buffer.Add(name)
		
		'add attributes
		For Local id:= EachIn attributes.Keys()
			buffer.Add(32)
			buffer.Add(id)
			buffer.Add(61)
			buffer.Add(34)
			buffer.Add(attributes.Get(id).value)
			buffer.Add(34)
		Next
		
		'finish opening tag
		buffer.Add(62)
		
		'add children
		If children.IsEmpty() = False
			For Local child:= EachIn children
				child.Export(options, buffer, depth + 1)
			Next
		EndIf
		
		'add whitespace
		If value.Length buffer.Add(value)
		
		'add closing tag
		'ident
		If options & XML_STRIP_WHITESPACE = False
			For index = 0 Until depth
				buffer.Add(9)
			Next
		EndIf
		buffer.Add(60)
		buffer.Add(47)
		buffer.Add(name)
		buffer.Add(62)
	End
	
	Method GetXMLAttribute:XMLAttribute(id:String)
		' --- get attribute object ---
		Return attributes.Get(id.ToLower())
	End
	
	Method GetDescendants:Void(result:List<XMLNode>, name:string)
		' --- internal method for recurse ---
		'scan children
		Local child:= firstChild
		While child
			'test
			If child.name = name result.AddLast(child)
			
			'recurse
			If child.firstChild child.GetDescendants(result, name)
			
			'next child
			child = child.nextSibling
		Wend
	End
	
	Method GetDescendants:Void(result:List<XMLNode>, name:string, query:XMLAttributeQuery)
		' --- internal method for recurse ---
		'scan children
		Local child:= firstChild
		While child
			'test
			If (name.Length = 0 or child.name = name) And query.Test(child) result.AddLast(child)
			
			'recurse
			If child.firstChild child.GetDescendants(result, name, query)
			
			'next child
			child = child.nextSibling
		Wend
	End
	Public
	
	'child api
	Method HasChildren:Bool()
		' --- returns true if has children ---
		Return firstChild <> Null
	End
	
	Method AddChild:XMLNode(name:String, attributes:String = "")
		' --- add a child node ---
		'skip
		If valid = False Return Null
		
		'create child
		Local child:= New XMLNode(name)
		child.doc = doc
		child.parent = Self
		
		'setup path
		child.path = path + "/" + child.name
		child.pathList = doc.paths.Get(child.path)
		If child.pathList = Null
			'create new path list
			child.pathList = New List<XMLNode>
			doc.paths.Set(child.path, child.pathList)
		EndIf
		child.pathList.AddLast(child)
		
		'any attributes to add?
		If attributes.Length
			Local query:= New XMLAttributeQuery(attributes)
			If query.count > 0
				For Local index:= 0 Until query.items.Length
					child.SetAttribute(query.items[index].id, query.items[index].value)
				Next
			EndIf
		EndIf
		
		'setup link nodes
		If lastChild
			'not first child
			'set previously last child to point next to new child
			lastChild.nextSibling = child
			
			'set new child previous to last child
			child.previousSibling = lastChild
			
			'update this last child to the new child
			lastChild = child
		Else
			'first child
			firstChild = child
			lastChild = child
		EndIf
		
		'add to self
		children.AddLast(child)
		
		'return it
		Return child
	End

	Method RemoveChild:Void(child:XMLNode)
		' --- remove child ---
		'skip
		If valid = False or firstChild = Null or child = Null or child.parent <> Self Return
		
		'call child to be freed
		child.Free()
		
		'update first and last pointer
		If lastChild = child lastChild = child.previousSibling
		If firstChild = child firstChild = child.nextSibling
		
		'update sibling pointers
		If child.previousSibling child.previousSibling.nextSibling = child.nextSibling
		If child.nextSibling child.nextSibling.previousSibling = child.previousSibling
		
		'dettach
		child.parent = Null
		child.previousSibling = Null
		child.nextSibling = Null
		
		'remove from list
		children.Remove(child)
	End
	
	Method ClearChildren:Void()
		' --- clears all children ---
		'skip
		If valid = False or firstChild = Null Return
		
		'iterate
		Local child:= firstChild
		While child
			'call child to be freed
			child.Free()
			
			'dettach from doc and parent
			child.previousSibling = Null
			child.nextSibling = Null
			child.parent = Null
			child.doc = Null
			
			'next child
			child = child.nextSibling
		Wend
		
		'reset lists
		children.Clear()
		firstChild = Null
		lastChild = Null
	End
	
	Method GetNextSibling:XMLNode(name:String = "")
		' --- search for next sibling with matching tag name ---
		'skip
		If nextSibling = Null Return doc.nullNode
		
		'quick
		If name.Length = 0 Return nextSibling
		
		'fix casing
		name = name.ToLower()
		
		'scan siblings
		Local pointer:= nextSibling
		While pointer
			If pointer.name = name Return pointer
			pointer = pointer.nextSibling
		Wend
		
		'not found
		Return Null
	End
	
	Method GetNextSibling:XMLNode(name:String, attributes:String)
		' --- search for next sibling with matching tag name ---
		'skip
		If nextSibling = Null Return doc.nullNode
		
		'quick
		If name.Length = 0 and attributes.Length = 0 Return nextSibling
		
		'fix casing
		name = name.ToLower()
		
		'parse the query
		Local query:= New XMLAttributeQuery(attributes)
		
		'scan siblings
		Local pointer:= nextSibling
		While pointer
			If (name.Length = 0 or pointer.name = name) and query.Test(pointer) Return pointer
			pointer = pointer.nextSibling
		Wend
		
		'not found
		Return Null
	End
	
	Method GetPreviousSibling:XMLNode(name:String = "")
		' --- search for previous sibling with matching tag name ---
		'skip
		If previousSibling = Null Return doc.nullNode
		
		'quick
		If name.Length = 0 Return previousSibling
		
		'fix casing
		name = name.ToLower()
		
		'scan siblings
		Local pointer:= previousSibling
		While pointer
			If pointer.name = name Return pointer
			pointer = pointer.previousSibling
		Wend
		
		'not found
		Return Null
	End
	
	Method GetPreviousSibling:XMLNode(name:String, attributes:String)
		' --- search for previous sibling with matching tag name ---
		'skip
		If previousSibling = Null Return doc.nullNode
		
		'quick
		If name.Length = 0 and attributes.Length = 0 Return previousSibling
		
		'fix casing
		name = name.ToLower()
		
		'parse the query
		Local query:= New XMLAttributeQuery(attributes)
		
		'scan siblings
		Local pointer:= previousSibling
		While pointer
			If (name.Length = 0 or pointer.name = name) and query.Test(pointer) Return pointer
			pointer = pointer.previousSibling
		Wend
		
		'not found
		Return Null
	End
	
	Method GetChild:XMLNode()
		' --- gets the first child ---
		'skip
		If firstChild = Null Return doc.nullNode
		
		'return
		Return firstChild
	End
	
	Method GetChild:XMLNode(name:String)
		' --- get first child by name ---
		'skip
		If firstChild = Null Return doc.nullNode
		
		'fix casing
		name = name.ToLower()
		
		'scan children
		Local child:= firstChild
		While child
			'test
			If child.name = name Return child
			
			'next child
			child = child.nextSibling
		Wend
		
		'return null node for chaining
		Return doc.nullNode
	End
	
	Method GetChild:XMLNode(name:String, attributes:String)
		' --- get first child by name with matching attributes ---
		'skip
		If firstChild = Null Return doc.nullNode
		
		'fix casing
		name = name.ToLower()
		
		'parse the query
		Local query:= New XMLAttributeQuery(attributes)
		
		'scan children
		Local child:= firstChild
		While child
			'test
			If child.name = name And query.Test(child) Return child
			
			'next child
			child = child.nextSibling
		Wend
		
		'return null node for chaining
		Return doc.nullNode
	End
	
	Method GetChildren:List<XMLNode>(name:String)
		' --- get children with name ---
		Local result:= New List<XMLNode>
		
		'skip
		If firstChild = Null or name.Length = 0 Return result
		
		'fix casing
		name = name.ToLower()
		
		'scan children
		If firstChild <> Null
			Local child:= firstChild
			While child
				'test
				If child.name = name result.AddLast(child)
				
				'next child
				child = child.nextSibling
			Wend
		EndIf
		
		'return the result
		Return result
	End
		
	Method GetChildren:List<XMLNode>(name:String, attributes:String)
		' --- get children with name ---
		Local result:= New List<XMLNode>
		
		'skip
		If firstChild = Null or (name.Length = 0 And attributes.Length = 0) Return result
		
		'fix casing
		name = name.ToLower()
		
		'parse the query
		Local query:= New XMLAttributeQuery(attributes)
		
		'scan children
		If firstChild <> Null
			Local child:= firstChild
			While child
				'test
				If (name.Length = 0 or child.name = name) And query.Test(child) result.AddLast(child)
				
				'next child
				child = child.nextSibling
			Wend
		EndIf
		
		'return the result
		Return result
	End
	
	Method GetDescendants:List<XMLNode>(name:String)
		' --- get all descendants that match name ---		
		Local result:= New List<XMLNode>
		
		'skip
		If firstChild = Null or name.Length = 0 Return result
		
		'fix casing
		name = name.ToLower()
		
		'call internal recursive method
		GetDescendants(result, name)
		
		'return result
		Return result
	End
	
	Method GetDescendants:List<XMLNode>(name:String, attributes:String)
		' --- get all descendants that match name ---		
		Local result:= New List<XMLNode>
		
		'skip
		If firstChild = Null or name.Length = 0 Return result
		
		'fix casing
		name = name.ToLower()
		
		'parse the query
		Local query:= New XMLAttributeQuery(attributes)
		
		'call internal recursive method
		GetDescendants(result, name, query)
		
		'return result
		Return result
	End
	
	Method GetChildAtPath:XMLNode(path:String)
		' --- get the node at the given path, path is relative to this node ---
		'skip
		If path.Length = 0 Return doc.nullNode
		
		'search for path or return null node if none
		Local pathList:= doc.paths.Get(Self.path + "/" + path)
		If pathList = Null or pathList.IsEmpty() Return doc.nullNode
		
		'return first path in list
		Return pathList.First()
	End
	
	Method GetChildAtPath:XMLNode(path:String, attributes:String)
		' --- get the node at the given path, path is relative to this node ---
		'skip
		If path.Length = 0 Return doc.nullNode
		
		'parse the query
		Local query:= New XMLAttributeQuery(attributes)
		
		'search for path or return null node if none
		Local pathList:= doc.paths.Get(Self.path + "/" + path)
		If pathList = Null or pathList.IsEmpty() Return doc.nullNode
		
		'scan paths in list
		For Local node:= EachIn pathList
			'check for matching attributes
			If query.Test(node) Return node
			
			'next node
			node = node.nextSibling
		Next
		
		'return nothing as nothing was found
		Return doc.nullNode
	End
	
	Method GetChildrenAtPath:List<XMLNode>(path:String)
		' --- get the node at the given path, path is relative to this node ---
		Local result:= New List<XMLNode>
		
		'skip
		If path.Length = 0 Return result
		
		'search for path or return null node if none
		Local pathList:= doc.paths.Get(Self.path + "/" + path)
		If pathList = Null or pathList.IsEmpty() Return result
		
		'copy all nodes into result
		For Local node:= EachIn pathList
			result.AddLast(node)
		Next
		
		'finish :)
		Return result
	End
	
	Method GetChildrenAtPath:List<XMLNode>(path:String, attributes:String)
		' --- get the node at the given path, path is relative to this node ---
		Local result:= New List<XMLNode>
		
		'skip
		If path.Length = 0 Return result
		
		'parse the query
		Local query:= New XMLAttributeQuery(attributes)
		
		'search for path or return null node if none
		Local pathList:= doc.paths.Get(Self.path + "/" + path)
		If pathList = Null or pathList.IsEmpty() Return result
		
		'copy all nodes into result
		For Local node:= EachIn pathList
			If query.Test(node) result.AddLast(node)
		Next
		
		'finish :)
		Return result
	End
	
	'parent api
	Method GetParent:XMLNode()
		' --- safe way to get parent ---
		If parent = Null Return doc.nullNode
		Return parent
	End
	
	'attribute api
	Method HasAttribute:Bool(id:String)
		' --- check if has attribute ---
		'fix id casing
		id = id.ToLower()
		
		'return true if the attribute exists
		Return attributes.Get(id) <> Null
	End
	
	Method SetAttribute:Void(id:String)
		' --- add new attribute to the node ---
		'skip
		If valid = False Return
		
		'fix id casing
		id = id.ToLower()
		
		'see if the attribute exists already
		Local attribute:= attributes.Get(id)
		If attribute = Null
			'create new attribute
			attributes.Insert(id, New XMLAttribute(id, ""))
		Else
			'set existing attribute
			attribute.value = ""
		EndIf
	End
	
	Method SetAttribute:Void(id:String, value:Bool)
		' --- add new attribute to the node ---
		'skip
		If valid = False Return
		
		'fix id casing
		id = id.ToLower()
		
		'see if the attribute exists already
		Local attribute:= attributes.Get(id)
		If attribute = Null
			'create new attribute
			attributes.Insert(id, New XMLAttribute(id, String(int(value))))
		Else
			'set existing attribute
			attribute.value = String(int(value))
		EndIf
	End
	
	Method SetAttribute:Void(id:String, value:Int)
		' --- add new attribute to the node ---
		'skip
		If valid = False Return
		
		'fix id casing
		id = id.ToLower()
		
		'see if the attribute exists already
		Local attribute:= attributes.Get(id)
		If attribute = Null
			'create new attribute
			attributes.Insert(id, New XMLAttribute(id, String(value)))
		Else
			'set existing attribute
			attribute.value = String(value)
		EndIf
	End
	
	Method SetAttribute:Void(id:String, value:Float)
		' --- add new attribute to the node ---
		'skip
		If valid = False Return
		
		'fix id casing
		id = id.ToLower()
		
		'see if the attribute exists already
		Local attribute:= attributes.Get(id)
		If attribute = Null
			'create new attribute
			attributes.Insert(id, New XMLAttribute(id, String(value)))
		Else
			'set existing attribute
			attribute.value = String(value)
		EndIf
	End
	
	Method SetAttribute:Void(id:String, value:String)
		' --- add new attribute to the node ---
		'skip
		If valid = False Return
		
		'fix id casing
		id = id.ToLower()
		
		'see if the attribute exists already
		Local attribute:= attributes.Get(id)
		If attribute = Null
			'create new attribute
			attributes.Insert(id, New XMLAttribute(id, value))
		Else
			'set existing attribute
			attribute.value = value
		EndIf
	End
	
	Method GetAttribute:String(id:String)
		' --- get attribute value ---
		'fix id casing
		id = id.ToLower()
		
		'check if it exists
		Local attribute:= attributes.Get(id)
		
		'no value so return default string
		If attribute = Null Return ""
		
		'return real value
		Return attribute.value
	End
		
	Method GetAttribute:Bool(id:String, defaultValue:Bool)
		' --- get attribute value ---
		'fix id casing
		id = id.ToLower()
		
		'check if it exists
		Local attribute:= attributes.Get(id)
		
		'use default value as doesn't exist
		If attribute = Null Return defaultValue
		
		'return real value
		Return attribute.value = "true" or Int(attribute.value) = True
	End
	
	Method GetAttribute:Int(id:String, defaultValue:Int)
		' --- get attribute value ---
		'fix id casing
		id = id.ToLower()
		
		'check if it exists
		Local attribute:= attributes.Get(id)
		
		'use default value as doesn't exist
		If attribute = Null Return defaultValue
		
		'return real value
		Return Int(attribute.value)
	End
	
	Method GetAttribute:Float(id:String, defaultValue:Float)
		' --- get attribute value ---
		'fix id casing
		id = id.ToLower()
		
		'check if it exists
		Local attribute:= attributes.Get(id)
		
		'use default value as doesn't exist
		If attribute = Null Return defaultValue
		
		'return real value
		Return Float(attribute.value)
	End
	
	Method GetAttribute:String(id:String, defaultValue:String)
		' --- get attribute value ---
		'fix id casing
		id = id.ToLower()
		
		'check if it exists
		Local attribute:= attributes.Get(id)
		
		'use default value as doesn't exist
		If attribute = Null Return defaultValue
		
		'return real value
		Return attribute.value
	End
	
	Method RemoveAttribute:Void(id:String)
		' --- remove particular attribute ---
		'skip
		If valid = False Return
		
		attributes.Remove(id)
	End
	
	Method ClearAttributes:Void()
		' --- clear all attributes ---
		'skip
		If valid = False Return
		
		attributes.Clear()
	End
	
	'api
	Method Export:String(options:Int = XML_STRIP_WHITESPACE)
		' --- convert the node to a string ---
		'create a buffer
		Local buffer:= New XMLStringBuffer(1024)
		
		'call internal export
		Export(options, buffer, 0)
		
		'return
		Return buffer.value
	End
End

Class XMLAttribute
	Field id:String
	Field value:String
	
	'constructor/destructor
	Method New(id:String, value:String)
		Self.id = id
		Self.value = value
	End
End

Class XMLError
	Field error:Bool = False
	Field message:String
	Field line:Int
	Field column:Int
	Field offset:Int
	
	'api
	Method Reset:Void()
		' --- reset error object ---
		error = False
		message = ""
		line = -1
		column = -1
		offset = -1
	End
	
	Method Set:Void(message:String, line:Int = -1, column:Int = -1, offset:Int = -1)
		' --- set an error ---
		error = True
		Self.message = message
		Self.line = line
		Self.column = column
		Self.offset = offset
	End

	Method ToString:String()
		' --- make a string out of this object ---
		If error = False Return ""
		Local buffer:= New XMLStringBuffer(256)
		buffer.Add("XMLError: ")
		
		'add message
		If message.Length
			buffer.Add(message)
		Else
			buffer.Add("unknown error")
		EndIf
		
		'add line
		buffer.Add(" [line:")
		If line > - 1
			buffer.Add(String(line))
		Else
			buffer.Add("??")
		EndIf
		
		'add column
		buffer.Add("  column:")
		If column > - 1
			buffer.Add(String(column))
		Else
			buffer.Add("??")
		EndIf
		
		'add offset
		buffer.Add("  offset:")
		If offset > - 1
			buffer.Add(offset + "]")
		Else
			buffer.Add("??]")
		EndIf
		
		'finish and return
		Return buffer.value
	End
End

Function ParseXML:XMLDoc(raw:String, error:XMLError = Null, options:Int = XML_STRIP_WHITESPACE)
	' --- this will parse xml into node structure ---
	Local rawLine:Int = 1
	Local rawColumn:Int = 1
	Local rawIndex:Int
	Local rawAsc:Int
	Local rawPos:Int
	Local rawChunkStart:Int
	Local rawChunkLength:Int
	Local rawChunkEnd:Int
	Local rawChunk:String
	Local rawChunkIndex:Int
	Local rawChunkAsc:Int
	
	Local doc:XMLDoc
	Local parent:XMLNode
	Local current:XMLNode
	
	Local whitespaceBuffer:= New XMLStringBuffer(128)
	Local attributeBuffer:= New XMLStringBuffer(128)
	
	Local processAttributeBuffer:Bool
	Local processTag:= False
	
	Local tagName:String
	
	Local formatVersion:String
	Local formatEncoding:String
	
	Local attributeId:String
	Local attributeValue:String
	
	Local inTag:= False
	Local inQuote:= False
	Local inFormat:= False
	
	Local isCloseSelf:= False
	Local isSingleAttribute:= False
	
	Local hasFormat:= False
	Local hasTagName:= False
	Local hasTagClose:= False
	Local hasAttributeId:= False
	Local hasAttributeValue:= False
	Local hasEquals:= False
	
	Local waitTagClose:= False
	
	Local stack:= New List<XMLNode>
	
	Local quoteAsc:Int
	
	'reset the error
	If error error.Reset()
	
	'scan the raw text
	For rawIndex = 0 Until raw.Length
		rawAsc = raw[rawIndex]
		'Print "rawAsc = " + rawAsc + " (" + String.FromChar(rawAsc) + ")"
		
		If inTag = False
			Select rawAsc
				Case 9, 32'<tab><space>
					If whitespaceBuffer.Length or (parent And parent.value.Length)
						'check for skipping duplicate whitespace
						Local lastAsc:Int = whitespaceBuffer.Last()
						If options & XML_STRIP_WHITESPACE = False or (whitespaceBuffer.Length And lastAsc <> 9 And lastAsc <> 32)
							'make sure we are not adding whitespace to nothing
							If parent = Null
								'error
								If error error.Set("illegal character", rawLine, rawColumn, rawIndex)
								Return Null
							EndIf
							
							'whitespace
							whitespaceBuffer.Add(rawAsc)
						EndIf
					EndIf
					
					'update line and column
					rawColumn += 1
					
				Case 10'<line feed>
					'update line and column
					rawLine += 1
					rawColumn = 1
					
				Case 13'<carriage return>
					'ignore stupid char
					
				Case 60'<
					'tag start
					'check for special tags
					If HasStringAtOffset(XML_FORMAT_OPEN, raw, rawIndex)
						'start of a xml tag
						'check for format already existing
						If hasFormat
							'error
							If error error.Set("duplicate xml format", rawLine, rawColumn, rawIndex)
							Return Null
						EndIf
						
						'setup details
						inTag = True
						inFormat = True
						
						'progress the raw line and column
						rawColumn += XML_FORMAT_OPEN.Length
						
						'move the raw index on
						rawIndex = rawPos + XML_FORMAT_OPEN.Length - 1
						
					ElseIf HasStringAtOffset(COMMENT_OPEN, raw, rawIndex)
						'start of a comment
						'look for end of comment so we can skip ahead
						rawPos = raw.Find(COMMENT_CLOSE, rawIndex + COMMENT_OPEN.Length)
						If rawPos = -1
							'error
							If error error.Set("comment not closed", rawLine, rawColumn, rawIndex)
							Return Null
						EndIf
						
						'get the chunk of data
						rawChunkStart = rawIndex + COMMENT_OPEN.Length
						rawChunkLength = rawPos - (rawIndex + COMMENT_OPEN.Length)
						rawChunkEnd = rawChunkStart + rawChunkLength

						'progress the raw line and column
						For rawChunkIndex = rawChunkStart Until rawChunkEnd
							rawChunkAsc = raw[rawChunkIndex]
							If rawChunkAsc = 10
								rawLine += 1
								rawColumn = 1
							Else
								rawColumn += 1
							EndIf
						Next
						
						'move the raw index on
						rawIndex = rawPos + COMMENT_CLOSE.Length - 1
						
					ElseIf HasStringAtOffset(CDATA_OPEN, raw, rawIndex)
						'start of cdata
						'look for end of cdata so we can skip ahead
						rawPos = raw.Find(CDATA_CLOSE, rawIndex + CDATA_OPEN.Length)
						If rawPos = -1
							'error
							If error error.Set("cdata not closed", rawLine, rawColumn, rawIndex)
							Return Null
						EndIf
						
						'we now have some cdata so we should add it to the current parent
						If parent = Null
							'error
							If error error.Set("unexepcted cdata", rawLine, rawColumn, rawIndex)
							Return Null
						EndIf
						
						'get the chunk of data
						rawChunkStart = rawIndex + CDATA_OPEN.Length
						rawChunkLength = rawPos - (rawIndex + CDATA_OPEN.Length)
						rawChunkEnd = rawChunkStart + rawChunkLength

						'progress the raw line and column
						For rawChunkIndex = rawChunkStart Until rawChunkEnd
							rawChunkAsc = raw[rawChunkIndex]
							If rawChunkAsc = 10
								rawLine += 1
								rawColumn = 1
							Else
								rawColumn += 1
							EndIf
						Next
						
						'add it to the parent value
						whitespaceBuffer.Add(raw, rawChunkStart, rawChunkLength)
						
						'move the raw index on
						rawIndex = rawPos + CDATA_CLOSE.Length - 1
						
					Else
						'start of a tag
						inTag = True
						
						'need to dummp any whitespace into the parent
						If whitespaceBuffer.Length
							'trim the whitespace
							If options & XML_STRIP_WHITESPACE = False
								'no trimming
								parent.value += whitespaceBuffer.value
								whitespaceBuffer.Clear()
							Else
								'need to trim
								whitespaceBuffer.Trim()
								If whitespaceBuffer.Length
									parent.value += whitespaceBuffer.value
									whitespaceBuffer.Clear()
								EndIf
							EndIf
						EndIf
						
						'update line and column
						rawColumn += 1
					EndIf
					
				Case 62'>
					'error
					If error error.Set("unexpected close bracket", rawLine, rawColumn, rawIndex)
					Return Null
					
				Default
					'make sure we are not adding whitespace to nothing
					If parent = Null
						'error
						If error error.Set("illegal character", rawLine, rawColumn, rawIndex)
						Return Null
					EndIf
					
					'whitespace
					whitespaceBuffer.Add(rawAsc)
					
					'update line and column
					rawColumn += 1
			End
		Else
			'we are in a tag so now we do tag parsing
			If waitTagClose
				'tag is waiting to close so lets process that!
				Select rawAsc
					Case 9'<tab>
						'update line and column
						rawColumn += 1
					Case 10'<line feed>
						'update line and column
						rawLine += 1
						rawColumn = 1
						
					Case 13'<carriage return>
						'just ignore this stupid character
						
					Case 32'<space>
						'update line and column
						rawColumn += 1
						
					Case 62'>
						'this is the end of a tag woo hoo
						waitTagClose = False
						processTag = True
						
					Default
						'error
						If error error.Set("unexpected character", rawLine, rawColumn, rawIndex)
						Return Null
				End
			Else
				If inQuote = False
					'we are not in a quote so we need to be selective as to what we are parsing!
					Select rawAsc
						Case 9'<tab>
							'update line and column
							rawColumn += 1
							
							'set if we need to process the attribute buffer
							If attributeBuffer.Length processAttributeBuffer = True
						
						Case 10'<line feed>
							'new line
							'update line and column
							rawLine += 1
							rawColumn = 1
							
							'set if we need to process the attribute buffer
							If attributeBuffer.Length processAttributeBuffer = True
							
						Case 13'<carriage return>
							'just ignore this stupid character
							
						Case 32'<space>
							'update line and column
							rawColumn += 1
							
							'set if we need to process the attribute buffer
							If attributeBuffer.Length processAttributeBuffer = True
							
						Case 34, 39'" '
							'quote
							quoteAsc = rawAsc
							inQuote = True
							
							'check for invalid value
							If hasTagClose or (hasTagName = False And inFormat = False) or hasEquals = False or attributeBuffer.Length
								'error
								If error error.Set("unexpected quote", rawLine, rawColumn, rawIndex)
								Return Null
							End
							
							'update line and column
							rawColumn += 1
							
							'set if we need to process the attribute buffer
							If attributeBuffer.Length processAttributeBuffer = True
							
						Case 47'/
							'close tag
							If hasTagClose or hasEquals
								'error
								If error error.Set("unexpected slash", rawLine, rawColumn, rawIndex)
								Return Null
							EndIf
							
							'check for tag closing self
							If hasTagName
								waitTagClose = True
								isCloseSelf = True
							EndIf
							
							'flag processing of attribute if there is one
							If attributeBuffer.Length processAttributeBuffer = True
							
							'setup that has tag end
							hasTagClose = True
							
							'update line and column
							rawColumn += 1
							
						Case 61'=
							'attribute assignment
							'update line and column
							rawColumn += 1
							
							If hasTagClose or (hasTagName = False And inFormat = False) or hasEquals or hasAttributeId or attributeBuffer.Length = 0
								'error
								If error error.Set("unexpected equals", rawLine, rawColumn, rawIndex)
								Return Null
							EndIf
							
							'set if we need to process the attribute buffer
							processAttributeBuffer = True
							hasEquals = True
							
						Case 62'>
							'close tag
							
							If hasEquals or (hasTagName = False And attributeBuffer.Length = 0)
								'error
								If error error.Set("unexpected close bracket", rawLine, rawColumn, rawIndex)
								Return Null
							EndIf
							
							'flag processing of attribute if there is one
							If attributeBuffer.Length processAttributeBuffer = True
							
							'end the creation of the tag
							processTag = True
							
							'update line and column
							rawColumn += 1
							
						Case 63'?
							'close format
							'check ahead for closing character
							If inFormat = False or rawIndex = raw.Length - 1 or raw[rawIndex + 1] <> 62'>
								'error
								If error error.Set("unexpected questionmark", rawLine, rawColumn, rawIndex)
								Return Null
							EndIf
							
							'end the creation of the tag
							processTag = True
							
							'skip ahead column and index
							rawIndex += 1
							rawColumn += 1
							
						Default
							'no speciffic so check generic
							If rawAsc = 95 or (rawAsc >= 48 and rawAsc <= 57) or (rawAsc >= 65 and rawAsc <= 90) or (rawAsc >= 97 and rawAsc <= 122)
								If hasTagClose = True And hasTagName = True
									'error
									If error error.Set("unexpected character", rawLine, rawColumn, rawIndex)
									Return Null
								EndIf
								
								'need to check for value with no assignment
								If hasAttributeId and hasEquals = False
									'we will add the rawAsc after processing it
									isSingleAttribute = True
									processAttributeBuffer = True
								Else
									'valid character
									attributeBuffer.Add(rawAsc)
								EndIf
								
								'update line and column
								rawColumn += 1
							Else
								'error
								If error error.Set("illegal character", rawLine, rawColumn, rawIndex)
								Return Null
							EndIf
					End
				Else
					'we are in a quote so we should accept anything apart from the quote that started it
					If rawAsc = quoteAsc
						'end of quote
						inQuote = False
						
						'flag for attribute to be processed
						processAttributeBuffer = True
					Else
						'append value for quote
						attributeBuffer.Add(rawAsc)
					EndIf
				EndIf
				
				'look at processing the attribute buffer
				If processAttributeBuffer
					'unflag attribute process
					processAttributeBuffer = False
					
					'so what does teh attribute buffer contain?
					If hasTagName = False And inFormat = False
						'tag name
						If hasTagClose = False
							'this is an opening tag
							tagName = attributeBuffer.value
							
							'create the current tag
							If parent = Null
								If doc = Null
									'create root node
									doc = New XMLDoc(tagName, formatVersion, formatEncoding)
									doc.doc = doc
									doc.parent = Null
									doc.line = rawLine
									doc.column = rawColumn
									doc.offset = rawIndex
									
									current = XMLNode(doc)
								Else
									'error
									If error error.Set("duplicate root", rawLine, rawColumn, rawIndex)
									Return Null
								EndIf
							Else
								'there is a parent so we should add this new node to it
								current = parent.AddChild(tagName)
								current.line = rawLine
								current.column = rawColumn
								current.offset = rawIndex
							EndIf
							
							'set some stuff
							hasTagName = True
						Else
							'this is a closing tag
							tagName = attributeBuffer.value.ToLower()
							
							'check for mismatch
							If parent = Null or tagName <> parent.name
								'error
								If error error.Set("mismatched end tag", rawLine, rawColumn, rawIndex)
								Return Null
							EndIf
							
							'set some stuff
							waitTagClose = True
							hasTagName = True
						EndIf
					Else
						If hasAttributeId = False
							'attribute id
							attributeId = attributeBuffer.value.ToLower()
							hasAttributeId = True
						Else
							'attribute value
							attributeValue = attributeBuffer.value
							hasAttributeValue = True
						EndIf
						
						'see if we need to add the attribute to the tag
						If (processTag And hasAttributeId) or (hasAttributeId And hasAttributeValue) or isSingleAttribute or hasTagClose
							'check on operation
							If inFormat = False
								'set attribute of node
								current.SetAttribute(attributeId, attributeValue)
							Else
								'set attribute of doc
								Select attributeId
									Case "version"
										formatVersion = attributeValue
									Case "encoding"
										formatEncoding = attributeValue
								End
							EndIf
							
							'reset some stuff
							attributeId = ""
							attributeValue = ""
							hasAttributeId = False
							hasAttributeValue = False
							hasEquals = False
						EndIf
					EndIf
					
					'reset the attribute buffer
					attributeBuffer.Clear()
				EndIf
				
				'add the single char back onto attribute buffer
				If isSingleAttribute
					isSingleAttribute = False
					attributeBuffer.Add(rawAsc)
				EndIf
			EndIf
				
			'look at processing a tag, this is delayed until the end so that possible processattributebuffer has a chance to run
			If processTag
				processTag = False
				
				'check for tag operation
				If inFormat = False
					'normal tags
					If hasTagClose = False
						'open tag has finished
						'setup node pointers
						parent = current
						current = Null
					
						'add parent to stack
						stack.AddLast(parent)
					Else
						'close tag has finished
						If isCloseSelf = False
							'the tag does not close itself
							'need to dummp any whitespace into the closing tag
							If whitespaceBuffer.Length
								parent.value += whitespaceBuffer.value
								whitespaceBuffer.Clear()
							EndIf
						
							'remove from stack
							stack.RemoveLast()
							If stack.IsEmpty()
								parent = Null
							Else
								parent = stack.Last()
							EndIf
						Else
							'just unflag this
							isCloseSelf = False
						EndIf
					EndIf
				Else
					'initial format tags (top of document)
					hasFormat = True
					inFormat = False
				EndIf
				
				'reset some stuff
				inTag = False
				hasTagClose = False
				hasTagName = False
				waitTagClose = False
				tagName = ""
			EndIf
		EndIf
	Next
	
	'check for fail!
	If inTag or parent or doc = Null
		'error
		If error error.Set("unexpected end of xml", rawLine, rawColumn, rawIndex)
		Return Null
	EndIf
	
	Return doc
End