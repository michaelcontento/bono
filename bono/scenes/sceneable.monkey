Strict

Private

Import scenemanager
Import bono.kernel

Public

Interface Sceneable Extends AppObserver
    Method OnSceneEnter:Void()
    Method OnSceneLeave:Void()
    Method SetSceneManager:Void(sceneManager:SceneManager)
    Method GetSceneManager:SceneManager()
End
