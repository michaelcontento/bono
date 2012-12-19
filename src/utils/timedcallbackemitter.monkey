Strict

Private

Import bono.src.kernel
Import timedcallbackobserver

Class CallbackNode
    Field name:String
    Field ttl:Int
    Field observer:TimedCallbackObserver
    Field listNode:list.Node<CallbackNode>
End

Public

Class TimedCallbackEmitter Implements Updateable
    Private

    Field callbacks:List<CallbackNode> = New List<CallbackNode>()

    Public

    Method Add:Void(name:String, observer:TimedCallbackObserver, duration:Int)
        Local node:CallbackNode = New CallbackNode()
        node.name = name
        node.observer = observer
        node.ttl = duration

        callbacks.AddLast(node)
        node.listNode = callbacks.LastNode()
    End

    Method Clear:Void()
        For Local node:CallbackNode = EachIn callbacks
            RemoveNode(node)
        End
    End

    Method ClearByName:Void(name:String)
        For Local node:CallbackNode = EachIn callbacks
            If node.name = name Then RemoveNode(node)
        End
    End

    Method Count:Int()
        Return callbacks.Count()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
        For Local node:CallbackNode = EachIn callbacks
            node.ttl -= deltatimer.frameTime
            If node.ttl > 0 Then Continue

            node.observer.OnTimedCallback(node.name)
            RemoveNode(node)
        End
    End

    Private

    Method RemoveNode:Void(node:CallbackNode)
        node.listNode.Remove()
        node.listNode = Null
        node.observer = Null
    End
End
