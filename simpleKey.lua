--[[
LUA MODULE
        Simple Key v$(_VERSION)

AUTHOR
        Nicolas C. Sabbatini V.

LICENSE
        MIT License - Copyright (c) 2024

HOME PAGE
        https://github.com/nicolas-sabbatini/simpleKey

DESCRIPTION
        Simple Key is a simple yet awesome input library for Love2d.
        The objective of this library is to make the keyboard input handle
        easy in a small and compact way, the module don't change the
        *love.keypressed(key)* so you can have multiple instances running
        without collisions.
        The library is aimed to be used in small projects.

MOTIVATIONS
        There is a lot of input libraries for Love2d, but all of them are big
        and complex, and can be a little over kill use a library that can handel
        joystick and touch screen for a small project, so I made this.

USAGE
        local key = require('simpleKey')
        local keyInstance = key:createInstance({'space'})

        function love.update(dt)
            keyInstance:updateInput()
            if keyInstance:isDown('space') then print('space dawn') end
            if keyInstance:justReleased('space') then print('space got released') end
            if keyInstance:justPressed('space') then print('space is jusr pressed') end
        end

API

```lua
simpleKey:createInstance(keys)
```
Create a new instance of simpleKey.
@*param* `keys` (string or table) — The keys to bind.
@*return* `instance` — The new instance of simpleKey.

```lua
instance:checkDown(key)
```
Check if a key is dawn, this key don't need to be bound.
This function is a wrapper for *love.keyboard.isDown(key)*.
@*param* `key` — The key to check.
@*return* `down` — True if the key is down, false if not.

```lua
instance:keyBind(keyToBind)
```
Bind a key or a table of keys to the instance.
@*param* `keys` (string or table) — The keys to bind.

```lua
instance:keyUnbind(keys)
```
Unbind a key or a table of keys in the instance.
@*param* `keys` (string or table) — The keys to unbind.

```lua
instance:updateInput()
```
Update the state of all bound keys.

```lua
instance:justPressed(key)
```
Return true if is the first frame the bound key is down.
@*param* `key` — The key to check.
@*return* `down` — True if the key is down, false if not.

```lua
instance:isDown(k)
```
Return true if a bound key is down.
@*param* `key` — The key to check.
@*return* `down` — True if the key is down, false if not.

```lua
simpleKey:justReleased(k)
```
Return true if is the first frame the bound key is released.
@*param* `key` — The key to check.
@*return* `down` — True if the key is released, false if not.

DEPENDENCIES
        Love2D

]]
--

local SimpleKey = {
	_LICENSE = "MIT License - Copyright (c) 2024",
	_URL = "https://github.com/nicolas-sabbatini/simpleKey",
	_VERSION = "v3.0.0",
}
SimpleKey.__index = SimpleKey

-- Create a new instance of simpleKey.
-- @*param* `keys` (string or table) — The keys to bind.
-- @*return* `instance` — The new instance of simpleKey.
function SimpleKey.createInstance(keys)
	local instance = setmetatable({
		keysPressed = {},
		keysJustPressed = {},
		keysJustReleased = {},
	}, SimpleKey)
	instance:keyBind(keys)
	return instance
end

-- Check if a key is dawn, this key don't need to be bound.
-- This function is a wrapper for *love.keyboard.isDown(key)*.
-- @*param* `key` — The key to check.
-- @*return* `down` — True if the key is down, false if not.
function SimpleKey:checkDown(key)
	return love.keyboard.isDown(key)
end

-- Bind a key or a table of keys to the instance.
-- @*param* `keys` (string or table) — The keys to bind.
function SimpleKey:keyBind(keyToBind)
	if not keyToBind then
		return
	elseif type(keyToBind) == "table" then
		for _, k in pairs(keyToBind) do
			self.keysPressed[k] = false
			self.keysJustReleased[k] = false
			self.keysJustPressed[k] = false
		end
	else
		self.keysPressed[keyToBind] = false
		self.keysJustReleased[keyToBind] = false
		self.keysJustPressed[keyToBind] = false
	end
end

-- Unbind a key or a table of keys in the instance.
-- @*param* `keys` (string or table) — The keys to unbind.
function SimpleKey:keyUnbind(keys)
	if not keys then
		return
	elseif type(keys) == "table" then
		for _, k in pairs(keys) do
			self.keysPressed[k] = nil
			self.keysJustReleased[k] = nil
			self.keysJustPressed[k] = nil
		end
	else
		self.keysPressed[keys] = nil
		self.keysJustReleased[keys] = nil
		self.keysJustPressed[keys] = nil
	end
end

-- Update the state of all bound keys.
function SimpleKey:updateInput()
	for k, previus in pairs(self.keysPressed) do
		self.keysPressed[k] = love.keyboard.isDown(k)
		self.keysJustReleased[k] = previus and not self.keysPressed[k]
		self.keysJustPressed[k] = (not previus) and self.keysPressed[k]
	end
end

-- Return true if is the first frame the bound key is down.
-- @*param* `key` — The key to check.
-- @*return* `down` — True if the key is down, false if not.
function SimpleKey:justPressed(key)
	return self.keysJustPressed[key]
end

-- Return true if a bound key is down.
-- @*param* `key` — The key to check.
-- @*return* `down` — True if the key is down, false if not.
function SimpleKey:isDown(key)
	return self.keysPressed[key]
end

-- Return true if is the first frame the bound key is released.
-- @*param* `key` — The key to check.
-- @*return* `down` — True if the key is released, false if not.
function SimpleKey:justReleased(key)
	return self.keysJustReleased[key]
end

return SimpleKey

