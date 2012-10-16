Strict

Public

Class StringHelper Abstract
    Function Randomize:String(input:String)
        Local split:String[] = input.Split("")
        Local len:Int = split.Length()

        For Local idx:Int = 0 Until len
            Local randomIdx:Int = Floor(Rnd(0, len))
            Local swap:String = split[idx]

            split[idx] = split[randomIdx]
            split[randomIdx] = swap
        End

        Return "".Join(split)
    End
End
