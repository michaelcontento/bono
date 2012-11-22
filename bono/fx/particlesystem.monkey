Strict

Private

Import bono.graphics
Import bono.kernel
Import bono.utils
Import particle
Import particleemitter

Public

Class ParticleSystem Implements AppObserver
    Private

    Field sprite:Sprite
    Field emitters:Stack<ParticleEmitter> = New Stack<ParticleEmitter>()
    Field particles:StringMap<List<Particle>> = New StringMap<List<Particle>>()
    Field pool:Pool<Particle> = New Pool<Particle>()
    Field oldParticlePos:Vector2D = New Vector2D()

    Public

    Method New(sprite:Sprite)
        Self.sprite = sprite
    End

    Method Add:Void(emitter:ParticleEmitter)
        CheckEmitterName(emitter)
        emitters.Push(emitter)
        particles.Add(emitter.GetName(), New List<Particle>())
    End

    Method Clear:Void()
        For Local emitter:ParticleEmitter = EachIn emitters
            For Local particle:Particle = EachIn GetParticlesForEmitter(emitter)
                pool.Put(particle)
            End
            GetParticlesForEmitter(emitter).Clear()
        End
        emitters.Clear()
    End

    Method OnLoading:Void()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
        For Local emitter:ParticleEmitter = EachIn emitters
            If emitter.CanBeRemoved()
                If GetParticlesForEmitter(emitter).Count() = 0
                    emitters.RemoveEach(emitter)
                Else
                    UpdateParticles(deltatimer, emitter)
                End
            Else
                LaunchNewParticles(deltatimer, emitter)
                UpdateParticles(deltatimer, emitter)
            End
        End
    End

    Method OnRender:Void()
        For Local emitter:ParticleEmitter = EachIn emitters
            For Local particle:Particle = EachIn GetParticlesForEmitter(emitter)
                particle.Apply(sprite)
                sprite.OnRender()
            End
        End
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

    Method GetStats:String()
        Local result:String = ""
        result += "Emitter size: " + emitters.Length() + "~n"
        result += "   Pool size: " + pool.Length() + "~n"
        result += "-------------~n"

        For Local emitter:ParticleEmitter = EachIn emitters
            result += emitter.GetName()
            result += ": "
            result += GetParticlesForEmitter(emitter).Count()
            result += "~n"
        End

        Return result
    End

    Private

    Method CheckEmitterName:Void(emitter:ParticleEmitter)
        Local name:String = emitter.GetName()

        If name.Trim().Length() = 0
            Error("Emitter name is empty")
        End

        If particles.Contains(name)
            Error("There is already an emitter named " + name)
        End
    End

    Method LaunchNewParticles:Void(deltatimer:DeltaTimer, emitter:ParticleEmitter)
        Local amount:Int = emitter.GetLaunchAmount(deltatimer)
        For Local i:Int = 0 To amount
            Local newParticle:Particle = pool.Get()
            GetParticlesForEmitter(emitter).AddLast(newParticle)

            newParticle.Reset()
            emitter.OnParticleLaunch(deltatimer, newParticle)
        End
    End

    Method UpdateParticles:Void(deltatimer:DeltaTimer, emitter:ParticleEmitter)
        For Local particle:Particle = EachIn GetParticlesForEmitter(emitter)
            oldParticlePos.x = particle.position.x
            oldParticlePos.y = particle.position.y
            emitter.OnParticleUpdate(deltatimer, particle)

            If particle.active
                particle.lifetime += deltatimer.frameTime
                particle.previousPosition.x = oldParticlePos.x
                particle.previousPosition.y = oldParticlePos.y
            Else
                GetParticlesForEmitter(emitter).Remove(particle)
                pool.Put(particle)
            End
        End
    End

    Method GetParticlesForEmitter:List<Particle>(emitter:ParticleEmitter)
        Return particles.Get(emitter.GetName())
    End
End
