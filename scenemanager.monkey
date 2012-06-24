Strict

Private

Import scene

Public

Class SceneManager
    Private

    Field scenes:StringMap<Scene> = New StringMap<Scene>
    Field nextScene_:Scene
    Field current_:Scene

    Public

    Method nextScene:Scene() Property
        Return nextScene_
    End

    Method current:Scene() Property
        Return current_
    End

    Method Add:Void(scene:Scene)
        If scenes.IsEmpty()
            current_ = scene
        ElseIf scenes.Contains(scene.name)
            Error("Scenemanager already contains a scene name " + scene.name)
        End

        scenes.Set(scene.name, scene)
    End

    Method Get:Scene(name:String)
        Return scenes.Get(name)
    End

    Method Goto:Void(name:String)
        If nextScene_ And nextScene_.name = name Then Return
        nextScene_ = scenes.Get(name)

        If Not nextScene_.created
            nextScene_.OnCreate()
            nextScene_.created = True
        End

        If current_ Then current_.OnLeave()
        nextScene_.OnEnter()

        current_ = nextScene_
    End
End
