_G.moveshapesystem = class("moveshapesystem", system);

function moveshapesystem:getRequestComponents()
    return {'position','speed'};
end

function moveshapesystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local x = c_position:getAttribute("x");
        local y = c_position:getAttribute("y");
        local c_speed = iTargetEnt:getComponent("speed");
        local speed = c_speed:getAttribute("speed");
        c_position:addAttribute("x",x + speed * dt);
        c_position:addAttribute("y",y + speed * dt);
    end 
end