Strict

Private

Import bono

Class DummyTestSuite Implements TestSuite
    Field added := New List<TestRunner>

    Method Add:Void(runner:TestRunner)
        added.AddLast(runner)
    End

    Method Run:Void(listener:TestListener)
    End
End

Public

Class TestSuiteHelperTest Extends TestCase
    Method TestAutoDiscover:Void()
        Local suite := New DummyTestSuite()
        Local testsFound := TestSuiteHelper.Autodiscover(suite)

        AssertGreaterThan(0, testsFound)
        AssertEquals(testsFound, suite.added.Count())
    End
End
