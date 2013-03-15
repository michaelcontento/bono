Strict

Private

Import mojo
Import bono
Import reflection

Public

Class AppTestSuite Extends mojo.App Implements TestSuite
    Private

    Field listener:TestListener
    Field runnerStack := New Stack<TestRunner>()
    Field initialized := False

    Public

    Method OnCreate:Int()
        initialized = True
        SetUpdateRate(60)
        Return 0
    End

    Method OnRender:Int()
        Cls()

        If Not initialized Then Return 0
        If Not listener Then Return 0

        If runnerStack.Length() > 0
            runnerStack.Pop().Run(listener)
            Return 0
        End

        listener.EndTestSuite(Self)
        Error ""
        Return 0
    End

    Method Add:Void(runner:TestRunner)
        runnerStack.Push(runner)
    End

    Method Run:Void(listener:TestListener)
        Self.listener = listener
        listener.StartTestSuite(Self)
    End
End
