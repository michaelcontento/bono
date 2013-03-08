Strict

Private

Import bono

Public

Interface Sizeable
    Method GetSize:Vector2D()
    Method SetSize:Void(newSize:Vector2D)

    ' TODO: Remove this? It's just sugar and hides one Copy() ...
    Method GetCenter:Vector2D()
End
