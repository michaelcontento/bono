Strict

Private

Import arrayhelper

Public

Class StringHelper Abstract
    Function Randomize:String(input:String)
        Local split:String[] = input.Split("")
        ArrayHelper<String>.Randomize(split)
        Return "".Join(split)
    End

    Function CountLines:Int(input:String)
        Return input.Split("~n").Length()
    End

    Function Join:String(separator:String, pieces:Int[])
        Local result:String = ""

        For Local i:Int = 0 Until pieces.Length()
            result += pieces[i] + separator
        End

        If separator.Length() = 0
            Return result
        Else
            Return result[..separator.Length() * -1]
        End
    End

    Function Join:String(separator:String, pieces:Float[])
        Local result:String = ""

        For Local i:Int = 0 Until pieces.Length()
            result += pieces[i] + separator
        End

        If separator.Length() = 0
            Return result
        Else
            Return result[..separator.Length() * -1]
        End
    End
End
