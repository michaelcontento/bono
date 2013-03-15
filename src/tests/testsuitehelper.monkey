Strict

Private

Import bono
Import reflection

Public

Class TestSuiteHelper Abstract
    Function Autodiscover:Int(suite:TestSuite)
        Local testsFound:Int

        For Local classInfo:ClassInfo = EachIn GetClasses()
            If classInfo.Name().EndsWith("Test")
                testsFound += 1
                suite.Add(New TestRunner(classInfo.Name()))
            End
        End

        Return testsFound
    End
End
