Strict

Private

Import bono
Import reflection

Public

Interface TestListener
    Method StartTestSuite:Void(suite:TestSuite)
    Method StartTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo)
    Method AddFailure:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
    Method AddSkippedTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
    Method AddIncompleteTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo, message:String)
    Method EndTest:Void(classInfo:ClassInfo, methodInfo:MethodInfo)
    Method EndTestSuite:Void(suite:TestSuite)
End
