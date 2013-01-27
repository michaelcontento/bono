Strict

Private

Import bono
Import reflection

Public

Class TestReportSimple Implements TestListener
    Private

    Field lastClass:ClassInfo
    Field currentClass:ClassInfo
    Field currentMethod:MethodInfo
    Field result:Int = PASSED
    Field numTests:Int
    Field failureMessages:StringMap<String> = New StringMap<String>()
    Field skipMessages:StringMap<String> = New StringMap<String>()
    Field incompleteMessages:StringMap<String> = New StringMap<String>()
    Field printCache:String = "    "

    Const PASSED:Int = 0
    Const FAILED:Int = 1
    Const SKIPPED:Int = 2
    Const INCOMPLETE:Int = 3

    Public

    Field verbose:Bool

    Method StartTestSuite:Void(suite:TestSuite)
        Print "Running " + Target.CONFIG +
            " " + Target.LANG + "/" + Target.TARGET +
            " tests on " + Target.HOST + ":~n"
    End

    Method StartTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo)
        currentClass = classInfo
        currentMethod = methodInfo
        result = PASSED
        numTests += 1
    End

    Method AddFailure:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
        result = FAILED
        failureMessages.Set(GetFQN(classInfo, methodInfo), message)
    End

    Method AddSkippedTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
        result = SKIPPED
        skipMessages.Set(GetFQN(classInfo, methodInfo), message)
    End

    Method AddIncompleteTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
        result = INCOMPLETE
        incompleteMessages.Set(GetFQN(classInfo, methodInfo), message)
    End

    Method EndTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo)
        PrintResult()
        currentClass = Null
        currentMethod = Null
    End

    Method EndTestSuite:Void(suite:TestSuite)
        FlushPrintCache()
        PrintStats()

        failureMessages.Clear()
        incompleteMessages.Clear()
        skipMessages.Clear()
    End

    Private

    Method PrintResult:Void()
        If verbose And (Not lastClass Or Not (lastClass.Name() = currentClass.Name()))
            If lastClass
                FlushPrintCache()
                Print ""
            End
            Print "  " + currentClass.Name()
        End
        lastClass = currentClass

        If verbose
            Print "    " + currentMethod.Name() + " " + GetResultText()
        Else
            printCache += GetResultDot()
            FlushPrintCacheIfRequired()
        End
    End

    Method FlushPrintCache:Void()
        If verbose Then Return
        Print printCache
        printCache = "    "
    End

    Method FlushPrintCacheIfRequired:Void(len:Int=80)
        If printCache.Length() >= len Then FlushPrintCache()
    End

    Method GetResultText:String()
        Select result
        Case PASSED
            Return ""
        Case FAILED
            Return "[FAILED]"
        Case SKIPPED
            Return "[SKIPPED]"
        Case INCOMPLETE
            Return "[INCOMPLETE]"
        Default
            Throw New RuntimeException("Invalid result id: " + result)
        End
    End

    Method GetResultDot:String()
        Select result
        Case PASSED
            Return "."
        Case FAILED
            Return "F"
        Case SKIPPED
            Return "S"
        Case INCOMPLETE
            Return "I"
        Default
            Throw New RuntimeException("Invalid result id: " + result)
        End
    End

    Method PrintStats:Void()
        Print ""

        PrintMessages(skipMessages, "skipped test")
        PrintMessages(incompleteMessages, "incomplete test")
        PrintMessages(failureMessages, "failure")

        PrintSummary()
        Print "Tests: "      + numTests                   +
            ", Failed: "     + failureMessages.Count()    +
            ", Skipped: "    + skipMessages.Count()       +
            ", Incomplete: " + incompleteMessages.Count() +
            "."
    End

    Method PrintMessages:Void(messages:StringMap<String>, desciption:String)
        If messages.Count() = 0 Then Return
        Print "There was " + messages.Count() + " " + desciption + ":~n"

        Local counter:Int = 0
        For Local key:String = EachIn messages.Keys()
            Local val:String = messages.Get(key).Replace("~n", "~n  ")
            counter += 1

            Print counter + ") " + key + "~n  " + val + "~n"
        End
    End

    Method PrintSummary:Void()
        If failureMessages.Count() > 0
            Print "FAILURES!"
        ElseIf skipMessages.Count() > 0 Or incompleteMessages.Count() > 0
            Print "OK, but incomplete or skipped tests!"
        Else
            Print "OK"
        End
    End

    Method GetFQN:String(classInfo:ClassInfo, methodInfo:MethodInfo)
        Local parts:String[] = classInfo.Name().Split(".")
        Local filename:String = "/".Join(parts[..-1]) + ".monkey"
        Local classname:String = parts[parts.Length() - 1]
        Return classname + "." + methodInfo.Name() + " in " + filename
    End
End
