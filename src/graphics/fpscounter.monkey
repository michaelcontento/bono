Strict

Private

Import bono
Import mojo.graphics

Public

Class FpsCounter Extends BaseDisplayObject Implements Updateable, Renderable
    Private

    Const FONT_HEIGHT:Int = 20
    Field fpsCounter:Int
    Field fpsHistory:Int[]
    Field historyLength:Int
    Field lastSampleTime:Float
    Field maxFps:Int
    Field sampleDuration:Int
    Field samplesPerSec:Int

    Public

    Method New(historyLength:Int=60, samplesPerSec:Int=4)
        Self.historyLength = historyLength
        Self.samplesPerSec = samplesPerSec

        fpsHistory = New Int[historyLength]
        sampleDuration = 1000.0 / samplesPerSec

        SetPosition(New Vector2D(0, 0))
        SetSize(New Vector2D(100, 60))
    End

    Method OnRender:Void()
        fpsCounter += 1

        GetColor().Activate()
        OnRenderText()
        OnRenderHistogram()
        GetColor().Deactivate()
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        lastSampleTime += timer.frameTime
        If lastSampleTime >= sampleDuration
            lastSampleTime -= sampleDuration

            UpdateHistory()

            fpsHistory[historyLength - 1] = fpsCounter * samplesPerSec
            maxFps = Max(maxFps, fpsHistory[historyLength - 1])
            fpsCounter = 0
        End
    End

    Private

    Method UpdateHistory:Void()
        maxFps = 0
        For Local i:Int = 0 Until historyLength - 1
            Local tmp:Int = fpsHistory[i]
            fpsHistory[i] = fpsHistory[i + 1]
            fpsHistory[i + 1] = tmp

            maxFps = Max(maxFps, fpsHistory[i])
        End
    End

    Method OnRenderText:Void()
        DrawText(
            "FPS: " + fpsHistory[historyLength - 1],
            GetPosition().x,
            GetPosition().y)
    End

    Method OnRenderHistogram:Void()
        Local maxPosY:Float = GetPosition().y + GetSize().y
        Local maxLineY:Float = maxPosY - (GetPosition().y + FONT_HEIGHT)
        Local heightFactor:Float = 1.0 / maxFps

        For Local i:Int = 0 Until historyLength
            DrawLine(
                GetPosition().x + i,
                maxPosY - (maxLineY * heightFactor * fpsHistory[i]),
                GetPosition().x + i,
                maxPosY)
        End
    End
End
