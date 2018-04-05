-- game logic lives here

player = { x = 200, y = 710, speed = 150, img = nil }
function love.load() -- on startup
    player.img = love.graphics.newImage('assets/plane.png')
end

function love.update(deltaTime) -- on every frame 
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    movement = player.speed*deltaTime
    if love.keyboard.isDown('left', 'a') then
        player.x = player.x - movement
    elseif love.keyboard.isDown('right', 'd') then
        player.x = player.x + movement
    end
end

function love.draw(deltaTime) -- on every frame
    love.graphics.draw(player.img, player.x, player.y)
end