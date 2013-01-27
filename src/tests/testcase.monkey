Strict

Private

Import bono

Public

Class TestCase Extends Assert Abstract
    Method SetUp:Void()
    End

    Method TearDown:Void()
    End

    Method MarkTestSkipped:Void(message:String="")
        Throw New TestSkippedException(message)
    End

    Method MarkTestIncomplete:Void(message:String="")
        Throw New TestIncompleteException(message)
    End

    Method Fail:Void(message:String)
        Throw New TestFailedException(message)
    End
End
