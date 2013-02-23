Strict

Private

Import bono

Public

Class EffectColor Extends List<Colorable> Implements Effect
    Private

    Field start:Color
    Field stop:Color
    Field current:Color = New Color()

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Color, Color)")
    End

    Method New(start:Color, stop:Color)
        Super.New()
        Self.start = start.Copy()
        Self.stop = stop.Copy()
    End

    Method OnProgress:Void(progress:Float)
        current.redFloat   = (stop.red   - start.red)   * progress + start.red
        current.greenFloat = (stop.green - start.green) * progress + start.green
        current.blueFloat  = (stop.blue  - start.blue)  * progress + start.blue
        current.alphaFloat = (stop.alpha - start.alpha) * progress + start.alpha

        For Local obj:Colorable = EachIn Self
            obj.GetColor().red   = current.red
            obj.GetColor().green = current.green
            obj.GetColor().blue  = current.blue
            obj.GetColor().alpha = current.alpha
        End
    End
End
