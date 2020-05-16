_G.planefiresystem = class("planefiresystem", system);

function planefiresystem:getRequestComponents()
    return {'position','size','planefire','randomtime'};
end

function planefiresystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        self:StepHandler(iTargetEnt);
    end 
end

function planefiresystem:StepHandler(iTargetEnt)
    local c_position = iTargetEnt:getComponent("position");
    local x = c_position:getAttribute("x");
    local y = c_position:getAttribute("y");
    local c_size = iTargetEnt:getComponent("size");
    local w = c_size:getAttribute("w");
    local h = c_size:getAttribute("h");
    local bDown = love.mouse.isDown( 1 );
    if bDown then 
        local c_randomtime = iTargetEnt:getComponent("randomtime");
        local nProgNum = c_randomtime:getAttribute('nProgNum');
        local nJianGe = c_randomtime:getAttribute('nJianGe');
        nProgNum = nProgNum + 1
        c_randomtime:addAttribute('nProgNum',nProgNum + 1);
        if nProgNum%nJianGe ~= 0 then
            -- c_randomtime:addAttribute('nJianGe',math.random(10,50));
            return;
        end
        local c_position_1 = position:new({ x = x + 128/2 - 32, y = y + 30 });
        local c_size_1 = size:new({ w = 9, h = 21 });
        local c_animaterender_1 = animaterender:new({ order = 1, color = g_color.WHITE, nStartFrame = 1, nEndFrame = 1, bStartPlay = true, sImg = "fire", nQuadW = 9, nQuadH = 21, nTotalFrame= 1, nLoop = 1, nTotalPlayCount = 0, nTimeAfterPlay = 0.15,});
        local c_direction_1 = direction:new({ x = 0, y = -1 });
        local c_speed_1 = speed:new({speed = 880 });
        local e_fire_left = fire:new({ c_position_1,c_size_1,c_animaterender_1,c_direction_1,c_speed_1});
        self:getSystem("animationsystem"):SetFrame(c_animaterender_1);
        if c_animaterender_1:getAttribute("bStartPlay") then 
            self:getSystem("animationsystem"):Play(e_fire_left,c_animaterender_1:getAttribute("nStartFrame"),c_animaterender_1:getAttribute("nEndFrame"));
        end
        
        local c_position_2 = position:new({ x = x + 128/2 + 30, y = y + 30 });
        local c_size_2 = size:new({ w = 9, h = 21 });
        local c_animaterender_2 = animaterender:new({ order = 1, color = g_color.WHITE, nStartFrame = 1, nEndFrame = 1, bStartPlay = true, sImg = "fire", nQuadW = 9, nQuadH = 21, nTotalFrame= 1, nLoop = 1, nTotalPlayCount = 0, nTimeAfterPlay = 0.15,});
        local c_direction_2 = direction:new({ x = 0, y = -1 });
        local c_speed_2 = speed:new({speed = 880 });
        local e_fire_left = fire:new({ c_position_2,c_size_2,c_animaterender_2,c_direction_2,c_speed_2});
        self:getSystem("animationsystem"):SetFrame(c_animaterender_2);
        if c_animaterender_2:getAttribute("bStartPlay") then 
            self:getSystem("animationsystem"):Play(e_fire_left,c_animaterender_2:getAttribute("nStartFrame"),c_animaterender_2:getAttribute("nEndFrame"));
        end
    end 
end