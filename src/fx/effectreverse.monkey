Strict

Private

Import bono

Public

Class EffectReverse Implements Effect
    Private

    Field effect:Effect

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Effect)")
    End

    Method New(effect:Effect)
        Self.effect = effect
    End

    Method OnProgress:Void(progress:Float)
        effect.OnProgress(1.0 - progress)
    End
End
