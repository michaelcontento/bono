Strict

Private

Import bono

Public

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
            obj.GetColor().alpha = current
        End
    End
End
