# TODO

* Wrap `AngelFont` into own `Font` that derived from `DisplayObject`
* `Director`
  * Make FPS in `Director` customizable
  * Make "deltatime FPS" in `Director` customizable
* `Highscore`
  * Refactor `Highscore` to use JSON
  * Refactor `Score` to easily support deviations with custom fields
* `Sprite`
  * Replace `Millisecs()` with the new `frameTime:Float` argument
  * Move the `LoadImage()` from `New()` into `OnCreate()`
* `InputController`
  * Copy the whole position list in `TouchEvent.Copy()`
  * Verify position acces for `TouchEvent`s with an empty positions list

# Instructions

Given your monkey project lives in `~/projects/tetris` and all sources are
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
