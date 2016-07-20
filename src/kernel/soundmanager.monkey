Strict

Private

Import bono
Import mojo.audio

Public

Class SoundManager
    Private

    Field sounds:StringMap<Sound> = New StringMap<Sound>()
    Field files:StringMap<String> = New StringMap<String>()
    Field extensions:String[] = ["mp3"]
    Field loopEnabled:StringMap<Bool> = New StringMap<Bool>()
    Field musicSounds:StringMap<Bool> = New StringMap<Bool>()
    Field lastChannel:Int
    Const CHANNELS:Int = 32

    Public

    Field failOnLoadingError:Bool = True
    Field newSoundCanStopOldest:Bool = True

    Method Add:Void(key:String, file:String)
        If files.Contains(key) Then Error("Key " + key + " already used")
        files.Set(key, file)
    End

    Method AddMusic:Void(key:String, file:String)
        Add(key, file)
        musicSounds.Set(key, True)
    End

    Method Preload:Void(name:String)
        If Not files.Contains(name) Then Return
        If sounds.Contains(name) Then Return
        If musicSounds.Contains(name) Then Return

        Local tmpSound := LoadSound(files.Get(name))
        If tmpSound = Null Then Return

        sounds.Set(name, tmpSound)
    End

    Method PreloadAll:Void()
        Local tmpSound:Sound
        For Local node:map.Node<String, String> = EachIn files
            If sounds.Contains(node.Key()) Then Continue
            If musicSounds.Contains(node.Key()) Then Continue

            tmpSound = LoadSound(node.Value())
            If tmpSound = Null Then Continue

            sounds.Set(node.Key(), tmpSound)
        End
    End

    Method LoopEnable:Void(key:String)
        loopEnabled.Set(key, True)
    End

    Method LoopDisable:Void(key:String)
        loopEnabled.Remove(key)
    End

    Method Play:Void(key:String)
        If musicSounds.Contains(key)
            PlayMusic(key)
        Else
            PlaySound(key)
        End
    End

    Method Pause:Void()
        PauseMusic()
        PauseSounds()
    End

    Method PauseMusic:Void()
        audio.PauseMusic()
    End

    Method PauseSounds:Void()
        For Local i := 0 To CHANNELS
            PauseChannel(i)
        End
    End

    Method Resume:Void()
        ResumeMusic()
        ResumeSounds()
    End

    Method ResumeMusic:Void()
        audio.ResumeMusic()
    End

    Method ResumeSounds:Void()
        For Local i := 0 To CHANNELS
            ResumeChannel(i)
        End
    End

    Private

    Method PlayMusic:Void(key:String)
        Local isLoop:Bool = loopEnabled.Contains(key)
        Local file:String = files.Get(key)

        For Local idx:Int = 0 Until extensions.Length()
            audio.PlayMusic(file + "." + extensions[idx], isLoop)
            If MusicState() = 1 Then Return
        End
    End

    Method PlaySound:Void(key:String)
        If Not sounds.Contains(key) Then Return

        Local channel:Int = GetFreeChannel()
        If channel = -1 Then Return

        audio.PlaySound(sounds.Get(key), channel, loopEnabled.Contains(key))
    End

    Method GetFreeChannel:Int()
        Local channelsChecked:Int = 0
        Local channelId:Int = lastChannel

        Repeat
            channelId += 1
            If channelId >= CHANNELS Then channelId = 0

            ' Skip the ChannelState check on Android, because:
            ' > Android: ChannelState always returns -1, ie: 'unknown'. Sounds
            ' >          to be used with PlaySound must be less than 1MB in
            ' >          length. Longer sounds can be played using the music
            ' >          commands.
            ' Source: http://blitz-wiki.appspot.com/mojo.audio
            If Target.IS_ANDROID Or ChannelState(channelId) = 0
                lastChannel = channelId
                Return channelId
            End

            channelsChecked += 1
        Until channelsChecked >= CHANNELS

        If Not newSoundCanStopOldest Then Return -1

        lastChannel += 1
        If lastChannel >= CHANNELS Then lastChannel = 0
        StopChannel(lastChannel)
        Return lastChannel
    End

    Method LoadSound:Sound(file:String)
        Local tmpSound:Sound
        For Local idx:Int = 0 Until extensions.Length()
            tmpSound = audio.LoadSound(file + "." + extensions[idx])
            If Not (tmpSound = Null) Then Return tmpSound
        End

        If failOnLoadingError Then Error("Unable to load sound file: " + file)
        Return Null
    End
End
