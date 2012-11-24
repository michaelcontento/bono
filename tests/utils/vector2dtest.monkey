Strict

Private

Import bono

Public

Class Vector2DTest Extends TestCase
    Method TestInstantiate:Void()
        Local vec:Vector2D = New Vector2D(12, 34)
        AssertEquals(12.0, vec.x)
        AssertEquals(34.0, vec.y)
    End

    Method TestInstantiaWithoutArguments:Void()
        Local vec:Vector2D = New Vector2D()
        AssertEquals(0.0, vec.x)
        AssertEquals(0.0, vec.y)
    End

    Method TestIsZero:Void()
        Local zeroVec:Vector2D = New Vector2D(0, 0)
        AssertTrue(zeroVec.IsZero())

        Local nonZeroVec:Vector2D = New Vector2D(1, 2)
        AssertFalse(nonZeroVec.IsZero())
    End

    Method TestEqual:Void()
        Local firstVec:Vector2D = New Vector2D(12, 34)
        AssertTrue(firstVec.Equal(firstVec))

        Local secondVec:Vector2D = New Vector2D(56, 78)
        AssertFalse(firstVec.Equal(secondVec))
    End

    Method TestCopy:Void()
        Local vec:Vector2D = New Vector2D(12, 34)
        Local copyVec:Vector2D = vec.Copy()

        AssertTrue(vec.Equal(copyVec))
    End

    Method TestCopyInPlace:Void()
        Local vec:Vector2D = New Vector2D(12, 34)
        Local copyVec:Vector2D = New Vector2D(0, 0)
        copyVec.Copy(vec)

        AssertTrue(vec.Equal(copyVec))
    End

    Method TestToString:Void()
        Local vec:Vector2D = New Vector2D(12, 34)

        AssertEquals("(12.0, 34.0)", vec.ToString())
    End
End
