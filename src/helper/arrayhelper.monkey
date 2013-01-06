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

    Function CreateArray:T[][](rows:Int, cols:Int)
        Local a:T[][] = New T[rows][]

        For Local i:Int = 0 Until rows
            a[i] = New T[cols]
        End For

        Return a
    End

    Function CreateArray:T[][][](x:Int, y:Int, z:Int)
        Local a:T[][][] = New T[x][][]

        For Local i:Int = 0 Until x
            a[i] = New T[y][]
            For Local j:Int = 0 Until z
                a[i][j] = New T[z]
            Next
        End

        Return a
    End
End
