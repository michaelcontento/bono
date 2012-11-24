Strict

Private

Import bono
Import tests.utils.vector2dtest
Import tests.tests.asserttest

Public

Function Main:Int()
    Local report:TestReportSimple = New TestReportSimple()
    report.verbose = False

    Local suite:TestSuite = New TestSuite()
    suite.Autodiscover()
    suite.Run(report)
    Return 0
End
