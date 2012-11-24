Strict

Private

Import bono

Public

Class AssertTest Extends TestCase
    Method TestAssertEqualsInt:Void()
        AssertEquals(1, 1)
    End

    Method TestAssertEqualsFloat:Void()
        AssertEquals(2.0, 2.0)
    End

    Method TestAssertEqualsString:Void()
        AssertEquals("foo", "foo")
    End

    Method TestAssertEqualsFailureMessageInt:Void()
        Try
            AssertEquals(1, 2)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("two integers are equal", ex.ToString())
            AssertStringContains("Expected: 1", ex.ToString())
            AssertStringContains("Actual  : 2", ex.ToString())
        End
    End

    Method TestAssertEqualsFailureMessageFloat:Void()
        Try
            AssertEquals(1.2, 2.3)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("two floats are equal", ex.ToString())
            ' Only check to the decimal seperator due to float precision
            AssertStringContains("Expected: 1.", ex.ToString())
            AssertStringContains("Actual  : 2.", ex.ToString())
        End
    End

    Method TestAssertEqualsFailureMessageString:Void()
        Try
            AssertEquals("foo", "bar")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("two strings are equal", ex.ToString())
            AssertStringContains("Expected: foo", ex.ToString())
            AssertStringContains("Actual  : bar", ex.ToString())
        End
    End

    Method TestAssertNotEqualsInt:Void()
        AssertNotEquals(1, 2)
    End

    Method TestAssertNotEqualsFloat:Void()
        AssertNotEquals(2.0, 3.0)
    End

    Method TestAssertNotEqualsString:Void()
        AssertNotEquals("foo", "baz")
    End

    Method TestAssertNotEqualsFailureMessageInt:Void()
        Try
            AssertNotEquals(1, 1)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("two integers are NOT equal", ex.ToString())
        End
    End

    Method TestAssertNotEqualsFailureMessageFloats:Void()
        Try
            AssertNotEquals(1.2, 1.2)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("two floats are NOT equal", ex.ToString())
        End
    End

    Method TestAssertNotEqualsFailureMessageStrings:Void()
        Try
            AssertNotEquals("foo", "foo")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("two strings are NOT equal", ex.ToString())
        End
    End

    Method TestAssertGreaterThanInt:Void()
        AssertGreaterThan(1, 2)
    End

    Method TestAssertGreaterThanFloat:Void()
        AssertGreaterThan(1.0, 1.2)
    End

    Method TestAssertGreaterThanOrEqualInt:Void()
        AssertGreaterThanOrEqual(1, 2)
        AssertGreaterThanOrEqual(1, 1)
    End

    Method TestAssertGreaterThanOrEqualFloat:Void()
        AssertGreaterThanOrEqual(1.0, 1.2)
        AssertGreaterThanOrEqual(1.0, 1.0)
    End

    Method TestAssertLessThanInt:Void()
        AssertLessThan(2, 1)
    End

    Method TestAssertLessThanFloat:Void()
        AssertLessThan(1.2, 1.0)
    End

    Method TestAssertLessThanOrEqualInt:Void()
        AssertLessThanOrEqual(2, 1)
        AssertLessThanOrEqual(2, 2)
    End

    Method TestAssertLessThanOrEqualFloat:Void()
        AssertLessThanOrEqual(1.2, 1.0)
        AssertLessThanOrEqual(1.2, 1.2)
    End

    Method TestAssertStringStartsWith:Void()
        AssertStringStartsWith("foo", "foo...")
    End

    Method TestAssertStringNotStartsWith:Void()
        AssertStringNotStartsWith("foo", "bar")
    End

    Method TestAssertStringEndsWith:Void()
        AssertStringEndsWith("foo", "...foo")
    End

    Method TestAssertStringNotEndsWith:Void()
        AssertStringNotEndsWith("foo", "bar")
    End

    Method TestAssertStringContains:Void()
        AssertStringContains("foo", "... foo ...")
    End

    Method TestAssertStringNotContains:Void()
        AssertStringNotContains("foo", "...")
    End

    Method TestAssertTrue:Void()
        AssertTrue(True)
    End

    Method TestAssertFalse:Void()
        AssertFalse(False)
    End

    Method TestAssertNull:Void()
        AssertNull(Null)
    End

    Method TestAssertNotNull:Void()
        AssertNotNull(New Object())
    End

    Method TestIncomplete:Void()
        MarkTestIncomplete("Not all messages are tested")
    End
End
