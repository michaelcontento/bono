Strict

Private

Import appobserver
Import deltatimer
Import mojo.app
Import mojo.graphics
Import observable

Public

Class AppEmitter Extends App Implements Observable
    Private

    Field runCalled:Bool
    Field onCreateCatched:Bool
    Field observers:List<AppObserver> = New List<AppObserver>()
    Field deltatimer:DeltaTimer
    Field fps:Int

    Public

    Const DEFAULT_FPS:Int = 60

    Method New(fps:Int=DEFAULT_FPS)
        Self.fps = fps
        SetUpdateRate(fps)
    End

    Method AddObserver:Void(observer:AppObserver)
        If observers.Contains(observer) Then Return
        observers.AddLast(observer)
    End

    Method RemoveObserver:Void(observer:AppObserver)
        observers.RemoveEach(observer)
    End

    Method GetObservers:List<AppObserver>()
        Return observers
    End

    Method OnCreate:Int()
        onCreateCatched = True
        deltatimer = New DeltaTimer(fps)
        Return 0
    End

    Method OnLoading:Int()
        If Not (runCalled And onCreateCatched) Then Return 0
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnLoading()
        End
        Return 0
    End

    Method OnUpdate:Int()
        If Not (runCalled And onCreateCatched) Then Return 0
        deltatimer.OnUpdate()
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnUpdate(deltatimer)
        End
        Return 0
    End

    Method OnResume:Int()
        If Not (runCalled And onCreateCatched) Then Return 0
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnResume()
        End
        Return 0
    End

    Method OnSuspend:Int()
        If Not (runCalled And onCreateCatched) Then Return 0
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnSuspend()
        End
        Return 0
    End

    Method OnRender:Int()
        If Not (runCalled And onCreateCatched) Then Return 0
        Cls(0, 0, 0)
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnRender()
        End
        Return 0
    End

    Method Run:Void()
        runCalled = True
    End
End
