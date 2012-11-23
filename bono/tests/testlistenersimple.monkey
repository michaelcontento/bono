Strict

Private

Import bono.exceptions
Import reflection
Import testlistener
Import testsuite

Public

Class TestListenerSimple Implements TestListener
    Private

    Field lastClass:ClassInfo
    Field currentClass:ClassInfo
    Field currentMethod:MethodInfo
    Field result:Int = PASSED
    Field numFailures:Int
    Field numSkips:Int
    Field numPasses:Int
    Field numIncomplete:Int
    Field skipMessages:String
    Field incompleteMessages:String

    Const PASSED:Int = 0
    Const FAILED:Int = 1
    Const SKIPPED:Int = 2
    Const INCOMPLETE:Int = 3

    Public

    Method StartTestSuite:Void(suite:TestSuite)
    End

    Method StartTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo)
        currentClass = classInfo
        currentMethod = methodInfo
        result = PASSED
    End

    Method AddFailure:Void(classInfo:ClassInfo, methodInfo:MethodInfo)
        result = FAILED
    End

    Method AddSkippedTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
        result = SKIPPED

        If message.Length() > 0
            If skipMessages.Length() > 0 Then incompleteMessages += "~n"
            skipMessages += "  " + classInfo.Name() + "." + methodInfo.Name() + ":~n"
            skipMessages += "    " + message.Replace("~n", "~n    ")
            skipMessages += "~n"
        End
    End

    Method AddIncompleteTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
        result = INCOMPLETE

        If message.Length() > 0
            If incompleteMessages.Length() > 0 Then incompleteMessages += "~n"
            incompleteMessages += "  " + classInfo.Name() + "." + methodInfo.Name() + ":~n"
            incompleteMessages += "    " + message.Replace("~n", "~n    ")
            incompleteMessages += "~n"
        End
    End

    Method EndTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo)
        PrintResult()
        currentClass = Null
        currentMethod = Null
    End

    Method EndTestSuite:Void(suite:TestSuite)
        PrintStats()
    End

    Private

    Method PrintResult:Void()
        If Not lastClass Or Not (lastClass.Name() = currentClass.Name())
            If lastClass Then Print ""
            Print "  " + currentClass.Name()
        End

        Print "    " + currentMethod.Name() + " " + GetResultText()
        lastClass = currentClass
    End

    Method GetResultText:String()
        Select result
        Case PASSED
            numPasses += 1
            Return ""
        Case FAILED
            numFailures += 1
            Return "[FAILED]"
        Case SKIPPED
            numSkips += 1
            Return "[SKIPPED]"
        Case INCOMPLETE
            numIncomplete += 1
            Return "[INCOMPLETE]"
        Default
            Throw New RuntimeException("Invalid result id: " + result)
        End
    End

    Method PrintStats:Void()
        Print ""

        PrintSkipMessages()
        PrintIncompleteMessages()
        PrintSummary()

        Print "Tests: "      + numPasses     +
            ", Failed: "     + numFailures   +
            ", Skipped: "    + numSkips      +
            ", Incomplete: " + numIncomplete +
            "."
    End

    Method PrintSkipMessages:Void()
        If skipMessages.Length() > 0
            Print "Collected skip messages:"
            Print ""
            Print skipMessages
        End
    End

    Method PrintIncompleteMessages:Void()
        If incompleteMessages.Length() > 0
            Print "Collected incomplete messages:"
            Print ""
            Print incompleteMessages
        End
    End

    Method PrintSummary:Void()
        If numFailures > 0
            Print "FAILURES!"
        ElseIf numSkips > 0 Or numIncomplete > 0
            Print "OK, but incomplete or skipped tests!"
        Else
            Print "OK"
        End
    End
End
