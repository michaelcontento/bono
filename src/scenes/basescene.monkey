Strict

Private

Import bono.src.kernel
Import sceneable

Public

Class BaseScene Implements Sceneable Abstract
    Private

    Field childs:List<Renderable> = New List<Renderable>

    Public

    Method OnRender:Void()
        For Local obj:Renderable = EachIn childs
            obj.OnRender()
        End
    End

    Method OnSceneEnter:Void()
    End

    Method OnSceneLeave:Void()
    End

    Method AddChild:Void(child:Renderable)
        If Not childs.Contains(child) Then childs.AddLast(child)
    End

    Method RemoveChild:Void(child:Renderable)
        childs.RemoveEach(child)
    End
End
