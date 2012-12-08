# Test

Very simple test framework inspired (just a little bit) by [PHPUnit][].

## Overview

![Class diagramm](http://yuml.me/5a92f96a)

## TestCase

Everyt real test case must extend this class.


### TestRunner

This thing is responsible for executing all tests within one given test case.
But it's not as simple as it sounds because you have to:

* Catch exceptions / keep the process alive
* Call `SetUp` and `TearDown` accordingly
* Feed the given `TestListener` (see below)

### TestSuite

Basically just a collection of `TestRunner` with one `Add()` and one `Run()`
method. But with this you'd have to wrap _every_ test case into one runner and
register this pair within the suite. This sucks. So there is one magic
`Autodiscover()` and we can focus on the important stuff.

### TestListener

Implement this and you're able to receive a truckload of informations out of
each test run.

### TestReportSimple

Implements `TestListener` and prints a very simple human readable report to
stdout. (Again) [PHPUnit][] inspired and can be used in a compact or more
verbose mode.

## Writing Tests

**TODO**

## Organizing Tests

**TODO**

  [PHPUnit]: https://github.com/sebastianbergmann/phpunit/
