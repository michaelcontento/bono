# Test

Very simple test framework inspired (just a little bit) by [PHPUnit][].

## Overview

![Class diagramm](http://yuml.me/5a92f96a)

### TestCase

Every real test case must extend this class. This class also inhertis from
`Assert`, so that it's easy to make assertions and you don't have to repeat
the classname all the time (=> `AssertEquals` instead of `Assert.AssertEquals`).

### TestRunner

This thing is responsible for executing all tests within one given test case.
But it's not as simple as it sounds because you have to:

* Catch exceptions / keep the process alive
* Call `SetUp` and `TearDown` accordingly
* Feed the given `TestListener` (see below)

### TestSuite

Basically just a `List<TestRunner>` with one `Run()` method. But, if that would
be all, you'd have to wrap _every_ test case into one runner and register this
"pair" within the suite. Would suck. So there is a magic `Autodiscover()`
method, which does this automagically for every currently imported test case,
and we can focus on the important stuff - writing more tests.

### TestListener

Implement this and you're able to receive a truckload of informations out of
each test run.

### TestReportSimple

Implements `TestListener` and prints a very simple human readable report to
stdout. [PHPUnit][] inspired and can be used in a compact (default) or more
verbose mode (=> `TestListener.verbose = True|False`).

## Writing Tests

Basic convention for writing tests:

* The tests for a class `Class` go into a class `ClassTest`
* `ClassTest` inherits from `TestCase`
* The tests are public methods that are named `Test*`
* Inside the test methods, assertion methods such as `AssertEquals()` are used
  to assert that an value matches an expected value

### Simple example

A test for Monkeys `IntList` could look like:

    Strict

    Private

    Import bono

    Public

    Class ListTest Extends TestCase
        Method TestCountInitialZero:Void()
            Local list:IntList = New IntList()
            AssertEquals(0, list.Count())
        End

        Method TestAddIncrementsCount:Void()
            Local list:IntList = New IntList()
            list.AddLast(1)
            AssertEquals(1, list.Count())
        End
    End

And to run the test just execute this helper:

    Strict

    Private

    Import bono
    Import listtest

    Public

    Function Main:Int()
        Local runner:TestRunner = New TestRunner("ListTest")
        runner.Run(New TestReportSimple())
        Return 0
    End

## Organizing Tests

As seen before it's quite tedious to get some test running because you have to:

* Instantiate one `TestRunner` for each test
* Create some kind of test executable
* Maintain all tests in there

And that's the problem `TestSuite` is going to solve for you. Because, with some
reflection magic, this class is able to detect and execute all currently loaded
test. So the only things you have to do is to `Import` the test so that it
becomes visible.

### Example test runner

    Strict

    Private

    Import bono

    ' -- JUST IMPORT ALL TESTS
    Immport listtest

    Public

    Function Main:Int()
        Local suite:TestSuite = New TestSuite()
        suite.Autodiscover()
        suite.Run(New TestReportSimple())
        Return 0
    End

  [PHPUnit]: https://github.com/sebastianbergmann/phpunit/
