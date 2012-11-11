Strict

Private

Import bono.io
Import config

Public

Class ConfigStore<T> Implements Persistable
    Private

    Const SEPARATOR:String = "--CONFIG::SEPARATOR--"
    Const DELIMITER:String = "--CONFIG::DELIMITER--"

    Public

    Method ToString:String()
        Local result:String = ""

        For Local key:String = EachIn Config<T>.Keys()
            result += key
            result += DELIMITER
            result += Config<T>.Get(key)
            result += SEPARATOR
        End

        Return result[..-SEPARATOR.Length()]
    End

    Method FromString:Void(data:String)
        If data.Length() = 0 Then Return
        Local records:String[] = data.Split(SEPARATOR)

        For Local record:String = EachIn records
            Local parts:String[] = record.Split(DELIMITER)
            Config<T>.Set(parts[0], T(parts[1]))
        End
    End

    Function LoadStateStore:Void()
        Local tmp:ConfigStore<T> = New ConfigStore<T>()
        StateStore.Load(tmp)
    End

    Function SaveStateStore:Void()
        Local tmp:ConfigStore<T> = New ConfigStore<T>()
        StateStore.Save(tmp)
    End
End
