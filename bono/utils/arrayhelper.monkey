Strict

Public

Class ArrayHelper<T> Abstract
    Function Randomize:Void(input:T[])
        Local len:Int = input.Length()

        For Local idx:Int = 0 Until len
            Local randomIdx:Int = Floor(Rnd(0, len))
            Local swap:T = input[idx]

            input[idx] = input[randomIdx]
            input[randomIdx] = swap
        End
    End
End
