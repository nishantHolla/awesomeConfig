<center>
<a href="https://awesomewm.org/">
<img src="./assets/project/awesomeConfig.png" alt="awesome wm"></img>
</a>
</center>
<br>

# awesomeConfig

Configuration files for awesome window manager.

## Modules

Just like awesomewm, this config is broken down to different modules which perform a specific task.
A quick overview of each user defined modules is given here. Each module must have its own folder in
the root config folder and must have an init.lua which then requires all other sub files in the given module.
<br><br>
Division of tasks into module makes the rc.lua small and easy to read which makes addition of features
simple.

### assets module

Stores all the assets like images required by the config and provides api calls to get image
paths easily.

### functions module

Stores user defined functions that are required by the config.

### keymaps module

Stores keymaps needed to control the window manager defined by the config.<br>
TODO: Add a script that lists out all the defined keymaps and their descriptions.

### notify module

A wraper around awesome's naughty module that provides some basic functions for notification required
by the config.

### scripts module

Some bash scripts that are used by the config.<br>
TODO: Port as much as possible to pure lua.

### theme module

Defines theming variables for awesome's beautiful module.

### values module

Stores some global values needed by the config.

### widgets

Stores user defined widgets that are required by the config.

## Testing

The test.sh script at the root of the config can be used to launch a nested X server with awesome
running. Note: It is not required that this config directory must be $XDG_CONFIG_HOME/awesome for
the testing script to run.

## Requirements

- Awesome window manager version >= 4.3
- playerctl for player control
- brightnessctl for brightness control
- alsa and pulseaudio for volume control
- acpi for battery indication
- [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen) for lock function
- [My collection of icons](https://github.com/nishantHolla/icons)
- [My rofi config](https://github.com/nishantHolla/system/tree/main/config/rofi)
