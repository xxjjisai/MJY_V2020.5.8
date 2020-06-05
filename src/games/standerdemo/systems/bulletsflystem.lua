_G.bulletsflystem = class("bulletsflystem", system);

function bulletsflystem:getRequestComponents()
    return {'position','size','bulletsfly','speed'};
end

function bulletsflystem:onEnterScene()
    baseevent:getInstance():addEvent(baseworld:getInstance():getSystem('awakensystem'),self);
end 

function bulletsflystem:onExitScene()
    baseevent:getInstance():removeEvent(self,baseworld:getInstance():getSystem('awakensystem'));
end 

function bulletsflystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local c_size = iTargetEnt:getComponent("size");
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

function bulletsflystem:EvtCollisionHandler(nColliderID,sColliderType,tbCollisionList)
    if sColliderType == "bullet" then 
        local iBullet = baseworld:getInstance():getEntity(nColliderID);
        local c_awaken = iBullet:getComponent("awaken");
        local c_bulletsfly = iBullet:getComponent("bulletsfly");
        local tbTargetTypes = c_awaken:getAttribute("tbTargetTypes");
        CheckInTargets = function (tbTargetTypes,tTmpType)
            for _,sType in ipairs(tbTargetTypes) do 
                if sType == tTmpType then 
                    return true
                end 
            end     
            return false;
        end
        for i,v in ipairs(tbCollisionList) do 
            if CheckInTargets(tbTargetTypes,v.sType) then 
                local iEnt = baseworld:getInstance():getEntity(v.id);
                local c_attribute = iEnt:getComponent('attribute');
                if c_attribute then 
                    c_attribute:addAttribute('hp', c_attribute:getAttribute('hp') - 1);
                    if c_attribute:getAttribute('hp') <= 0 then 
                        baseworld:getInstance():removeEntity(v.id);
                        if v.sType == "hero" then 
                            scenemgr:getInstance():switchScene("overscene");
                        end
                        if v.sType == "item" then 
                            local nShootID = c_bulletsfly:getAttribute('shooterID');
                            local iShooter = baseworld:getInstance():getEntity(nShootID);
                            local c_attribute_shooter = iShooter:getComponent('attribute');
                            c_attribute_shooter:addAttribute('hp', c_attribute_shooter:getAttribute('hp') + 10);
                        end
                    end 
                end
            end
        end
        baseworld:getInstance():removeEntity(nColliderID);
    end
end 