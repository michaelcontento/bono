Strict

Private

Import bono.src.exceptions

Public

Class Assert Abstract
    Function AssertEquals:Void(first:Int, second:Int)
        If first = second Then Return
        FailWithDetails("two integers are equal", first, second)
    End

    Function AssertEquals:Void(first:Float, second:Float)
        If first = second Then Return
        FailWithDetails("two floats are equal", first, second)
    End

    Function AssertEquals:Void(first:String, second:String)
        If first = second Then Return
        FailWithDetails("two strings are equal", first, second)
    End

    Function AssertNotEquals:Void(first:Int, second:Int)
        If first <> second Then Return
        Fail("two integers are NOT equal")
    End

    Function AssertNotEquals:Void(first:Float, second:Float)
        If first <> second Then Return
        Fail("two floats are NOT equal")
    End

    Function AssertNotEquals:Void(first:String, second:String)
        If first <> second Then Return
        Fail("two strings are NOT equal")
    End

    Function AssertGreaterThan:Void(expected:Int, actual:Int)
        If expected < actual Then Return
        Fail(actual + " is greater than " + expected)
    End

    Function AssertGreaterThan:Void(expected:Float, actual:Float)
        If expected < actual Then Return
        Fail(actual + " is greater than " + expected)
    End

    Function AssertGreaterThanOrEqual:Void(expected:Int, actual:Int)
        If expected <= actual Then Return
        Fail(actual + " is greater than or equal to " + expected)
    End

    Function AssertLessThan:Void(expected:Int, actual:Int)
        If expected > actual Then Return
        Fail(actual + " is less than " + expected)
    End

    Function AssertLessThan:Void(expected:Float, actual:Float)
        If expected > actual Then Return
        Fail(actual + " is less than " + expected)
    End

    Function AssertLessThanOrEqual:Void(expected:Int, actual:Int)
        If expected >= actual Then Return
        Fail(actual + " is less than or equal to " + expected)
    End

    Function AssertStringStartsWith:Void(needle:String, haystack:String)
        If haystack.StartsWith(needle) Then Return
        FailWithDetails(
            "a string starts with a given prefix",
            needle, haystack)
    End

    Function AssertStringNotStartsWith:Void(needle:String, haystack:String)
        If Not haystack.StartsWith(needle) Then Return
        FailWithDetails(
            "a string does NOT starts with a given prefix",
            needle, haystack)
    End

    Function AssertStringEndsWith:Void(needle:String, haystack:String)
        If haystack.EndsWith(needle) Then Return
        FailWithDetails(
            "a string ends with a given prefix",
            needle, haystack)
    End

    Function AssertStringNotEndsWith:Void(needle:String, haystack:String)
        If Not haystack.EndsWith(needle) Then Return
        FailWithDetails(
            "a string does NOT ends with a given prefix",
            needle, haystack)
    End

    Function AssertStringContains:Void(needle:String, haystack:String)
        If haystack.Contains(needle) Then Return
        FailWithDetails(
            "a string contains a given sub-string",
            needle, haystack)
    End

    Function AssertStringNotContains:Void(needle:String, haystack:String)
        If Not haystack.Contains(needle) Then Return
        FailWithDetails(
            "a string does NOT contains a given sub-string",
            needle, haystack)
    End

    Function AssertTrue:Void(condition:Bool)
        If condition Then Return
        Fail("false is true")
    End

    Function AssertFalse:Void(condition:Bool)
        If Not condition Then Return
        Fail("true is false")
    End

    Function AssertNull:Void(obj:Object)
        If obj = Null Then Return
        Fail("some object is null")
    End

    Function AssertNotNull:Void(obj:Object)
        If obj <> Null Then Return
        Fail("some object is NOT null")
    End

    Private

    Function Fail:Void(message:String)
        Throw New AssertionFailedException("Failed asserting that " + message)
    End

    Function FailWithDetails:Void(message:String, expected:String, actual:String)
        Fail(message + "~n" +
            "Expected: " + expected + "~n" +
            "Actual  : " + actual)
    End
End
