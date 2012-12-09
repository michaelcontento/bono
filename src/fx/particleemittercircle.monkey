Strict

Private

Import bono.src.utils
Import bono.src.kernel
Import particle
Import particleemitter

Public

Class ParticleEmitterCircle Implements ParticleEmitter
    Private

    Field name:String
    Field launched:Bool
    Field counter:Int = 0

    Public

    Field particlesPerBurst:Int = 10
    Field numberOfBursts:Int = 1
    Field particleLifetime:Float = 1000
    Field velocity:Vector2D = New Vector2D(1, 0)
    Field friction:Float = 1
    Field fadeMode:Int = NONE
    Field position:Vector2D = New Vector2D()

    Const NONE:Int = 0
    Const IN:Int = 1
    Const OUT:Int = 2

    Method New(name:String)
        Self.name = name
    End

    Method GetName:String()
        Return name
    End

    Method GetLaunchAmount:Int(deltatimer:DeltaTimer)
        If launched Then Return 0

        launched = True
        Return particlesPerBurst
    End

    Method CanBeRemoved:Bool()
        Return launched
    End

    Method OnParticleLaunch:Void(deltatimer:DeltaTimer, particle:Particle)
        particle.velocity.Copy(velocity).Rotate(GetNextAngel())
        particle.position.Copy(position)
    End

    Method OnParticleUpdate:Void(deltatimer:DeltaTimer, particle:Particle)
        particle.position.Add(particle.velocity.Mul(friction))
        particle.active = (particle.lifetime < particleLifetime)

        If Not fadeMode = NONE
            particle.color.alpha = particle.lifetime / particleLifetime
            If fadeMode = OUT Then particle.color.alpha = 1 - particle.color.alpha
        End
    End

    Private

    Method GetNextAngel:Float()
        counter += 1
        Return (360 / particlesPerBurst) * counter
    End
End
