Strict

Private

Import bono
Import mojo

Public

Class SpriteTest Extends AppTestCase
    Field sprite:Sprite

    Method SetUp:Void()
        Super.SetUp()

        sprite = New Sprite(CreateImage(1, 1))
    End

    Method TestGetWithoutLoaderShouldFail:Void()
        Local caught := False
        Try
            Sprite.Create("file")
        Catch ex:RuntimeException
            caught = True
        End

        If Not caught
            Fail("RuntimeException expected")
        End
    End

    Method TestGetWithConfiguredImageLoader:Void()
        Local loader := New MockImageLoader()
        Sprite.imageLoader = loader

        Local res:Sprite = Sprite.Create("name")

        AssertNotNull(res)
        AssertEquals("name", loader.lastFile)
    End

    Method TestInvalidConstructor:Void()
        Local caught := False
        Try
            New Sprite()
        Catch ex:InvalidConstructorException
            caught = True
        End

        If Not caught
            Fail("InvalidConstructorException expected")
        End
    End

    Method TestGetTimeline:Void()
        Local line:TimelineFactory = sprite.GetTimeline()
        AssertNotNull(line)
    End

    Method TestGetTimelineShouldReturnTheSameInstance:Void()
        Local line1 := sprite.GetTimeline()
        Local line2 := sprite.GetTimeline()

        MarkTestSkipped("Implement AssertSame first")
        'AssertSame(line1, line2)
    End

    Method TestSetAndGetRotation:Void()
        sprite.SetRotation(10)
        AssertEquals(10.0, sprite.GetRotation())

        sprite.SetRotation(0)
        AssertEquals(0.0, sprite.GetRotation())

        sprite.SetRotation(359)
        AssertEquals(359.0, sprite.GetRotation())

        ' -- Should stay in between -360-360

        sprite.SetRotation(361)
        AssertEquals(1.0, sprite.GetRotation())

        sprite.SetRotation(-361)
        AssertEquals(359.0, sprite.GetRotation())

        sprite.SetRotation(720)
        AssertEquals(360.0, sprite.GetRotation())
    End

    Method TestDefaultRotation:Void()
        AssertEquals(0.0, sprite.GetRotation())
    End

    Method TestExtendsBaseDisplayObject:Void()
        AssertNotNull(BaseDisplayObject(sprite))
    End

    Method TestInterfaces:Void()
        AssertNotNull(Updateable(sprite))
        AssertNotNull(Renderable(sprite))
        AssertNotNull(Rotateable(sprite))
        AssertNotNull(Timelineable(sprite))
    End

    Method TestCopy:Void()
        Local newSprite := sprite.Copy()
        AssertEquals(sprite.GetRotation(), newSprite.GetRotation())

        ' inherited from BaseDisplayObject
        AssertEquals(sprite.GetAlignment(), newSprite.GetAlignment())
        AssertEquals(sprite.GetPosition(), newSprite.GetPosition())
        AssertEquals(sprite.GetSize(), newSprite.GetSize())
        AssertEquals(sprite.GetColor(), newSprite.GetColor())
    End

    Method TestRender:Void()
        MarkTestIncomplete("Implement this")
    End

    Method TestGrabSprite:Void()
        MarkTestIncomplete("Implement this")
    End

    Method TestDrawImageRect:Void()
        MarkTestIncomplete("Implement this")
    End
End
