Strict

Private

Import bono.kernel
Import observerfan

Public

Class AppObserverFan Extends ObserverFan Implements AppObserver
    Method OnCreate:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn Self
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnCreate()
        End
    End

    Method OnLoading:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn Self
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnLoading()
        End
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
        Local castedChild:AppObserver
        For Local child:Object = EachIn Self
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnUpdate(deltatimer)
        End
    End

    Method OnRender:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn Self
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnRender()
        End
    End

    Method OnResume:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn Self
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnResume()
        End
    End

    Method OnSuspend:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn Self
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnSuspend()
        End
    End
End
