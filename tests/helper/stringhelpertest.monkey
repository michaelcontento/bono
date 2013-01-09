Strict

Private

Import bono

Public

Class StringHelperTest Extends TestCase
    Method TestCountLines:Void()
        AssertEquals(3, StringHelper.CountLines("1~n2~n3"))
    End

    Method TestRandomize:Void()
        Local res1:String = StringHelper.Randomize("hallo")
        Local res2:String = StringHelper.Randomize("hallo")

        AssertNotEquals(res1, res2)
    End

    Method TestJoinInt:Void()
        AssertEquals("1", StringHelper.Join(",", [1]))
        AssertEquals("1-2", StringHelper.Join("-", [1, 2]))
        AssertEquals("123", StringHelper.Join("", [1, 2, 3]))
    End

    Method TestJoinFloat:Void()
        AssertEquals("1.0", StringHelper.Join(",", [1.0]))
        AssertEquals("1.0-2.0", StringHelper.Join("-", [1.0, 2.0]))
        AssertEquals("1.02.03.0", StringHelper.Join("", [1.0, 2.0, 3.0]))
    End
End
