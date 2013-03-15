Strict

Private

Import bono

Class PersitableDummy Implements Persistable
    Field text:String

    Method FromString:Void(text:String)
        Self.text = text
    End

    Method ToString:String()
        Return text
    End
End

Public

Class StateStoreTest Extends TestCase
    Method TestSaveAndLoad:Void()
        Local obj := New PersitableDummy()
        obj.text = "hello world"
        StateStore.Save(obj)

        obj.text = ""
        StateStore.Load(obj)

        AssertEquals("hello world", obj.text)
    End
End
