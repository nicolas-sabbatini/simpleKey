# Simple Key

> Disclaimer: English is not my first language and I never took a English class, fell free to correct any error o misspelling.

### Description
Simple Key is a simple yet awesome input library for Love2d.
The objective of this library is to make the keyboard input handle easy in a small and compact way.
The library is aimed to be used in small proyects.

### Motivations
There is a lot of input libraries for Love2d, but all of them are big and complex, and can be a little over kill use a library that can handel joystick and touch screen for a small project, so I made this.

### Usage

```lua   
key = require('simpleKey')

function love.load()
    key:keyInit({'space'})
end

function love.update(dt)
    key:updateInput()
    if key:isDown('space') then print('space dawn') end
    if key:isReleased('space') then print('space got relised') end
end
```
### API
```lua
        keyInit() -- Init all variables.
        keyBind() -- Bind a key or a table of keys.
        keyUnbind() -- Unbind a key or a table of keys.
        updateInput() -- Update the state of all bound keys.
        isDown() -- Return true if a bound key is down.
        isReleased() -- Return true if a bound key relesed in this frame.
        checkDown() -- Check if a key is dawn, this key don't need to be bound.
```

### Dependencies
Love2D