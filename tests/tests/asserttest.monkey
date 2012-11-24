Strict

Private

Import bono

Public

Class AssertTest Extends TestCase
    Method TestAssertEqualsInt:Void()
        Assert.AssertEquals(1, 1)
    End

    Method TestAssertEqualsFloat:Void()
        Assert.AssertEquals(2.0, 2.0)
    End

    Method TestAssertEqualsString:Void()
        Assert.AssertEquals("foo", "foo")
    End

    Method TestAssertEqualsFailureMessageInt:Void()
        Try
            Assert.AssertEquals(1, 2)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            Assert.AssertStringContains("two integers are equal", ex.ToString())
            Assert.AssertStringContains("Expected: 1", ex.ToString())
            Assert.AssertStringContains("Actual  : 2", ex.ToString())
        End
    End

    Method TestAssertEqualsFailureMessageFloat:Void()
        Try
            Assert.AssertEquals(1.2, 2.3)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            Assert.AssertStringContains("two floats are equal", ex.ToString())
            ' Only check to the decimal seperator due to float precision
            Assert.AssertStringContains("Expected: 1.", ex.ToString())
            Assert.AssertStringContains("Actual  : 2.", ex.ToString())
        End
    End

    Method TestAssertEqualsFailureMessageString:Void()
        Try
            Assert.AssertEquals("foo", "bar")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            Assert.AssertStringContains("two strings are equal", ex.ToString())
            Assert.AssertStringContains("Expected: foo", ex.ToString())
            Assert.AssertStringContains("Actual  : bar", ex.ToString())
        End
    End

    Method TestAssertNotEqualsInt:Void()
        Assert.AssertNotEquals(1, 2)
    End

    Method TestAssertNotEqualsFloat:Void()
        Assert.AssertNotEquals(2.0, 3.0)
    End

    Method TestAssertNotEqualsString:Void()
        Assert.AssertNotEquals("foo", "baz")
    End

    Method TestAssertNotEqualsFailureMessageInt:Void()
        Try
            Assert.AssertNotEquals(1, 1)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            Assert.AssertStringContains("two integers are NOT equal", ex.ToString())
        End
    End

    Method TestAssertNotEqualsFailureMessageFloats:Void()
        Try
            Assert.AssertNotEquals(1.2, 1.2)
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            Assert.AssertStringContains("two floats are NOT equal", ex.ToString())
        End
    End

    Method TestAssertNotEqualsFailureMessageStrings:Void()
        Try
            Assert.AssertNotEquals("foo", "foo")
            Fail("AssertionFailedException expected")
        Catch ex:AssertionFailedException
            Assert.AssertStringContains("two strings are NOT equal", ex.ToString())
        End
    End

    Method TestAssertGreaterThanInt:Void()
        Assert.AssertGreaterThan(1, 2)
    End

    Method TestAssertGreaterThanFloat:Void()
        Assert.AssertGreaterThan(1.0, 1.2)
    End

    Method TestAssertGreaterThanOrEqualInt:Void()
        Assert.AssertGreaterThanOrEqual(1, 2)
        Assert.AssertGreaterThanOrEqual(1, 1)
    End

    Method TestAssertGreaterThanOrEqualFloat:Void()
        Assert.AssertGreaterThanOrEqual(1.0, 1.2)
        Assert.AssertGreaterThanOrEqual(1.0, 1.0)
    End

    Method TestAssertLessThanInt:Void()
        Assert.AssertLessThan(2, 1)
    End

    Method TestAssertLessThanFloat:Void()
        Assert.AssertLessThan(1.2, 1.0)
    End

    Method TestAssertLessThanOrEqualInt:Void()
        Assert.AssertLessThanOrEqual(2, 1)
        Assert.AssertLessThanOrEqual(2, 2)
    End

    Method TestAssertLessThanOrEqualFloat:Void()
        Assert.AssertLessThanOrEqual(1.2, 1.0)
        Assert.AssertLessThanOrEqual(1.2, 1.2)
    End

    Method TestAssertStringStartsWith:Void()
        Assert.AssertStringStartsWith("foo", "foo...")
    End

    Method TestAssertStringNotStartsWith:Void()
        Assert.AssertStringNotStartsWith("foo", "bar")
    End

    Method TestAssertStringEndsWith:Void()
        Assert.AssertStringEndsWith("foo", "...foo")
    End

    Method TestAssertStringNotEndsWith:Void()
        Assert.AssertStringNotEndsWith("foo", "bar")
    End

    Method TestAssertStringContains:Void()
        Assert.AssertStringContains("foo", "... foo ...")
    End

    Method TestAssertStringNotContains:Void()
        Assert.AssertStringNotContains("foo", "...")
    End

    Method TestAssertTrue:Void()
        Assert.AssertTrue(True)
    End

    Method TestAssertFalse:Void()
        Assert.AssertFalse(False)
    End

    Method TestAssertNull:Void()
        Assert.AssertNull(Null)
    End

    Method TestAssertNotNull:Void()
        Assert.AssertNotNull(New Object())
    End
End
