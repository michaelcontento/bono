Strict

Private

Import assert
Import testincompleteexception
Import testskippedexception

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
End
