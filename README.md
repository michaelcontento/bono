# [Bono][]

## Instructions

Given your [Monkey][] project lives in `~/projects/tetris` and all sources are
inside an own folder named `tetris` this should be repeatable for you:

    $ cd ~/projects/tetris
    $ ls -l
    total
    drwxr-xr-x 2 Jun 19 20:02 tetris
    drwxr-xr-x 3 Jun 19 22:59 tetris.build
    drwxr-xr-x 2 Jun 19 21:52 tetris.data
    -rw-r--r-- 1 Jun 19 19:02 tetris.monkey

This layout should be pretty self explaining - if not:

1. `tetris` is where your source goes
1. `tetris.build` is where monkey will generate your project into
1. `tetris.data` your data directory (images, sounds, ...)
1. `tetris.monkey` the main entry file

So bono needs to be available inside `tetris` and to achive this we simple add
bono as a new submodule:

    $ cd ~/project/tetris
    $ git submodule add git@github.com:michaelcontento/bono.git tetris/bono

And yes - it's really that easy ;)

## License

    Copyright 2012 Michael Contento <michaelcontento@gmail.com>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

  [Bono]: https://github.com/michaelcontento/bono
  [Monkey]: http://monkeycoder.co.nz
