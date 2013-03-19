# [Bono][]

This is my personal (and first) 2D engine / module library for [Monkey][] -
a "cross translator" that translates into html5, objective-c, c++ and even
flash.

## Getting started

### Installation?

Just clone this project to some path that monkey is actual using for source
lookups. This is usually something like `.` and `$MONKEY_DIR/modules`. So feel
free to install it system wide for all monkey projects with:

    $ cd $MONKEY_DIR
    $ git clone git://github.com/michaelcontento/bono.git modules/bono

But this is something I would __not__ recommend! Because if your usign a proper
SCM for your project (if not: do it. right. now.), you can track the used bono
version. This allows you to handle multiple projects with different versions
of bono and it's easy to build a project again even after months of inactivity
(because you know which bono version to use).

__TL;DR__ Do something like this:

    $ cd $PROJECT_DIR
    $ git submodule add git://github.com/michaelcontento/bono.git
    $ git submodule update --init

### How to start?

Use this short example as a starting point:

```monkey
Import bono
Import mojo

Class MyApp Extends bono.App
    Method Run:Void()
        GetDirector().AddScene("menu", New MenuScene())
        GetDirector().GotoScene("menu")
    End
End

Class MenuScene Extends Scene
    Method OnRender:Void()
        DrawText("Hello World", 100, 100)
    End
End

Function Main:Int()
    New MyApp()
    Return 0
End
```

And please visit `src/kernel/` as this "sub-module" contains all the core stuff
like how the different events (`OnRender`, `OnUpdate`, `OnTouchDown` etc.) are
dispatched. You need to understand a few principles and everything else should
be rather simple :)

## Documentation?

Jesus. Read the code!

No, just kidding. I try my best to put a `README.md` with some instructions
right beside the code. So just browse the `src/` directory and Github should
render some nice docs below the folder listing. If not? Well .. that's a sign
that I haven't wrote anything yet. Read the code and I'd love to accept a PR
with improved docs ;)

## Games built with Bono

* All [CoRa Games][] games - [Full listing of all games][cr-1]
* Drag-Math: Multiplication on [Google Play][dm-1], [Amazon][dm-2]

## License

    Copyright 2009-2013 Michael Contento <michaelcontento@gmail.com>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

  [bono]: https://github.com/michaelcontento/bono
  [monkey]: http://monkeycoder.co.nz
  [CoRa Games]: http://www.coragames.com
  [cr-1]: http://www.coragames.com/games
  [dm-1]: https://play.google.com/store/apps/details?id=com.neriogames.math.multiplication
  [dm-2]: http://www.amazon.com/Nerio-Games-Math-Multiplication-Trainer/dp/B00BQ1PWW8/ref=sr_1_1?s=mobile-apps&ie=UTF8&qid=1363728371&sr=1-1&keywords=nerio+games
