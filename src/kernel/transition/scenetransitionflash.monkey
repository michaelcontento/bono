Strict

Private

Import bono

Public

Class SceneTransitionFlash Extends SceneTransitionProxy Implements Colorable
    Private

    Field animation:Animation
    Field intro:Animation
    Field effect := New EffectColorAlpha(1.0, 0.0)
    Field blend := New ColorBlend()
    Field switched := True

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Float, Transition)")
    End

    Method New(duration:Float, transition:Transition)
        animation = New Animation(duration, transition)
        animation.AddLast(effect)

        effect.AddLast(blend)
    End

    Method WithIntro:Void(duration:Float, transition:Transition)
        intro = New Animation(duration, transition)
        intro.AddLast(New EffectReverse(effect))
    End

    Method SetColor:Void(newColor:Color)
        blend.SetColor(newColor)
    End

    Method GetColor:Color()
        Return blend.GetColor()
    End

    Method Switch:Void(prevScene:Sceneable, nextScene:Sceneable)
        If Not switched Then TriggerSceneLeaveAndEnter()

        Super.Switch(prevScene, nextScene)
        switched = False
        animation.Restart()

        If intro
            intro.Restart()
            activeScene = prevScene
        Else
            SwitchOver()
        End
    End

    Method OnRender:Void()
        Super.OnRender()
        blend.OnRender()
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        If intro
            intro.OnUpdate(timer)
            If intro.IsPlaying()
                Super.OnUpdate(timer)
                Return
            Else
                SwitchOver()
            End
        End

        animation.OnUpdate(timer)
        If animation.IsPlaying()
            Super.OnUpdate(timer)
        Else
            Director.Shared().GetApp().SetHandler(nextScene)
        End
    End

    Private

    Method SwitchOver:Void()
        If switched Then Return
        switched = True

        activeScene = nextScene
        TriggerSceneLeaveAndEnter()
    End

    Method TriggerSceneLeaveAndEnter:Void()
        If prevScene Then prevScene.OnSceneLeave()
        If nextScene Then nextScene.OnSceneEnter()
    End
End
