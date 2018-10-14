# Kill That Zombie

As the name already states, this is a top-down shooter! It is implemented using [Godot Engine](https://godotengine.org/) and its own
scripting language [GDScript](https://godot.readthedocs.io/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html).

## How to build

In order to build the game, you need to install [Godot](https://godotengine.org/download/).
If you have installed the GUI version, simply click `Project` -> `Export`, choose your desired target and click `Export Project`.

On Linux you can also build it using the headless version. This also works with the GUI version though.

```shell
godot --path /path/to/project --export "linux-x11"
```

## How do I install the game

Currently there are no binaries available.

## How do I contribute

1. Fork the project
2. Clone the forked repository
    ```shell
    git clone git@github.com:YourName/RepositoryName
    ```
3. Create a new branch
    ```shell
    git checkout -b name-that-states-what-you-do
    ```
4. Make your changes
5. Create a pull request on our `develop` branch.
