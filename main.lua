key = require('simpleKey')

function love.load()

    key:keyInit({'up','down','left','right','space'})
    front = love.graphics.newFont(50)
    love.graphics.setFont(front)
    time = 1
    color = {{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0}}

end

function colorF(k)

    if key:isDown(k) == nil then return {0,0,0}
    elseif key:isDown(k) then return {0,255,0}
    elseif key:isReleased(k) then return {0,0,255}
    else return {255,0,0} end

end


function love.update(dt)

    key:updateInput()

    time = time - dt

    if time < 0 then
        if key:isDown('space') ~= nil then
            key:keyUnbind('space')
        else 
            key:keyBind('space')
        end   
        time = 1
    end     

    color[1] = colorF('up')
    color[2] = colorF('down')
    color[3] = colorF('left')
    color[4] = colorF('right')
    color[5] = colorF('space')

    print(love.keyboard.isDown('up'), key:isDown('up'), 'up')
    print(love.keyboard.isDown('down'), key:isDown('down'), 'down')
    print(love.keyboard.isDown('left'), key:isDown('left'), 'left')
    print(love.keyboard.isDown('right'), key:isDown('right'), 'right')
    print(love.keyboard.isDown('space'), key:isDown('space'), 'space')
    

end

function love.draw()
    love.graphics.setColor(color[1])
    love.graphics.print('up',100,50)
    love.graphics.setColor(color[2])
    love.graphics.print('down',100,100)
    love.graphics.setColor(color[3])
    love.graphics.print('left',100,150)
    love.graphics.setColor(color[4])
    love.graphics.print('right',100,200)
    love.graphics.setColor(color[5])
    love.graphics.print('Space', 100, 250)
end