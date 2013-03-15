Strict

Private

Import bono
Import reflection

Public

Class SimpleTestSuite Implements TestSuite
    Private

    Field runnerStack:Stack<TestRunner> = New Stack<TestRunner>()

    Public

    Method Add:Void(runner:TestRunner)
        runnerStack.Push(runner)
    End

    Method Run:Void(listener:TestListener)
        listener.StartTestSuite(Self)

        While runnerStack.Length() > 0
            runnerStack.Pop().Run(listener)
        End

        listener.EndTestSuite(Self)
    End
End
