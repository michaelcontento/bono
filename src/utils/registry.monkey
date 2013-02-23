Strict

Import bono

Public

Class Registry<T> Abstract
    Private

    Global store:StringMap<T> = New StringMap<T>()

    Public

    Function Get:T(key:String)
        If store.Contains(key) Then Return store.Get(key)
        Throw New RegistryValueNotFoundException(
            "there is no value stored for the given key '" + key + "'")
    End

    Function Get:T(key:String, fallback:T)
        Try
            Return Get(key)
        Catch ex:RegistryValueNotFoundException
            ' Nothing special to do here ... simply return the given default
        End
        Return fallback
    End

    Function Keys:MapKeys<String,T>()
        Return store.Keys()
    End

    Function Set:Void(key:String, value:T)
        store.Set(key, value)
    End

    Function Clear:Void(key:String)
        store.Remove(key)
    End

    Function ClearAll:Void()
        store.Clear()
    End
End
