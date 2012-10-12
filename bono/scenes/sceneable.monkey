Strict

Private

Import scenemanager

Public

Interface Sceneable
    Method SetSceneManager:Void(sceneManager:SceneManager)
    Method GetSceneManager:SceneManager()
    Method OnSceneEnter:Void()
    Method OnSceneLeave:Void()
End
