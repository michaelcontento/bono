Strict

Private

Import bono
Import bono.testimport

Public

Function Main:Int()
    Local report:TestReportSimple = New TestReportSimple()
    report.verbose = False

    Local suite:TestSuite = New AppTestSuite()
    TestSuiteHelper.Autodiscover(suite)

    Try
        suite.Run(report)
    Catch ex:Exception
        Error ex
    End
    Return 0
End
