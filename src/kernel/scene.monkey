Strict

Private

Import bono

Public

Class Scene Implements Sceneable, Updateable, Suspendable Abstract
    Private

    Field childs:List<Object> = New List<Object>
    Field keyEventsEnabled:Bool
    Field keyEmitter:KeyEmitter
    Field keyhandlerFan:KeyhandlerFan
    Field touchEventsEnabled:Bool
    Field touchEmitter:TouchEmitter
    Field touchableFan:TouchableFan

    Public

    Field emitterAutoEnable := True

    Method OnSceneEnter:Void()
    End

    Method OnSceneLeave:Void()
    End

    Method OnRender:Void()
        For Local obj:Object = EachIn childs
            If Renderable(obj) Then Renderable(obj).OnRender()
        End
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        For Local obj:Object = EachIn childs
            If Updateable(obj) Then Updateable(obj).OnUpdate(timer)
        End
    End

    Method OnResume:Void()
        For Local obj:Object = EachIn childs
            If Suspendable(obj) Then Suspendable(obj).OnResume()
        End
    End

    Method OnSuspend:Void()
        For Local obj:Object = EachIn childs
            If Suspendable(obj) Then Suspendable(obj).OnSuspend()
        End
    End

    Method ClearChilds:Void()
        For Local child:Object = EachIn childs
            RemoveChild(child)
        End

        EnableTouchEvents(touchEventsEnabled)
        EnableKeyEvents(keyEventsEnabled)
    End

    Method AddChild:Void(child:Object)
        If Not childs.Contains(child) Then childs.AddLast(child)

        If Keyhandler(child)
            If Not keyEventsEnabled And emitterAutoEnable Then EnableKeyEvents()
            GetKeyhandlerFan().Add(Keyhandler(child))
        End
        If Touchable(child)
            If Not touchEventsEnabled And emitterAutoEnable Then EnableTouchEvents()
            GetTouchableFan().Add(Touchable(child))
        End
    End

    Method RemoveChild:Void(child:Object)
        childs.RemoveEach(child)

        If Keyhandler(child) Then GetKeyhandlerFan().Remove(Keyhandler(child))
        If Touchable(child) Then GetTouchableFan().Remove(Touchable(child))
    End

    Method GetDirector:Director()
        Return Director.Shared()
    End

    Method GetApp:App()
        Return GetDirector().GetApp()
    End

    Method EnableTouchEvents:Void(flag:Bool=True)
        If Not touchEmitter And Not flag Then Return

        If flag
            AddChild(GetTouchEmitter())
        Else
            RemoveChild(GetTouchEmitter())
        End
        touchEventsEnabled = flag
    End

    Method GetTouchEmitter:TouchEmitter()
        If Not touchEmitter
            touchEmitter = New TouchEmitter()
            touchEmitter.handler = GetTouchableFan()
        End

        Return touchEmitter
    End

    Method EnableKeyEvents:Void(flag:Bool=True)
        If Not keyEmitter And Not flag Then Return

        If flag
            AddChild(GetKeyEmitter())
        Else
            RemoveChild(GetKeyEmitter())
        End
        keyEventsEnabled = flag
    End

    Method GetKeyEmitter:KeyEmitter()
        If Not keyEmitter
            keyEmitter = New KeyEmitter()
            keyEmitter.handler = GetKeyhandlerFan()
        End

        Return keyEmitter
    End

    Private

    Method GetTouchableFan:TouchableFan()
        If Not touchableFan
            touchableFan = New TouchableFan()
            If Touchable(Self) Then touchableFan.Add(Touchable(Self))
        End

        Return touchableFan
    End

    Method GetKeyhandlerFan:KeyhandlerFan()
        If Not keyhandlerFan
            keyhandlerFan = New KeyhandlerFan()
            If Keyhandler(Self) Then keyhandlerFan.Add(Keyhandler(Self))
        End

        Return keyhandlerFan
    End
End
