Strict

Private

Import bono

Class AlignmentDummy Implements Sizeable, Positionable
    Field position:Vector2D
    Field size:Vector2D

    Method GetPosition:Vector2D()
        Return position
    End

    Method SetPosition:Void(newPos:Vector2D)
        position = newPos
    End

    Method GetSize:Vector2D()
        Return size
    End

    Method SetSize:Void(newSize:Vector2D)
        size = newSize
    End
End

Public

Class AlignTest Extends TestCase
    Field dummy:AlignmentDummy
    Field DEFAULT_POSITION:Vector2D = New Vector2D(100, 100)
    Field DEFAULT_SIZE:Vector2D = New Vector2D(50, 50)

    Method SetUp:Void()
        dummy = New AlignmentDummy()
        dummy.position = DEFAULT_POSITION.Copy()
        dummy.size = DEFAULT_SIZE.Copy()
    End

    Method TestHorizontalLeft:Void()
        Align.Horizontal(dummy.position, dummy, Align.LEFT)
        AssertTrue(dummy.position.Equal(DEFAULT_POSITION))
    End

    Method TestHorizontalRight:Void()
        Local expected:Vector2D = DEFAULT_POSITION.Copy()
        expected.x -= DEFAULT_SIZE.x

        Align.Horizontal(dummy.position, dummy, Align.RIGHT)
        AssertTrue(dummy.position.Equal(expected))
    End

    Method TestHorizontalCenter:Void()
        Local expected:Vector2D = DEFAULT_POSITION.Copy()
        expected.x -= DEFAULT_SIZE.x / 2

        Align.Horizontal(dummy.position, dummy, Align.CENTER)
        AssertTrue(dummy.position.Equal(expected))
    End

    Method TestVerticalTop:Void()
        Align.Vertical(dummy.position, dummy, Align.TOP)
        AssertTrue(dummy.position.Equal(DEFAULT_POSITION))
    End

    Method TestVerticalBottom:Void()
        Local expected:Vector2D = DEFAULT_POSITION.Copy()
        expected.y -= DEFAULT_SIZE.y

        Align.Vertical(dummy.position, dummy, Align.BOTTOM)
        AssertTrue(dummy.position.Equal(expected))
    End

    Method TestVerticalCenter:Void()
        Local expected:Vector2D = DEFAULT_POSITION.Copy()
        expected.y -= DEFAULT_SIZE.y / 2

        Align.Vertical(dummy.position, dummy, Align.CENTER)
        AssertTrue(dummy.position.Equal(expected))
    End

    Method TestCentered:Void()
        Local expected:Vector2D = DEFAULT_POSITION.Copy()
        expected.x -= DEFAULT_SIZE.x / 2
        expected.y -= DEFAULT_SIZE.y / 2

        Align.Centered(dummy.position, dummy)
        AssertTrue(dummy.position.Equal(expected))
    End
End
