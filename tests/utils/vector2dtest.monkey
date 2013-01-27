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

    Method TestInstantiateWithoutArguments:Void()
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

    Method TestLength:Void()
        Local vec:Vector2D = New Vector2D(10, 0)
        AssertEquals(10.0, vec.Length())

        vec = New Vector2D(0, 5)
        AssertEquals(5.0, vec.Length())
    End

    Method TestDotProduct:Void()
        Local vecA:Vector2D = New Vector2D(1, 1)
        Local vecB:Vector2D = New Vector2D(3, 5)

        AssertEquals(8.0, vecA.DotProduct(vecB))
    End

    Method TestCrossProduct:Void()
        Local vecA:Vector2D = New Vector2D(1, 1)
        Local vecB:Vector2D = New Vector2D(3, 5)

        AssertEquals(2.0, vecA.CrossProduct(vecB))
    End

    Method TestDistance:Void()
        Local vecA:Vector2D = New Vector2D(1, 2)
        Local vecB:Vector2D = New Vector2D(3, 4)

        AssertEquals(2.8284270763397217, vecA.Distance(vecB))
    End

    Method TestDistanceWithSecondVectorNotGreater:Void()
        Local vecA:Vector2D = New Vector2D(1, 2)
        Local vecB:Vector2D = New Vector2D(3, 4)

        AssertEquals(2.8284270763397217, vecB.Distance(vecA))
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

    Method TestSet:Void()
        Local vec:Vector2D = New Vector2D(12, 34)
        Local copyVec:Vector2D = New Vector2D(0, 0)
        copyVec.Set(vec)

        AssertTrue(vec.Equal(copyVec))
    End

    Method TestNormalize:Void()
        Local vec:Vector2D = New Vector2D(1, 2)
        vec.Normalize()

        AssertEquals(0.44721359014511108, vec.x)
        AssertEquals(0.89442718029022217, vec.y)
    End

    Method TestRotate:Void()
        Local vec:Vector2D = New Vector2D(1, 2)
        vec.Rotate(90)

        AssertEquals(-2.0, vec.x)
        AssertEquals(-1.0000001192092896, vec.y)
    End

    Method TestRevert:Void()
        Local vec:Vector2D = New Vector2D(1, 2)
        vec.Revert()

        AssertEquals(-1.0, vec.x)
        AssertEquals(-2.0, vec.y)
    End

    Method TestAdd:Void()
        Local vec:Vector2D = New Vector2D(0, 0)
        vec.Add(New Vector2D(4, 5))

        AssertEquals(4.0, vec.x)
        AssertEquals(5.0, vec.y)
    End

    Method TestAddFactor:Void()
        Local vec:Vector2D = New Vector2D(0, 0)
        vec.Add(2.5)

        AssertEquals(2.5, vec.x)
        AssertEquals(2.5, vec.y)
    End

    Method TestSub:Void()
        Local vec:Vector2D = New Vector2D(0, 0)
        vec.Sub(New Vector2D(4, 5))

        AssertEquals(-4.0, vec.x)
        AssertEquals(-5.0, vec.y)
    End

    Method TestSubFactor:Void()
        Local vec:Vector2D = New Vector2D(0, 0)
        vec.Sub(2.5)

        AssertEquals(-2.5, vec.x)
        AssertEquals(-2.5, vec.y)
    End

    Method TestMul:Void()
        Local vec:Vector2D = New Vector2D(2, 2)
        vec.Mul(New Vector2D(2, 3))

        AssertEquals(4.0, vec.x)
        AssertEquals(6.0, vec.y)
    End

    Method TestMulFactor:Void()
        Local vec:Vector2D = New Vector2D(2, 3)
        vec.Mul(2)

        AssertEquals(4.0, vec.x)
        AssertEquals(6.0, vec.y)
    End

    Method TestDiv:Void()
        Local vec:Vector2D = New Vector2D(4, 6)
        vec.Div(New Vector2D(2, 3))

        AssertEquals(2.0, vec.x)
        AssertEquals(2.0, vec.y)
    End

    Method TestDivFactor:Void()
        Local vec:Vector2D = New Vector2D(8, 12)
        vec.Div(2)

        AssertEquals(4.0, vec.x)
        AssertEquals(6.0, vec.y)
    End

    Method TestToString:Void()
        Local vec:Vector2D = New Vector2D(12, 34)

        AssertEquals("(12.0, 34.0)", vec.ToString())
    End

    Method TestFloor:Void()
        Local vec:Vector2D = New Vector2D(1.3, 2.9)
        vec.Floor()

        AssertEquals(1.0, vec.x)
        AssertEquals(2.0, vec.y)
    End

    Method TestCeil:Void()
        Local vec:Vector2D = New Vector2D(1.3, 2.9)
        vec.Ceil()

        AssertEquals(2.0, vec.x)
        AssertEquals(3.0, vec.y)
    End

    Method TestRound:Void()
        Local vec:Vector2D = New Vector2D(1.4, 1.6)
        vec.Round()

        AssertEquals(1.0, vec.x)
        AssertEquals(2.0, vec.y)
    End
End
