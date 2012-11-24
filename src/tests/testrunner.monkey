Strict

Private

Import assertionfailedexception
Import bono.src.exceptions
Import reflection
Import testcase
Import testfailedexception
Import testincompleteexception
Import testlistener
Import testskippedexception

Public

Class TestRunner
    Private

    Field name:String
    Field classInfo:ClassInfo
    Field testMethods:Stack<MethodInfo> = New Stack<MethodInfo>()

    Public

    Method New(name:String)
        Self.name = name

        LoadClassInfo()
        ValidateClassInfo()
        ExtractMethods()
    End

    Method Run:Void(listener:TestListener)
        For Local methodInfo:MethodInfo = EachIn testMethods
            Local test:TestCase
            Try
                test = TestCase(classInfo.NewInstance())
            Catch ex:Exception
                Throw New RuntimeException("New failed")
            End

            Try
                test.SetUp()
            Catch ex:Exception
                Throw New RuntimeException("SetUp failed")
            End

            listener.StartTest(classInfo, methodInfo)
            Try
                methodInfo.Invoke(test, [])
            Catch ex:AssertionFailedException
            Catch ex:TestFailedException
                listener.AddFailure(classInfo, methodInfo, ex.ToString())
            Catch ex:TestSkippedException
                listener.AddSkippedTest(classInfo, methodInfo, ex.ToString())
            Catch ex:TestIncompleteException
                listener.AddIncompleteTest(classInfo, methodInfo, ex.ToString())
            End
            listener.EndTest(classInfo, methodInfo)

            Try
                test.TearDown()
            Catch ex:Exception
                Throw New RuntimeException("TearDown failed")
            End
        End
    End

    Private

    Method LoadClassInfo:Void()
        classInfo = GetClass(name)
        If classInfo Then Return

        Throw New NotFoundException("No class named >" + name + "< found.")
    End

    Method ValidateClassInfo:Void()
        If classInfo.ExtendsClass(GetClass("TestCase")) Then Return

        Local msg:String = "Class >" + name + "< must inherit from TestCase."
        Throw New InvalidArgumentException(msg)
    End

    Method ExtractMethods:Void()
        For Local methodInfo:MethodInfo = EachIn classInfo.GetMethods(True)
            If methodInfo.Name().StartsWith("Test")
                testMethods.Push(methodInfo)
            End
        End
    End
End
