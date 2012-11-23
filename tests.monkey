Strict

Import bono
Import tests.utils.vector2dtest

Function Main:Int()
    Local suite:TestSuite = New TestSuite()
    suite.Autodiscover()
    suite.Run(New TestListenerSimple())
    Return 0
End
