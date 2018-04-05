-- game logic lives here

playerImg = nil
function love.load() -- on startup
    playerImg = love.graphics.newImage('assets/plane.png')
end

function love.update(deltaTime) -- on every frame 

end

function love.draw(deltaTime) -- on every frame
    x = 100 -- from the top left
    y = 100 -- from the top left
    love.graphics.draw(playerImg, x, y)
end