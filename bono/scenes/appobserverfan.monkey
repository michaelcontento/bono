Strict

Private

Import bono.kernel
Import observerfan

Public

Class AppObserverFan Implements AppObserver, ObserverFan
    Private

    Field childs:List<Object> = New List<Object>()

    Public

    Method Add:Void(child:Object)
        childs.AddLast(child)
    End

    Method Remove:Void(child:Object)
        childs.RemoveEach(child)
    End

    Method OnCreate:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn childs
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnCreate()
        End
    End

    Method OnLoading:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn childs
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnLoading()
        End
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
        Local castedChild:AppObserver
        For Local child:Object = EachIn childs
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnUpdate(deltatimer)
        End
    End

    Method OnRender:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn childs
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnRender()
        End
    End

    Method OnResume:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn childs
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnResume()
        End
    End

    Method OnSuspend:Void()
        Local castedChild:AppObserver
        For Local child:Object = EachIn childs
            castedChild = AppObserver(child)
            If castedChild Then castedChild.OnSuspend()
        End
    End
End
