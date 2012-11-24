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

    Method TestAssertGreaterThanMessageInt:Void()
        Try
            AssertGreaterThan(2, 1)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains(1 + " is greater than " + 2, ex.ToString())
        End
    End

    Method TestAssertGreaterThanMessageFloat:Void()
        Try
            AssertGreaterThan(2.0, 1.0)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains(1.0 + " is greater than " + 2.0, ex.ToString())
        End
    End

    Method TestAssertGreaterThanOrEqualInt:Void()
        AssertGreaterThanOrEqual(1, 2)
        AssertGreaterThanOrEqual(1, 1)
    End

    Method TestAssertGreaterThanOrEqualFloat:Void()
        AssertGreaterThanOrEqual(1.0, 1.2)
        AssertGreaterThanOrEqual(1.0, 1.0)
    End

    Method TestAssertGreaterThanOrEqualMessageInt:Void()
        Try
            AssertGreaterThanOrEqual(2, 1)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains(1 + " is greater than or equal to " + 2, ex.ToString())
        End
    End

    Method TestAssertGreaterThanOrEqualMessageFloat:Void()
        Try
            AssertGreaterThanOrEqual(2.0, 1.0)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains(1.0 + " is greater than or equal to " + 2.0, ex.ToString())
        End
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

    Method TestAssertLessThanMessageInt:Void()
        Try
            AssertLessThan(1, 2)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains(2 + " is less than " + 1, ex.ToString())
        End
    End

    Method TestAssertLessThanMessageFloat:Void()
        Try
            AssertLessThan(1.0, 2.0)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains(2.0 + " is less than " + 1.0, ex.ToString())
        End
    End

    Method TestAssertLessThanOrEqualFloat:Void()
        AssertLessThanOrEqual(1.2, 1.0)
        AssertLessThanOrEqual(1.2, 1.2)
    End

    Method TestAssertLessThanOrEqualMessageInt:Void()
        Try
            AssertLessThanOrEqual(1, 2)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains(2 + " is less than or equal to " + 1, ex.ToString())
        End
    End

    Method TestAssertLessThanOrEqualMessageFloat:Void()
        Try
            AssertLessThanOrEqual(1.0, 2.0)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains(2.0 + " is less than or equal to " + 1.0, ex.ToString())
        End
    End

    Method TestAssertStringStartsWith:Void()
        AssertStringStartsWith("foo", "foo...")
    End

    Method TestAssertStringStartsWithMessage:Void()
        Try
            AssertStringStartsWith("foo", "...foo")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("a string starts with a given prefix", ex.ToString())
            AssertStringContains("Expected: foo", ex.ToString())
            AssertStringContains("Actual  : ...foo", ex.ToString())
        End
    End

    Method TestAssertStringNotStartsWith:Void()
        AssertStringNotStartsWith("foo", "bar")
    End

    Method TestAssertStringNotStartsWithMessage:Void()
        Try
            AssertStringNotStartsWith("foo", "foo...")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("a string does NOT starts with a given prefix", ex.ToString())
            AssertStringContains("Expected: foo", ex.ToString())
            AssertStringContains("Actual  : foo...", ex.ToString())
        End
    End

    Method TestAssertStringEndsWith:Void()
        AssertStringEndsWith("foo", "...foo")
    End

    Method TestAssertStringEndsWithMessage:Void()
        Try
            AssertStringEndsWith("foo", "foo...")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("a string ends with a given prefix", ex.ToString())
            AssertStringContains("Expected: foo", ex.ToString())
            AssertStringContains("Actual  : foo...", ex.ToString())
        End
    End

    Method TestAssertStringNotEndsWith:Void()
        AssertStringNotEndsWith("foo", "bar")
    End

    Method TestAssertStringNotEndsWithMessage:Void()
        Try
            AssertStringNotEndsWith("foo", "...foo")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("a string does NOT ends with a given prefix", ex.ToString())
            AssertStringContains("Expected: foo", ex.ToString())
            AssertStringContains("Actual  : ...foo", ex.ToString())
        End
    End

    Method TestAssertStringContains:Void()
        AssertStringContains("foo", "...foo...")
    End

    Method TestAssertStringContainsMessage:Void()
        Try
            AssertStringContains("foo", "...bar...")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("a string contains a given sub-string", ex.ToString())
            AssertStringContains("Expected: foo", ex.ToString())
            AssertStringContains("Actual  : ...bar...", ex.ToString())
        End
    End

    Method TestAssertStringNotContains:Void()
        AssertStringNotContains("foo", "...")
    End

    Method TestAssertStringNotContainsMessage:Void()
        Try
            AssertStringNotContains("foo", "...foo...")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("a string does NOT contains a given sub-string", ex.ToString())
            AssertStringContains("Expected: foo", ex.ToString())
            AssertStringContains("Actual  : ...foo...", ex.ToString())
        End
    End

    Method TestAssertTrue:Void()
        AssertTrue(True)
    End

    Method TestAssertTrueMessage:Void()
        Try
            AssertTrue(False)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("false is true", ex.ToString())
        End
    End

    Method TestAssertFalse:Void()
        AssertFalse(False)
    End

    Method TestAssertFalseMessage:Void()
        Try
            AssertFalse(True)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("true is false", ex.ToString())
        End
    End

    Method TestAssertNull:Void()
        AssertNull(Null)
    End

    Method TestAssertNullMessage:Void()
        Try
            AssertNull(New Object())
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("some object is null", ex.ToString())
        End
    End

    Method TestAssertNotNull:Void()
        AssertNotNull(New Object())
    End

    Method TestAssertNotNullMessage:Void()
        Try
            AssertNotNull(Null)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            AssertStringContains("some object is NOT null", ex.ToString())
        End
    End
End
