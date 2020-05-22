_G.wasdmovesystem = class("wasdmovesystem", system);

function wasdmovesystem:getRequestComponents()
    return {'position','direction','speed','wasdmove'};
end

function wasdmovesystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local c_direction = iTargetEnt:getComponent("direction");
        local c_speed = iTargetEnt:getComponent("speed");
        if love.keyboard.isDown("w","up") then 
            c_direction:addAttribute("y",-1);
        end
        if love.keyboard.isDown("a","left") then 
            c_direction:addAttribute("x",-1);
        end
        if love.keyboard.isDown("s","down") then 
            c_direction:addAttribute("y",1);
        end
        if love.keyboard.isDown("d","right") then 
            c_direction:addAttribute("x",1);
        end
        c_position:addAttribute("x",c_position:getAttribute("x") + (c_speed:getAttribute("speed") * dt) * c_direction:getAttribute("x"));
        c_position:addAttribute("y",c_position:getAttribute("y") + (c_speed:getAttribute("speed") * dt) * c_direction:getAttribute("y"));
        c_direction:addAttribute("x",0);
        c_direction:addAttribute("y",0);

        -- local dirx = c_direction:getAttribute('x');
        -- local diry = c_direction:getAttribute('y');
        -- local nStartFrame,nEndFrame = 1,1;
        -- if dirx == 1 and diry == 1 then 
        --     nStartFrame,nEndFrame = 9,12; -- r
        -- elseif dirx == -1 and diry == -1 then  
        --     nStartFrame,nEndFrame = 5,8; -- l
        -- elseif dirx == 1 and diry == -1 then  
        --     nStartFrame,nEndFrame = 9,12; -- r
        -- elseif dirx == -1 and diry == 1 then  
        --     nStartFrame,nEndFrame = 5,8; -- l
        -- elseif dirx == 0 and diry == 1 then  
        --     nStartFrame,nEndFrame = 1,4; -- d
        -- elseif dirx == 1 and diry == 0 then  
        --     nStartFrame,nEndFrame = 9,12; -- r
        -- elseif dirx == 0 and diry == -1 then  
        --     nStartFrame,nEndFrame = 13,16; -- u
        -- elseif dirx == -1 and diry == 0 then  
        --     nStartFrame,nEndFrame = 5,8; -- l
        -- end
        -- self:getSystem("animationsystem"):Play(iTargetEnt,nStartFrame,nEndFrame)

    end 
end