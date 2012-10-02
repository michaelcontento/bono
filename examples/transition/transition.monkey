Strict

Import bono
Import mojo.graphics

Class Handler Implements AppObserver, TouchObserver
    Private

    Field transitions:Stack<Transition> = New Stack<Transition>()
    Field names:StringStack = New StringStack()
    Field stackIndex:Int

    Public

    Method OnCreate:Void()
        transitions.Push(New TransitionLinear())
        names.Push("Linear")

        transitions.Push(New TransitionInQuad())
        names.Push("In Quad")

        transitions.Push(New TransitionOutQuad())
        names.Push("Out Quad")

        transitions.Push(New TransitionInOutQuad())
        names.Push("In Out Quad")

        transitions.Push(New TransitionInCubic())
        names.Push("In Cubic")

        transitions.Push(New TransitionOutCubic())
        names.Push("Out Cubic")

        transitions.Push(New TransitionInOutCubic())
        names.Push("In Out Cubic")

        transitions.Push(New TransitionInQuart())
        names.Push("In Quart")

        transitions.Push(New TransitionOutQuart())
        names.Push("Out Quart")

        transitions.Push(New TransitionInOutQuart())
        names.Push("In Out Quart")

        transitions.Push(New TransitionInSine())
        names.Push("In Sine")

        transitions.Push(New TransitionOutSine())
        names.Push("Out Sine")

        transitions.Push(New TransitionInOutSine())
        names.Push("In Out Sine")

        transitions.Push(New TransitionInExpo())
        names.Push("In Expo")

        transitions.Push(New TransitionOutExpo())
        names.Push("Out Expo")

        transitions.Push(New TransitionInOutExpo())
        names.Push("In Out Expo")

        transitions.Push(New TransitionInCirc())
        names.Push("In Circ")

        transitions.Push(New TransitionOutCirc())
        names.Push("Out Circ")

        transitions.Push(New TransitionInOutCirc())
        names.Push("In Out Circ")

        transitions.Push(New TransitionInElastic())
        names.Push("In Elastic")

        transitions.Push(New TransitionOutElastic())
        names.Push("Out Elastic")

        transitions.Push(New TransitionInOutElastic())
        names.Push("In Out Elastic")

        transitions.Push(New TransitionInBack())
        names.Push("In Back")

        transitions.Push(New TransitionOutBack())
        names.Push("Out Back")

        transitions.Push(New TransitionInOutBack())
        names.Push("In Out Back")

        transitions.Push(New TransitionInBounce())
        names.Push("In Bounce")

        transitions.Push(New TransitionOutBounce())
        names.Push("Out Bounce")

        transitions.Push(New TransitionInOutBounce())
        names.Push("In Out Bounce")

        transitions.Push(New TransitionRandom())
        names.Push("Random")

        transitions.Push(New TransitionRandom(0.05, 0.25, New TransitionLinear()))
        names.Push("Random Linear (min: 5% max: 15%)")

        transitions.Push(New TransitionRandom(0.05, 0.25, New TransitionInOutCirc()))
        names.Push("Random In Out Circ (min: 5% max: 15%)")
    End

    Method OnLoading:Void()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
    End

    Method OnRender:Void()
        Local transition:Transition = transitions.Get(stackIndex)
        Local maxY:Float = 100
        Local minY:Float = DeviceHeight() - 100
        Local lastY:Float = minY
        Local lastX:Float
        Local progress:Float
        Local y:Float

        SetColor(255, 255, 255)
        For Local x:Int = 0 Until DeviceWidth()
            progress = x / Float(DeviceWidth())
            y = (maxY - minY) * transition.Calculate(progress) + minY

            DrawLine(lastX, lastY, x, y)

            lastX = x
            lastY = y
        End
        DrawText(names.Get(stackIndex), 50, 50)

        SetColor(0, 255, 0)
        DrawLine(0, minY, DeviceWidth(), minY)
        DrawLine(0, maxY, DeviceWidth(), maxY)
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

    Method OnTouchDown:Void(event:TouchEvent)
        stackIndex += 1
        If stackIndex >= transitions.Length() Then stackIndex = 0
    End

    Method OnTouchMove:Void(event:TouchEvent)
    End

    Method OnTouchUp:Void(event:TouchEvent)
    End
End

Function Main:Int()
    Local handler:Handler = New Handler()

    Local touchEmitter:TouchEmitter = New TouchEmitter()
    touchEmitter.AddObserver(handler)

    Local appEmitter:AppEmitter = New AppEmitter()
    appEmitter.AddObserver(touchEmitter)
    appEmitter.AddObserver(handler)
    appEmitter.Run()

    Return 0
End
