Strict

Private

Import bono

Public

Class ArrayHelperTest Extends TestCase
    Private

    Const ITERATIONS:Int = 1000

    Public

    Method TestRandomChoice:Void()
        Local pool:Int[] = [0, 1]
        Local counter:IntMap<Int> = New IntMap<Int>

        For Local i:Int = 0 To ITERATIONS
            Local random:Int = ArrayHelper<Int>.RandomChoice(pool)
            counter.Set(random, counter.Get(random) + 1)
        End

        AssertGreaterThanOrEqual(0.48, 1.0 / ITERATIONS * counter.Get(0))
        AssertGreaterThanOrEqual(0.48, 1.0 / ITERATIONS * counter.Get(1))
    End

    Method TestRandomize:Void()
        Local a:Int[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        ArrayHelper<Int>.Randomize(a)
        Local res1:String = StringHelper.Join("", a)

        ArrayHelper<Int>.Randomize(a)
        Local res2:String = StringHelper.Join("", a)

        AssertNotEquals(res1, res2)
    End

    Method TestCreateArray2D:Void()
        Local a:Int[][] = ArrayHelper<Int>.CreateArray(2, 3)

        AssertEquals(2, a.Length())
        AssertEquals(3, a[0].Length())
        AssertEquals(3, a[1].Length())
    End

    Method TestCreateArray3D:Void()
        Local a:Int[][][] = ArrayHelper<Int>.CreateArray(2, 3, 4)

        AssertEquals(2, a.Length())
        AssertEquals(3, a[0].Length())
        AssertEquals(4, a[0][0].Length())
        AssertEquals(4, a[0][1].Length())
        AssertEquals(4, a[0][2].Length())
        AssertEquals(3, a[1].Length())
        AssertEquals(4, a[1][0].Length())
        AssertEquals(4, a[1][1].Length())
        AssertEquals(4, a[1][2].Length())
    End
End
