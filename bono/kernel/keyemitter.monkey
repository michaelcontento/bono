Strict

Private

Import appobserver
Import deltatimer
Import keyevent
Import keyobserver
Import mojo.input
Import observable

Public

Class KeyEmitter Implements Observable, AppObserver
    Private

    Const DOWN:Int = 0
    Const UP:Int = 1
    Const PRESS:Int = 2
    Field keyboardEnabled:Bool
    Field keyEvents:IntMap<KeyEvent> = New IntMap<KeyEvent>()
    Field keysActive:IntSet = New IntSet()
    Field dispatchedKeyEvents:IntSet = New IntSet()
    Field observers:List<KeyObserver> = New List<KeyObserver>()

    Public

    Field active:Bool = True

    Method OnCreate:Void()
    End

    Method OnLoading:Void()
    End

    Method OnRender:Void()
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
        If Not active
            DisableKeyboard()
        Else
            EnableKeyboard()
            ReadKeys()
            ProcessKeys()
        End
    End

    Method AddObserver:Void(observer:KeyObserver)
        If observers.Contains(observer) Then Return
        observers.AddLast(observer)
    End

    Method RemoveObserver:Void(observer:KeyObserver)
        observers.RemoveEach(observer)
    End

    Method GetObservers:List<KeyObserver>()
        Return observers
    End

    Private

    Method DisableKeyboard:Void()
        If Not keyboardEnabled Then Return

        keyboardEnabled = False
        input.DisableKeyboard()
        keysActive.Clear()
        keyEvents.Clear()
        dispatchedKeyEvents.Clear()
    End

    Method EnableKeyboard:Void()
        If keyboardEnabled Then Return

        keyboardEnabled = True
        input.EnableKeyboard()
    End

    Method ProcessKeys:Void()
        For Local event:KeyEvent = EachIn keyEvents.Values()
            If Not dispatchedKeyEvents.Contains(event.code)
                NotifyKey(DOWN, event)
                dispatchedKeyEvents.Insert(event.code)
                Continue
            End

            If Not keysActive.Contains(event.code)
                NotifyKey(UP, event)
                dispatchedKeyEvents.Remove(event.code)
                keyEvents.Remove(event.code)
            Else
                NotifyKey(PRESS, event)
            End
        End
    End

    Method ReadKeys:Void()
        keysActive.Clear()
        Local charCode:Int

        Repeat
            charCode = GetChar()
            If Not charCode Then Return

            keysActive.Insert(charCode)
            If Not keyEvents.Contains(charCode)
                keyEvents.Add(charCode, New KeyEvent(charCode))
                dispatchedKeyEvents.Remove(charCode)
            End
        Forever
    End

    Method NotifyKey:Void(mode:Int, event:KeyEvent)
        For Local observer:KeyObserver = EachIn GetObservers()
            Select mode
            Case DOWN
                observer.OnKeyDown(event)
            Case UP
                observer.OnKeyUp(event)
            Case PRESS
                observer.OnKeyPress(event)
            Default
                Error("Invalid mode " + mode + " for NotifyKey given")
            End
        End
    End
End
