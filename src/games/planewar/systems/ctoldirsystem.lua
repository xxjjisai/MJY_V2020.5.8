_G.ctoldirsystem = class("ctoldirsystem", system);

function ctoldirsystem:getRequestComponents()
    return {'ctoldir','direction'};
end

function ctoldirsystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_direction = iTargetEnt:getComponent("direction");
        local key_left = love.keyboard.isDown( 'a' );
        local key_right = love.keyboard.isDown( 'd' );
        local key_up = love.keyboard.isDown( 'w' );
        local key_down = love.keyboard.isDown( 's' );
        if key_left then 
            c_direction:addAttribute('x', -1)
        elseif key_right then 
            c_direction:addAttribute('x', 1)
        elseif key_up then 
            c_direction:addAttribute('y', -1)
        elseif key_down then 
            c_direction:addAttribute('y', 1)
        else
            c_direction:addAttribute('x', 0)
            c_direction:addAttribute('y', 0)
        end

    end 
end