Strict

Private

Import bono

Public

Class Vector2DTest Extends TestCase
    Method TestInstantiate:Void()
        Local vec:Vector2D = New Vector2D(12, 34)
        assertEquals(12.0, vec.x)
        assertEquals(34.0, vec.y)
    End

    Method TestInstantiaWithoutArguments:Void()
        Local vec:Vector2D = New Vector2D()
        assertEquals(0.0, vec.x)
        assertEquals(0.0, vec.y)
    End

    Method TestIsZero:Void()
        Local zeroVec:Vector2D = New Vector2D(0, 0)
        assertTrue(zeroVec.IsZero())

        Local nonZeroVec:Vector2D = New Vector2D(1, 2)
        assertFalse(nonZeroVec.IsZero())
    End

    Method TestEqual:Void()
        Local firstVec:Vector2D = New Vector2D(12, 34)
        assertTrue(firstVec.Equal(firstVec))

        Local secondVec:Vector2D = New Vector2D(56, 78)
        assertFalse(firstVec.Equal(secondVec))
    End

    Method TestCopy:Void()
        Local vec:Vector2D = New Vector2D(12, 34)
        Local copyVec:Vector2D = vec.Copy()

        assertTrue(vec.Equal(copyVec))
    End

    Method TestCopyInPlace:Void()
        Local vec:Vector2D = New Vector2D(12, 34)
        Local copyVec:Vector2D = New Vector2D(0, 0)
        copyVec.Copy(vec)

        assertTrue(vec.Equal(copyVec))
    End

    Method TestToString:Void()
        Local vec:Vector2D = New Vector2D(12, 34)

        assertEquals("(12.0, 34.0)", vec.ToString())
    End
End
