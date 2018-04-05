-- game logic lives here

player = { x = 200, y = 710, speed = 150, img = nil }
function love.load() -- on startup
    player.img = love.graphics.newImage('assets/plane.png')
end

function love.update(deltaTime) -- on every frame 

end

function love.draw(deltaTime) -- on every frame
    love.graphics.draw(player.img, player.x, player.y)
end