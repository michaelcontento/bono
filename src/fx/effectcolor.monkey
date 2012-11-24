Strict

Private

Import bono.src.graphics
Import effect

Public

Class EffectColor Extends List<Colorable> Implements Effect
    Private

    Field start:Color
    Field stop:Color
    Field current:Color = New Color()

    Public

    Method New()
        Error("Wrong constructor. Use New(Color, Color)")
    End

    Method New(start:Color, stop:Color)
        Super.New()
        Self.start = start.Copy()
        Self.stop = stop.Copy()
    End

    Method OnProgress:Void(progress:Float)
        current.red   = (stop.red   - start.red)   * progress + start.red
        current.green = (stop.green - start.green) * progress + start.green
        current.blue  = (stop.blue  - start.blue)  * progress + start.blue
        current.alpha = (stop.alpha - start.alpha) * progress + start.alpha

        For Local obj:Colorable = EachIn Self
            obj.GetColor().red   = current.red
            obj.GetColor().green = current.green
            obj.GetColor().blue  = current.blue
            obj.GetColor().alpha = current.alpha
        End
    End
End
