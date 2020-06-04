_G.bulletsflyystem = class("bulletsflyystem", system);

function bulletsflyystem:getRequestComponents()
    return {'position','bulletsfly','speed'};
end

function bulletsflyystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local c_speed = iTargetEnt:getComponent("speed");
        local c_bulletsfly = iTargetEnt:getComponent("bulletsfly");
        local fireAngle = c_bulletsfly:getAttribute("fireAngle");
        local speed = c_speed:getAttribute("speed");
        c_position:addAttribute("x",c_position:getAttribute('x') - math.cos(fireAngle) * speed);
        c_position:addAttribute("y",c_position:getAttribute('y') - math.sin(fireAngle) * speed);
        c_bulletsfly:addAttribute("distance",c_bulletsfly:getAttribute("distance") - speed);
        local distance = c_bulletsfly:getAttribute("distance");
        if distance <= 0 then 
            baseworld:getInstance():removeEntity(iTargetEnt.id);
        end 
    end 
end