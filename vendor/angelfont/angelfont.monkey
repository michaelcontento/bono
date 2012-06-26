Strict

Import mojo


Import char
Import kernpair

'PC: http://www.angelcode.com/products/bmfont/
'Mac/PC: http://slick.cokeandcode.com/demos/hiero.jnlp

Class AngelFont
	Private
	
	Global _list:StringMap<AngelFont> = New StringMap<AngelFont>
	
	Field image:Image	
'	Field blockSize:Int
	Field chars:Char[256]
	Field kernPairs:StringMap<KernPair> = New StringMap<KernPair>
'	Field section:String
	Field iniText:String

	Field xOffset:Int
	Field yOffset:Int
	
	Field prevMouseDown:Bool = False

	Public
	Const ALIGN_LEFT:Int = 0
	Const ALIGN_CENTER:Int = 1
	Const ALIGN_RIGHT:Int = 2
	
	Global current:AngelFont
	Global error:String
	
	Field name:String
	Field useKerning:Bool = True

	Field lineGap:Int = 5
	Field height:Int = 0
	Field heightOffset:Int = 9999
	Field scrollY:Int = 0
	
	Field italicSkew:Float = 0.25
	
	Method New(url:String="")
		If url <> ""
			Self.LoadFont(url)
			Self.name = url
			_list.Insert(url,Self)
		Endif
	End Method
	
	Method GetChars:Char[]()
		Return chars
	End

	Method LoadFont:Void(url:String)
		
		error = ""
		current = Self
		iniText = LoadString(url+".txt")
		Local lines:= iniText.Split(String.FromChar(10))
		For Local line:= Eachin lines
		
			line=line.Trim()
			
			If line.StartsWith("id,") Or line = "" Continue
			If line.StartsWith("first,")
