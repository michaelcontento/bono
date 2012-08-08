Strict

Private

Import color
Import colorable

Public

Interface Effect
    Method OnProgress:Void(progress:Float)
End

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
            obj.color.red   = current.red
            obj.color.green = current.green
            obj.color.blue  = current.blue
            obj.color.alpha = current.alpha
        End
    End
End

Class EffectColorAlpha Extends List<Colorable> Implements Effect
    Private

    Field start:Float
    Field stop:Float
    Field current:Float

    Public

    Method New()
        Error("Wrong constructor. Use New(Float, Float)")
    End

    Method New(start:Float, stop:Float)
        Super.New()
        Self.start = start
        Self.stop = stop
    End

    Method OnProgress:Void(progress:Float)
        current = (stop - start) * progress + start

        For Local obj:Colorable = EachIn Self
            obj.color.alpha = current
        End
    End
End
