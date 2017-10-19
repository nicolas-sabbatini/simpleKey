local simpleKey = {}

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
        -- If the keys are a table replace the previus keys
        key.keysPressed = {}
        for _, k in pairs(keys) do
            key.keysPressed[k] = false
            key.keysReleased[k] = false
        end
    else
        -- Else add the key intro the keys to check
        table.insert(key.keysPressed, keys, false)
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

function simpleKey:isDown(k)
    return key.keysPressed[k]
end

function simpleKey:isReleased(k)
    return key.keysReleased[k]
end

return simpleKey