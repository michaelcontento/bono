Strict

Private

Import bono
Import reflection

Class MockTestRunner Extends TestRunner
    Global runCalled:Int

    Method Run:Void(listener:TestListener)
        runCalled += 1
    End
End

Class StubTestListener Implements TestListener
    Method StartTestSuite:Void(suite:TestSuite)
    End

    Method StartTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo)
    End

    Method AddFailure:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
    End

    Method AddSkippedTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
    End

    Method AddIncompleteTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
    End

    Method EndTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo)
    End

    Method EndTestSuite:Void(suite:TestSuite)
    End
End

Public

Class SimpleTestSuiteTest Extends TestCase
    Method SetUp:Void()
        MockTestRunner.runCalled = 0
    End

    Method TestAddAndRun:Void()
        Local suite := New SimpleTestSuite()
        suite.Add(New MockTestRunner())
        suite.Add(New MockTestRunner())
        suite.Run(New StubTestListener())

        AssertEquals(2, MockTestRunner.runCalled)
    End

    Method TestImplementsTestSuite:Void()
        AssertNotNull(TestSuite(New SimpleTestSuite()))
    End
End
