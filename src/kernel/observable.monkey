Strict

Private

Import observer

Public

Interface Observable
    Method AddObserver:Void(observer:Observer)
    Method RemoveObserver:Void(observer:Observer)
    Method GetObservers:List<Observer>()
End
