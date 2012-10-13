Strict

Private

Import bono.kernel
Import scenemanager
Import sceneable
Import observerfan.appobserverfan
Import observerfan.touchobserverfan
Import observerfan.keyobserverfan

Public

Class BaseScene Implements Sceneable Abstract
    Private

    Field firstTimeEnter:Bool
    Field sceneManager:SceneManager
    Field appObserverFan:AppObserverFan = New AppObserverFan()
    Field keyObserverFan:KeyObserverFan = New KeyObserverFan()
    Field touchObserverFan:TouchObserverFan = New TouchObserverFan()

    Public

    Method OnCreate:Void()
    End

    Method OnLoading:Void()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
    End

    Method OnRender:Void()
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

    Method OnSceneEnter:Void()
        If Not firstTimeEnter
            firstTimeEnter = True
            appObserverFan.OnCreate()
        End

        sceneManager.appEmitter.AddObserver(appObserverFan)
        sceneManager.keyEmitter.AddObserver(keyObserverFan)
        sceneManager.touchEmitter.AddObserver(touchObserverFan)
    End

    Method OnSceneLeave:Void()
        sceneManager.appEmitter.RemoveObserver(appObserverFan)
        sceneManager.keyEmitter.RemoveObserver(keyObserverFan)
        sceneManager.touchEmitter.RemoveObserver(touchObserverFan)
    End

    Method SetSceneManager:Void(sceneManager:SceneManager)
        Self.sceneManager = sceneManager
    End

    Method GetSceneManager:SceneManager()
        Return sceneManager
    End

    Method Add:Void(child:Object)
        appObserverFan.Add(child)
        keyObserverFan.Add(child)
        touchObserverFan.Add(child)
    End

    Method Remove:Void(child:Object)
        appObserverFan.Remove(child)
        keyObserverFan.Remove(child)
        touchObserverFan.Remove(child)
    End
End
