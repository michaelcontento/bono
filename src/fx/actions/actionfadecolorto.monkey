Strict

Private

Import bono

Public

Class ActionFadeColorTo Extends BaseAction
    Private

    Field obj:Colorable
    Field target:Color
    Field start:Color
    Field distance:Color

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Colorable, Color)")
    End

    Method New(obj:Colorable, target:Color)
        Self.obj = obj
        Self.target = target
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        start = obj.GetColor().Copy()
        distance = New Color()
        distance.red = target.red - start.red
        distance.green = target.green - start.green
        distance.blue = target.blue - start.blue
        distance.alpha = target.alpha - start.alpha
    End

    Method OnActionUpdate:Void(progress:Float)
        Local objColor := obj.GetColor()
        objColor.red = (distance.red * progress) + start.red
        objColor.green = (distance.green * progress) + start.green
        objColor.blue = (distance.blue * progress) + start.blue
        objColor.alpha = (distance.alpha * progress) + start.alpha
    End
End
