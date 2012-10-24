Strict

Private

Import arrayhelper

Public

Class StringHelper Abstract
    Function Randomize:String(input:String)
        Local split:String[] = input.Split("")
        ArrayHelper.Randomize(split)
        Return "".Join(split)
    End
End
