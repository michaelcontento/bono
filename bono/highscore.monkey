Strict

Private

Import persistable
Import score

Public

Class Highscore<T> Implements Persistable
    Private

    Field objects:List<Score<T>> = New List<Score<T>>()
    Field _maxCount:Int

    Public

    Method New(maxCount:Int)
        _maxCount = maxCount
    End

    Method Add:Void(key:String, value:T)
        objects.AddLast(New Score<T>(key, value))
        Sort()
        SizeTrim()
    End

    Method Clear:Void()
        objects.Clear()
    End

    Method Count:Int()
        Return objects.Count()
    End

    Method FromString:Void(input:String)
        objects.Clear()
        Local key:String
        Local value:T
        Local splitted:String[] = input.Split(",")

        For Local count:Int = 0 To splitted.Length() - 2 Step 2
            key = splitted[count].Replace("[COMMA]", ",")
            value = T(splitted[count + 1])
            objects.AddLast(New Score<T>(key, value))
        End

        Sort()
    End

    Method ToString:String()
        Local result:String
        For Local score:Score<T> = EachIn Self
            result += score.key.Replace(",", "[COMMA]") + "," + score.value + ","
        End
        Return result
    End

    Method ObjectEnumerator:list.Enumerator<Score<T>>()
        Return objects.ObjectEnumerator()
    End

    Method First:Score<T>()
        If objects.Count() = 0 Then Return New Score<T>("", 0)
        Return objects.First()
    End

    Method Last:Score<T>()
        If objects.Count() = 0 Then Return New Score<T>("", 0)
        Return objects.Last()
    End

    Method maxCount:Int() Property
        Return _maxCount
    End

    Private

    Method SizeTrim:Void()
        While objects.Count() > _maxCount
            objects.RemoveLast()
        End
    End

    Method Sort:Void()
        If objects.Count() < 2 Then Return

        Local newList:List<Score<T>> = New List<Score<T>>()
        Local current:Score<T>

        While objects.Count() > 0
            current = objects.First()
            For Local check:Score<T> = EachIn objects
                If check.value < current.value
                    current = check
                End
            End

            newList.AddFirst(current)
            objects.Remove(current)
        End

        objects.Clear()
        objects = newList
    End
End

Class IntHighscore Extends Highscore<Int>
    Method New(maxCount:Int)
        Super.New(maxCount)
    End
End

Class FloatHighscore Extends Highscore<Float>
    Method New(maxCount:Int)
        Super.New(maxCount)
    End
End
