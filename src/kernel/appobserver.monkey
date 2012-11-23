Strict

Private

Import observer
Import deltatimer

Public

Interface AppObserver Extends Observer
    Method OnLoading:Void()
    Method OnUpdate:Void(deltatimer:DeltaTimer)
    Method OnRender:Void()
    Method OnResume:Void()
    Method OnSuspend:Void()
End
