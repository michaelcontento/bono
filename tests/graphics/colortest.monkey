Strict

Private

Import bono
Import mojo.graphics

Public

Class ColorTest Extends TestCase
    Method TestReset:Void()
        Local c:Color = New Color(1, 2, 3, 4)
        c.Reset()

        AssertEquals(Color.MAX, c.red)
        AssertEquals(Color.MAX, c.green)
        AssertEquals(Color.MAX, c.blue)
        AssertEquals(Color.MAX, c.alpha)
    End

    Method TestDefaultValues:Void()
        Local c:Color = New Color()

        AssertEquals(Color.MAX, c.red)
        AssertEquals(Color.MAX, c.green)
        AssertEquals(Color.MAX, c.blue)
        AssertEquals(Color.MAX, c.alpha)
    End

    Method TestDefaultValuesPassed:Void()
        Local c:Color = New Color(1, 2, 3, 4)

        AssertEquals(1.0, c.red)
        AssertEquals(2.0, c.green)
        AssertEquals(3.0, c.blue)
        AssertEquals(4.0, c.alpha)
    End

    Method TestRandomize:Void()
        Local c1:Color = New Color()
        Local c2:Color = New Color()
        Local c3:Color = New Color()

        c1.Randomize()
        c2.Randomize()
        c3.Randomize()

        AssertFalse(c1.Equals(c2))
        AssertFalse(c1.Equals(c3))
        AssertFalse(c2.Equals(c3))
    End

    Method TestEquals:Void()
        Local c1:Color = New Color(1, 2, 3, 4)
        Local c2:Color = New Color(1, 2, 3, 4)

        AssertTrue(c1.Equals(c2))
    End

    Method TestNotEqualsRed:Void()
        Local c1:Color = New Color(1, 2, 3, 4)
        Local c2:Color = New Color(9, 2, 3, 4)

        AssertFalse(c1.Equals(c2))
    End

    Method TestNotEqualsGreen:Void()
        Local c1:Color = New Color(1, 2, 3, 4)
        Local c2:Color = New Color(1, 9, 3, 4)

        AssertFalse(c1.Equals(c2))
    End

    Method TestNotEqualsBlue:Void()
        Local c1:Color = New Color(1, 2, 3, 4)
        Local c2:Color = New Color(1, 2, 9, 4)

        AssertFalse(c1.Equals(c2))
    End

    Method TestNotEqualsAlpha:Void()
        Local c1:Color = New Color(1, 2, 3, 4)
        Local c2:Color = New Color(2, 2, 3, 9)

        AssertFalse(c1.Equals(c2))
    End

    Method TestCopy:Void()
        Local c1:Color = New Color()
        c1.Randomize()
        Local c2:Color = c1.Copy()

        AssertTrue(c1.Equals(c2))
    End

    Method TestToString:Void()
        Local c:Color = New Color(1, 2, 3, 127)
        Local expected:String = "(Red: 1.0 Green: 2.0 Blue: 3.0 Alpha: 0.49803921580314636)"

        AssertEquals(expected, c.ToString())
    End

    Method TestRed:Void()
        Local c:Color = New Color()
        c.red = 127

        AssertEquals(127.0, c.red)
        AssertEquals(0.498039215, c.redFloat)
    End

    Method TestGreen:Void()
        Local c:Color = New Color()
        c.green = 127

        AssertEquals(127.0, c.green)
        AssertEquals(0.498039215, c.greenFloat)
    End

    Method TestBlue:Void()
        Local c:Color = New Color()
        c.blue = 127

        AssertEquals(127.0, c.blue)
        AssertEquals(0.498039215, c.blueFloat)
    End

    Method TestAlpha:Void()
        Local c:Color = New Color()
        c.alpha = 127

        AssertEquals(127.0, c.alpha)
        AssertEquals(0.498039215, c.alphaFloat)
    End

    Method TestBoundsRed:Void()
        Local c:Color = New Color()
        c.red = 256

        AssertEquals(Color.MAX, c.red)
    End

    Method TestBoundsRedFloat:Void()
        Local c:Color = New Color()
        c.redFloat = 1.2

        AssertEquals(Color.MAX, c.red)
    End

    Method TestBoundsGreen:Void()
        Local c:Color = New Color()
        c.green = 256

        AssertEquals(Color.MAX, c.green)
    End

    Method TestBoundsGreenFloat:Void()
        Local c:Color = New Color()
        c.greenFloat = 1.2

        AssertEquals(Color.MAX, c.green)
    End

    Method TestBoundsBlue:Void()
        Local c:Color = New Color()
        c.blue = 256

        AssertEquals(Color.MAX, c.blue)
    End

    Method TestBoundsBlueFloat:Void()
        Local c:Color = New Color()
        c.blueFloat = 1.2

        AssertEquals(Color.MAX, c.blue)
    End

    Method TestBoundsAlpha:Void()
        Local c:Color = New Color()
        c.alpha = 256

        AssertEquals(Color.MAX, c.alpha)
    End

    Method TestBoundsAlphaFloat:Void()
        Local c:Color = New Color()
        c.alphaFloat = 1.2

        AssertEquals(Color.MAX, c.alpha)
    End
End
