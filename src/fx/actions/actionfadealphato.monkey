Strict

Private

Import bono

Public

Class ActionFadeAlphaTo Extends BaseAction
    Private

    Field obj:Colorable
    Field target:Float
    Field start:Float
    Field distance:Float

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Colorable, Float)")
    End

    Method New(obj:Colorable, alpha:Float)
        Self.obj = obj
        target = alpha
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        start = obj.GetColor().alphaFloat
        distance = target - start
    End

    Method OnActionUpdate:Void(progress:Float)
        obj.GetColor().alphaFloat = (distance * progress) + start
    End
End
