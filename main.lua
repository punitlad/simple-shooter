-- game logic lives here

player = { x = 200, y = 710, speed = 150, img = nil }

-- set of timers
canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax

bulletImg = nil -- image storage
bullets = {} -- array of current bullets being drawn and updated

function love.load() -- on startup
    player.img = love.graphics.newImage('assets/plane.png')
    bulletImg = love.graphics.newImage('assets/bullet.png')
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

    canShootTimer = canShootTimer - (1 * deltaTime)
    if canShootTimer < 0 then
        canShoot = true
    end

    if love.keyboard.isDown('space', 'rctrl', 'lctrl') and canShoot then
        newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
        table.insert(bullets, newBullet)
        canShoot = false
        canShootTimer = canShootTimerMax
    end

    for i, bullet in ipairs(bullets) do
        bullet.y = bullet.y - (250 * deltaTime )
        if bullet.y < 0 then
            table.remove(bullets, i)
        end
    end
end

function love.draw(deltaTime) -- on every frame
    love.graphics.draw(player.img, player.x, player.y)
    for i, bullet in ipairs(bullets) do
        love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end
end