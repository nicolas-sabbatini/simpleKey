--[[
LUA MODULE
        Simple Key v$(_VERSION)

AUTHOR 
        Nicolas C. Sabbatini V.

LICENSE
        MIT License - Copyright (c) 2017

HOME PAGE
        https://github.com/NicolasSabba/simpleKey

DESCRIPTION
        Simple Key is a simple yet awesome input library for Love2d.
        The objective of this library is to make the keyboard input handle
        easy in a small and compact way.
        The library is aimed to be used in small proyects.
    
MOTIVATIONS
        There is a lot of input libraris for Love2d, but all of them are big
        and complex, and can be a litel over kill use a library that can handel 
        joystick and tuch scren for a small proyect, so i made this.

USAGE
        key = require('simpleKey')

        function love.load()
            key:keyInit({'space'})
        end

        function love.update(dt)
            key:updateInput()
            if key:isDown('space') then print('space dawn')
            if key:isReleased('space') then print('space jus got relised') end
        end

API
        TODO -- Descriptions --
        keyInit()
        keyBind()
        keyUnbind()
        updateInput()
        check()
        isDown()
        isReleased()

DEPENDENCIES
        Love2D

]]--

local simpleKey = {
    _LICENSE     = "MIT License - Copyright (c) 2017",
    _URL         = "https://github.com/NicolasSabba/simpleKey",
    _VERSION     = "0.01"
}

local key = {}

-- Key handeling Init
function simpleKey:keyInit(keys)
    keys = keys or {}
    key.keysPressed = {}
    key.keysReleased ={}
    simpleKey:keyBind(keys)
end

function simpleKey:check(key)
    return love.keyboard.isDown(key)
end

-- Bind keys
function simpleKey:keyBind(keys)
    if type(keys)=="table" then
        -- If the keys are a table add all of them to check
        for _, k in pairs(keys) do
            table.insert(key.keysPressed, k, false)
            table.insert(key.keysReleased, k, false)
        end
    else
        -- Else add the key intro the keys to check
        table.insert(key.keysPressed, keys, false)
        table.insert(key.keysReleased, keys, false)
    end
end

-- Unbind keys
function simpleKey:keyUnbind(keys)
    if type(keys)=="table" then
        -- If the keys are a table remove all of them
        for _, k in pairs(keys) do
            table.remove(key.keysPressed, keys)
            table.remove(key.keysReleased, keys)
        end
    else
        -- Else remove the key of the keys to check
        table.remove(key.keysPressed, keys, false)
        table.remove(key.keysReleased, keys, false)
    end
end

-- Update the keys values
function simpleKey:updateInput()
    for k, value in pairs(key.keysPressed) do
        local previus = value
        key.keysPressed[k] = simpleKey:check(k)
        key.keysReleased[k] = previus and (not key.keysPressed[k])
    end
end

-- Check if a key is dawn
function simpleKey:isDown(k)
    return key.keysPressed[k]
end

-- Check if a key just get released
function simpleKey:isReleased(k)
    return key.keysReleased[k]
end

return simpleKey