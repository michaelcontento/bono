Strict

Private

Import bono

Public

Class RegistryStore<T> Implements Persistable
    Private

    Const SEPARATOR:String = "--CONFIG::SEPARATOR--"
    Const DELIMITER:String = "--CONFIG::DELIMITER--"

    Public

    Method ToString:String()
        Local result:String = ""

        For Local key:String = EachIn Registry<T>.Keys()
            result += key
            result += DELIMITER
            result += Registry<T>.Get(key)
            result += SEPARATOR
        End

        Return result[..-SEPARATOR.Length()]
    End

    Method FromString:Void(data:String)
        If data.Length() = 0 Then Return
        Local records:String[] = data.Split(SEPARATOR)

        For Local record:String = EachIn records
            Local parts:String[] = record.Split(DELIMITER)
            Registry<T>.Set(parts[0], T(parts[1]))
        End
    End

    Function LoadStateStore:Void()
        Local tmp:RegistryStore<T> = New RegistryStore<T>()
        StateStore.Load(tmp)
    End

    Function SaveStateStore:Void()
        Local tmp:RegistryStore<T> = New RegistryStore<T>()
        StateStore.Save(tmp)
    End
End
