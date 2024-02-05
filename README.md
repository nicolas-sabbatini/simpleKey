# Simple Key

## Description

Simple Key is a simple yet awesome input library for Love2d.
The objective of this library is to make the keyboard input handle easy in a small and
compact way, the module don't change the _love.keypressed(key)_ so you can have
multiple instances running without collisions.

The library is aimed to be used in small projects.

## Motivations

There is a lot of input libraries for Love2d, but all of them are big and complex, and
it can be a little over kill use a library that can handel joystick and touch screen
for a small project, so I made this.

## Usage

```lua
local key = require('simpleKey')
local keyInstance = key:createInstance({'space'})

function love.update(dt)
    keyInstance:updateInput()
    if keyInstance:isDown('space') then print('space dawn') end
    if keyInstance:justReleased('space') then print('space got released') end
    if keyInstance:justPressed('space') then print('space is jusr pressed') end
end
```

## API

```lua
-- Create a new instance of simpleKey.
-- @_param_ `keys` (string or table) — The keys to bind.
-- @_return_ `instance` — The new instance of simpleKey.
simpleKey:createInstance(keys)
```

```lua
-- Check if a key is dawn, this key don't need to be bound.
-- This function is a wrapper for _love.keyboard.isDown(key)_.
-- @_param_ `key` — The key to check.
-- @_return_ `down` — True if the key is down, false if not.
instance:checkDown(key)
```

```lua
-- Bind a key or a table of keys to the instance.
-- @_param_ `keys` (string or table) — The keys to bind.
instance:keyBind(keyToBind)
```

```lua
-- Unbind a key or a table of keys in the instance.
-- @_param_ `keys` (string or table) — The keys to unbind.
instance:keyUnbind(keys)
```

```lua
-- Update the state of all bound keys.
instance:updateInput()
```

```lua
-- Return true if is the first frame the bound key is down.
-- @_param_ `key` — The key to check.
-- @_return_ `down` — True if the key is down, false if not.
instance:justPressed(key)
```

```lua
-- Return true if a bound key is down.
-- @_param_ `key` — The key to check.
-- @_return_ `down` — True if the key is down, false if not.
instance:isDown(k)
```

```lua
-- Return true if is the first frame the bound key is released.
-- @_param_ `key` — The key to check.
-- @_return_ `down` — True if the key is released, false if not.
instance:justReleased(k)
```

