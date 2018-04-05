-- game logic lives here

player = { x = 200, y = 710, speed = 150, img = nil }
function love.load() -- on startup
    player.img = love.graphics.newImage('assets/plane.png')
end

function love.update(deltaTime) -- on every frame 
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    timeByCPU = player.speed*deltaTime
    if love.keyboard.isDown('left', 'a') then
        if player.x > 0 then
            player.x = player.x - timeByCPU
        end
    elseif love.keyboard.isDown('right', 'd') then
        if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
            player.x = player.x + timeByCPU
        end
    end
end

function love.draw(deltaTime) -- on every frame
    love.graphics.draw(player.img, player.x, player.y)
end