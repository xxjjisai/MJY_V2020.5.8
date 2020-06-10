_G.moveshapesystem = class("moveshapesystem", system);

function moveshapesystem:getRequestComponents()
    return {'position','speed','direction','moveshape'};
end

function moveshapesystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local x = c_position:getAttribute("x");
        local y = c_position:getAttribute("y");
        local c_speed = iTargetEnt:getComponent("speed");
        local speed = c_speed:getAttribute("speed");
        local c_direction = iTargetEnt:getComponent("direction");
        local dirx = c_direction:getAttribute('x');
        local diry = c_direction:getAttribute('y');
        c_position:addAttribute("x",x + dirx * (speed * dt));
        c_position:addAttribute("y",y + diry * (speed * dt));
    end 
end