Strict

Class Score<T>
    Field key:String
    Field value:T

    Method New(key:String, value:T)
        Self.key = key
        Self.value = value
    End
End

Class IntScore Extends Score<Int>
End

Class FloatScore Extends Score<Float>
End

