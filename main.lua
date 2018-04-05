-- game logic lives here
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2) 
    return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

player = { x = 200, y = 710, speed = 150, img = nil }
isAlive = true
score = 0

-- shooting timer
canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax
bulletImg = nil -- image storage
bullets = {} -- array of current bullets being drawn and updated

-- enemie timer
createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax
enemyImg = nil
enemies = {}

function love.load() -- on startup
    player.img = love.graphics.newImage('assets/plane.png')
    bulletImg = love.graphics.newImage('assets/bullet.png')
    enemyImg = love.graphics.newImage('assets/enemy.png')
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

    createEnemyTimer = createEnemyTimer - (1 * deltaTime)
    if createEnemyTimer < 0 then
        createEnemyTimer = createEnemyTimerMax
        randomNumber = math.random(10, love.graphics.getWidth() - 10)
        newEnemy = { x = randomNumber, y = 10, img = enemyImg }
        table.insert(enemies, newEnemy)
    end

    for i, enemy in ipairs(enemies) do 
        enemy.y = enemy.y + (200 * deltaTime)
        if enemy.y > 850 then
            table.remove(enemies, i)
        end
    end

    for i, enemy in ipairs(enemies) do
        for j, bullet in ipairs(bullets) do
            if checkCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
                table.remove(bullets, j)
                table.remove(enemies, i)
                score = score + 1
            end
        end

        if checkCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) and isAlive then
            table.remove(enemies, i)
            isAlive = false
        end
    end

    if not isAlive and love.keyboard.isDown('r') then
        -- reset game
        bullets = {}
        enemies = {} 
        canShootTimer = canShootTimerMax
        createEnemyTimer = createEnemyTimerMax
        player.x = 50
        player.y = 710
        score = 0
        isAlive = true
    end
end

function love.draw(deltaTime) -- on every frame
    if isAlive then
        love.graphics.draw(player.img, player.x, player.y)
    else
        love.graphics.print("Press R To Restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
    end
    for i, bullet in ipairs(bullets) do
        love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end
    for i, enemy in ipairs(enemies) do
        love.graphics.draw(enemy.img, enemy.x, enemy.y)
    end
end