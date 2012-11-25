Strict

Private

Import bono
Import tests.payment.paymentmanagertest
Import tests.payment.paymentprovideraliastest
Import tests.payment.paymentproviderautounlocktest
Import tests.tests.asserttest
Import tests.tests.testcasetest
Import tests.tests.testsuitetest
Import tests.utils.vector2dtest

Public

Function Main:Int()
    Local report:TestReportSimple = New TestReportSimple()
    report.verbose = False

    Local suite:TestSuite = New TestSuite()
    suite.Autodiscover()
    suite.Run(report)
    Return 0
End
