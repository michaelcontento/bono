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
    Field onCreateDispatched:Bool
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
        deltatimer = New DeltaTimer(fps)
        onCreateCatched = True
        DispatchOnCreate()
        Return 0
    End

    Method OnLoading:Int()
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnLoading()
        End
        Return 0
    End

    Method OnUpdate:Int()
        deltatimer.OnUpdate()
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnUpdate(deltatimer)
        End
        Return 0
    End

    Method OnResume:Int()
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnResume()
        End
        Return 0
    End

    Method OnSuspend:Int()
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnSuspend()
        End
        Return 0
    End

    Method OnRender:Int()
        Cls(0, 0, 0)
        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnRender()
        End
        Return 0
    End

    Method Run:Void()
        runCalled = True
        DispatchOnCreate()
    End

    Private

    Method DispatchOnCreate:Void()
        If Not runCalled Then Return
        If Not onCreateCatched Then Return

        If onCreateDispatched Then Return
        onCreateDispatched = True

        For Local observer:AppObserver = EachIn GetObservers()
            observer.OnCreate()
        End
    End
End
