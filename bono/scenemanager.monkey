Strict

Private

Import director
Import scene

Public

Class SceneManager
    Private

    Field scenes:StringMap<Scene> = New StringMap<Scene>()
    Field created:List<String> = New List<String>()
    Field _current:Scene
    Field _prevScene:Scene
    Field _nextScene:Scene
    Field _director:Director

    Public

    Method New(director:Director)
        _director = director
    End

    Method Add:Void(scene:Scene)
        If scenes.Contains(scene.name)
            Error("Scenemanager already contains a scene named " + scene.name)
        End

        scene.scenes = Self
        scenes.Set(scene.name, scene)
    End

    Method Get:Scene(name:String)
        Return scenes.Get(name)
    End

    Method Goto:Void(scene:Scene)
        Goto(scene.name)
    End

    Method Goto:Void(name:String)
        If _nextScene And _nextScene.name = name Then Return
        _prevScene = _current
        _nextScene = scenes.Get(name)

        If Not created.Contains(name)
            created.AddLast(name)
            _nextScene.OnCreate()
        End

        If _current Then _current.OnLeave()
        _nextScene.OnEnter()

        _current = _nextScene
    End

    Method nextScene:Scene() Property
        Return _nextScene
    End

    Method prevScene:Scene() Property
        Return _prevScene
    End

    Method scene:Scene() Property
        Return _current
    End

    Method director:Director() Property
        Return _director
    End
End
