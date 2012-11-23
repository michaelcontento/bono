Strict

Private

Import bono.src.exceptions

Public

Class Assert Abstract
    Method assertEquals:Void(first:Int, second:Int)
        If first = second Then Return
        Throw New AssertionFailedException(first + " is not equal to " + second)
    End

    Method assertEquals:Void(first:Float, second:Float)
        If first = second Then Return
        Throw New AssertionFailedException(first + " is not equal to " + second)
    End

    Method assertEquals:Void(first:String, second:String)
        If first = second Then Return
        Throw New AssertionFailedException(first + " is not equal to " + second)
    End

    Method assertTrue:Void(condition:Bool)
        If condition Then Return
        Throw New AssertionFailedException()
    End

    Method assertFalse:Void(condition:Bool)
        If Not condition Then Return
        Throw New AssertionFailedException()
    End
End
