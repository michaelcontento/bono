Strict

Private

Import bono

Public

Class SceneTransitionFlash Extends SceneTransitionProxy Implements Colorable
    Private

    Field animation:Animation
    Field effect := New EffectColorAlpha(1.0, 0.0)
    Field blend := New ColorBlend()

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Float, Transition)")
    End

    Method New(duration:Float, transition:Transition)
        animation = New Animation(duration, transition)
        animation.AddLast(effect)

        effect.AddLast(blend)
    End

    Method SetColor:Void(newColor:Color)
        blend.SetColor(newColor)
    End

    Method GetColor:Color()
        Return blend.GetColor()
    End

    Method Switch:Void(prevScene:Sceneable, nextScene:Sceneable)
        Super.Switch(prevScene, nextScene)

        If prevScene Then prevScene.OnSceneLeave()
        If nextScene Then nextScene.OnSceneEnter()
        activeScene = nextScene

        animation.Restart()
    End

    Method OnRender:Void()
        Super.OnRender()
        blend.OnRender()
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        animation.OnUpdate(timer)
        If animation.IsPlaying()
            Super.OnUpdate(timer)
        Else
            Director.Shared().GetApp().SetHandler(nextScene)
        End
    End
End