'				kernPairs = New StringMap<KernPair>
				Continue
			Endif
			Local data$[] = line.Split(",")
			
			For Local i:=0 Until data.Length
				data[i]=data[i].Trim()
			Next
			
			error += data.Length+","	'+"-"+line
			If data.Length > 0
				If data.Length = 3
	'				kerning.Insert(data[0]+"_"+data[1], New Kerning(Int(data[0]), Int(data[1]), Int(data[2]))
					kernPairs.Insert(String.FromChar(Int(data[0]))+"_"+String.FromChar(Int(data[1])), New KernPair(Int(data[0]), Int(data[1]), Int(data[2])))
				Else
					If data.Length >= 8
						chars[Int(data[0])] = New Char(Int(data[1]), Int(data[2]), Int(data[3]), Int(data[4]),  Int(data[5]),  Int(data[6]),  Int(data[7]))
						Local ch := chars[Int(data[0])]
						If ch.height > Self.height Self.height = ch.height
						If ch.yOffset < Self.heightOffset Self.heightOffset = ch.yOffset
		'				ch.asc = Int(data[0])
					Endif
				Endif
			Endif
		Next
		
		image = LoadImage(url+".png")
	End Method
	
	Method Use:Void()
		current = Self
	End Method
	
	Function GetCurrent:AngelFont()
		Return current
	End
	
	Function Use:AngelFont(name:String)
		For Local af := Eachin _list
			If af.name = name
				current = af
				Return af
			End
		Next
		Return Null
	End
	
	Method DrawItalic:Void(txt$,x#,y#)
		Local th#=TextHeight(txt)
		
		PushMatrix
			Transform 1,0,-italicSkew,1, x+th*italicSkew,y
			DrawText txt,0,0
		PopMatrix		
	End 
	
	Method DrawBold:Void(txt:String, x:Int, y:Int)
		DrawText(txt, x,y)
		DrawText(txt, x+1,y)
	End
	
	
	Method DrawText:Void(txt:String, x:Int, y:Int)
		Local prevChar:String = ""
		xOffset = 0
		
		For Local i:= 0 Until txt.Length
			Local asc:Int = txt[i]
			Local ac:Char = chars[asc]
			Local thisChar:String = String.FromChar(asc)
			If ac  <> Null
				If useKerning
					Local key:String = prevChar+"_"+thisChar
					If kernPairs.Contains(key)
						xOffset += kernPairs.Get(key).amount
					Endif
				Endif
				ac.Draw(image, x+xOffset,y)
				xOffset += ac.xAdvance
				prevChar = thisChar
			Endif
		Next
	End Method
	
	Method DrawText:Void(txt:String, x:Int, y:Int, align:Int)
		xOffset = 0
		Select align
			Case ALIGN_CENTER
				DrawText(txt,x-(TextWidth(txt)/2),y)
			Case ALIGN_RIGHT
				DrawText(txt,x-TextWidth(txt),y)
			Case ALIGN_LEFT
'			Default
				DrawText(txt,x,y)
		End Select
	End Method

	Method DrawHTML:Void(txt:String, x:Int, y:Int)
		Local prevChar:String = ""
		xOffset = 0
		Local italic:Bool = False
		Local bold:Bool = False
		Local th#=TextHeight(txt)
		
		For Local i:= 0 Until txt.Length
			'error += txt[i..i+1]
			
			While txt[i..i+1] = "<"
				Select txt[i+1..i+3]
					Case "i>"
						italic = True
						i += 3
					Case "b>"
						bold = True
						i += 3
					Default
						Select txt[i+1..i+4]
							Case "/i>"
								italic = False
								i += 4
							Case "/b>"
								bold = False
								i += 4
						End
				End
				If i >= txt.Length
					Return
				End
			Wend
			Local asc:Int = txt[i]
			Local ac:Char = chars[asc]
			Local thisChar:String = String.FromChar(asc)
			If ac  <> Null
				If useKerning
					Local key:String = prevChar+"_"+thisChar
					If kernPairs.Contains(key)
						xOffset += kernPairs.Get(key).amount
					Endif
				Endif
				If italic = False
					ac.Draw(image, x+xOffset,y)
					If bold
						ac.Draw(image, x+xOffset+1,y)
					End
				Else
					PushMatrix
						Transform 1,0,-italicSkew,1, (x+xOffset)+th*italicSkew,y
						ac.Draw(image, 0,0)
						If bold
							ac.Draw(image, 1,0)
						Endif					
					PopMatrix		
				End	
				xOffset += ac.xAdvance
				prevChar = thisChar
			Endif
		Next
	End Method
	
	Method DrawHTML:Void(txt:String, x:Int, y:Int, align:Int)
		xOffset = 0
		Select align
			Case ALIGN_CENTER
				DrawHTML(txt,x-(TextWidth(StripHTML(txt))/2),y)
			Case ALIGN_RIGHT
				DrawHTML(txt,x-TextWidth(StripHTML(txt)),y)
			Case ALIGN_LEFT
'			Default
				DrawHTML(txt,x,y)
		End Select
	End Method
	
	Function StripHTML:String(txt:String)
		Local plainText:String = txt.Replace("</","<")
		plainText = plainText.Replace("<b>","")
		Return plainText.Replace("<i>","")
	End

	Method TextWidth:Int(txt:String)
		Local prevChar:String = ""
		Local width:Int = 0
		For Local i:= 0 Until txt.Length
			Local asc:Int = txt[i]
			Local ac:Char = chars[asc]
			Local thisChar:String = String.FromChar(asc)
			If ac  <> Null
				If useKerning
					Local key:String = prevChar+"_"+thisChar
					If kernPairs.Contains(key)
						'Print key+" "+kerning.Get(key).amount
						width += kernPairs.Get(key).amount
					Endif
				Endif
				'ch.Draw(image, x+xOffset,y)
				width += ac.xAdvance
				prevChar = thisChar
			Endif
		Next
		Return width
	End Method
	
	Method TextHeight:Int(txt:String)
		Local h:Int = 0
		For Local i:= 0 Until txt.Length
			Local asc:Int = txt[i]
			Local ac:Char = chars[asc]
			If ac.height > h h = ac.height
		Next
		Return h
	End

End Class
