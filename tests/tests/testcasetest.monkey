Strict

Private

Import bono

Class DummyTestCase Extends TestCase
End

Public

Class TestCaseTest Extends TestCase
    Method TestExtendsAssert:Void()
        AssertNotNull(Assert(New DummyTestCase()))
    End

    Method TestSetUp:Void()
        Local test:DummyTestCase = New DummyTestCase()
        test.SetUp()
    End

    Method TestTearDown:Void()
        Local test:DummyTestCase = New DummyTestCase()
        test.TearDown()
    End

    Method TestMarkTestSkipped:Void()
        Local test:DummyTestCase = New DummyTestCase()
        Try
            test.MarkTestSkipped()
            Fail("TestSkippedException expected")
        Catch ex:TestSkippedException
            AssertEquals("", ex.message)
        End
    End

    Method TestMarkTestSkippedWithMessage:Void()
        Local test:DummyTestCase = New DummyTestCase()
        Try
            test.MarkTestSkipped("foo bar")
            Fail("TestSkippedException expected")
        Catch ex:TestSkippedException
            AssertEquals("foo bar", ex.message)
        End
    End

    Method TestMarkTestIncomplete:Void()
        Local test:DummyTestCase = New DummyTestCase()
        Try
            test.MarkTestIncomplete()
            Fail("TestIncompleteException expected")
        Catch ex:TestIncompleteException
            AssertEquals("", ex.message)
        End
    End

    Method TestMarkTestIncompleteWithMessage:Void()
        Local test:DummyTestCase = New DummyTestCase()
        Try
            test.MarkTestIncomplete("foo bar")
            Fail("TestIncompleteException expected")
        Catch ex:TestIncompleteException
            AssertEquals("foo bar", ex.message)
        End
    End

    Method TestFail:Void()
        Local test:DummyTestCase = New DummyTestCase()
        Try
            test.Fail("foo bar")
            Error("TestFailedException expected")
        Catch ex:TestFailedException
            AssertEquals("foo bar", ex.message)
        End
    End
End
