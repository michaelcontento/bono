Strict

Private

Import scenemanager
Import bono.src.kernel

Public

Interface Sceneable Extends AppObserver
    Method OnSceneEnter:Void()
    Method OnSceneLeave:Void()
    Method SetSceneManager:Void(sceneManager:SceneManager)
    Method GetSceneManager:SceneManager()
End
