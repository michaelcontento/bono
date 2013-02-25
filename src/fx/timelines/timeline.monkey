Strict

Private

Import bono

Public

Class Timeline Implements Updateable
    Private

    Field actions := New List<Action>()
    Field currentNode:list.Node<Action>
    Field finished := False
    Field isActionStarted := False

    Public

    Method Append:Void(action:Action)
        actions.AddLast(action)
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        If finished Then Return
        If Not currentNode Then currentNode = actions.FirstNode()

        Local currentAction := currentNode.Value()
        If Not isActionStarted
            isActionStarted = True
            currentAction.OnActionStart()
        End
        currentAction.OnUpdate(timer)

        If Not currentAction.IsFinished() Then Return

        currentAction.OnActionEnd()
        isActionStarted = False
        currentNode = currentNode.NextNode()
        If Not currentNode Then finished = True
    End
End
