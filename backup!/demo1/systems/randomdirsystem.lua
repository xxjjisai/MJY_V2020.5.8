_G.randomdirsystem = class("randomdirsystem", system);

function randomdirsystem:getRequestComponents()
    return {'position','direction','randomtime'};
end

function randomdirsystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        self:StepHandler(iTargetEnt);
    end
end

function randomdirsystem:StepHandler(iTargetEnt)
    local c_randomtime = iTargetEnt:getComponent("randomtime");
    local nProgNum = c_randomtime:getAttribute('nProgNum');
    local nJianGe = c_randomtime:getAttribute('nJianGe');
    nProgNum = nProgNum + 1
    c_randomtime:addAttribute('nProgNum',nProgNum + 1);
    if nProgNum%nJianGe ~= 0 then
        c_randomtime:addAttribute('nJianGe',math.random(50,100));
        return;
    end
    local c_direction = iTargetEnt:getComponent("direction");
    local tbRendomDir = {
        [1] = { x = 1,  y = -1 },
        [2] = { x = -1, y = 1  },
        [3] = { x = -1, y = -1 },
        [4] = { x = 1,  y = 1  },
        [5] = { x = 1,  y = 0  },
        [6] = { x = -1, y = 0  },
        [7] = { x = 0,  y = 1  },
        [8] = { x = 0,  y = -1 },
        [9] = { x = 0,  y = 0 },
    }
    local randomIdx = math.random(1,#tbRendomDir);
    local c_position = iTargetEnt:getComponent("position");
    local px = c_position:getAttribute('x');
    local py = c_position:getAttribute('y');
    if px <= 0+32 then 
        randomIdx = 5;
    end
    if px >= W - 32 then 
        randomIdx = 6;
    end
    if py <= 0+32 then 
        randomIdx = 7;
    end
    if py >= H - 32 then 
        randomIdx = 8;
    end
    c_direction:addAttribute("x", tbRendomDir[randomIdx].x );
    c_direction:addAttribute("y", tbRendomDir[randomIdx].y );
    local dirx = c_direction:getAttribute('x');
    local diry = c_direction:getAttribute('y');
    local nStartFrame,nEndFrame = 1,1;
    if dirx == 1 and diry == 1 then 
        nStartFrame,nEndFrame = 9,12; -- r
    elseif dirx == -1 and diry == -1 then  
        nStartFrame,nEndFrame = 5,8; -- l
    elseif dirx == 1 and diry == -1 then  
        nStartFrame,nEndFrame = 9,12; -- r
    elseif dirx == -1 and diry == 1 then  
        nStartFrame,nEndFrame = 5,8; -- l
    elseif dirx == 0 and diry == 1 then  
        nStartFrame,nEndFrame = 1,4; -- d
    elseif dirx == 1 and diry == 0 then  
        nStartFrame,nEndFrame = 9,12; -- r
    elseif dirx == 0 and diry == -1 then  
        nStartFrame,nEndFrame = 13,16; -- u
    elseif dirx == -1 and diry == 0 then  
        nStartFrame,nEndFrame = 5,8; -- l
    end
    self:getSystem("animationsystem"):Play(iTargetEnt,nStartFrame,nEndFrame)
end