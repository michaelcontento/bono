Strict

Private

Import bono

Public

Interface ParticleEmitter
    Method GetName:String()
    Method GetLaunchAmount:Int(deltatimer:DeltaTimer)
    Method CanBeRemoved:Bool()
    Method OnParticleLaunch:Void(deltatimer:DeltaTimer, particle:Particle)
    Method OnParticleUpdate:Void(deltatimer:DeltaTimer, particle:Particle)
End
