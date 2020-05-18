_G.resetpositionsystem = class("resetpositionsystem", system);

function resetpositionsystem:getRequestComponents()
    return {'position','size','resetposition'};
end

function resetpositionsystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local x = c_position:getAttribute("x");
        local y = c_position:getAttribute("y");
        local c_size = iTargetEnt:getComponent("size");
        local w = c_size:getAttribute("w");
        local h = c_size:getAttribute("h");
        local c_resetposition = iTargetEnt:getComponent("resetposition");
        local resetDir = c_resetposition:getAttribute("resetDir");
        if resetDir == "v" then 
            if y > H + h then 
                c_position:addAttribute("x",math.random(0,W - 64));
                c_position:addAttribute("y",math.random(-64, -700));
            end 
        end
    end 
end