Strict

Private

Import bono
Import reflection

Public

Class TestSuite
    Private

    Field runnerStack:Stack<TestRunner> = New Stack<TestRunner>()

    Public

    Method Add:Void(runner:TestRunner)
        runnerStack.Push(runner)
    End

    Method Autodiscover:Int()
        Local testsFound:Int

        For Local classInfo:ClassInfo = EachIn GetClasses()
            If classInfo.Name().EndsWith("Test")
                testsFound += 1
                runnerStack.Push(New TestRunner(classInfo.Name()))
            End
        End

        Return testsFound
    End

    Method Run:Void(listener:TestListener)
        listener.StartTestSuite(Self)

        While runnerStack.Length() > 0
            runnerStack.Pop().Run(listener)
        End

        listener.EndTestSuite(Self)
    End
End
