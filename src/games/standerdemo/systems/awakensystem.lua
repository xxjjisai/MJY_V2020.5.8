_G.awakensystem = class("awakensystem", system);

function awakensystem:getRequestComponents()
    return {'position','size','awaken'};
end

function awakensystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        self:StepHandler(iTargetEnt);
    end 
end

function awakensystem:StepHandler(iTargetEnt)
    local c_position = iTargetEnt:getComponent("position"); 
    local c_size = iTargetEnt:getComponent("size"); 
    local c_awaken = iTargetEnt:getComponent("awaken");
    if c_position and c_size and c_awaken then 
        local nRange = c_awaken:getAttribute("nRange");
        local tbTargetTypes = c_awaken:getAttribute("tbTargetTypes");
        local bOffset = c_awaken:getAttribute("bOffset");
        local bClosed = false;
        local tbCollisionList = {};
        for _,sTargetType in ipairs(tbTargetTypes) do 
            local tbEntList = baseworld:getInstance():getEntityByType(sTargetType);
            for _,iEnt in ipairs(tbEntList) do 
                local c_position_iEnt = iEnt:getComponent("position"); 
                local c_size_iEnt = iEnt:getComponent("size"); 
                if c_position_iEnt and c_size_iEnt then 
                    local iEnt_x = c_position_iEnt:getAttribute("x");
                    local iEnt_y = c_position_iEnt:getAttribute("y");
                    local x = c_position:getAttribute("x");
                    local y = c_position:getAttribute("y");
                    local iEnt_w = c_size_iEnt:getAttribute("w");
                    local iEnt_h = c_size_iEnt:getAttribute("h");
                    local w = c_size:getAttribute("w");
                    local h = c_size:getAttribute("h");
                    local distance = 0;
                    if bOffset then 
                        distance = Dist(iEnt_x + w/2,iEnt_y + h/2,x,y);
                    else 
                        distance = Dist(iEnt_x + w/2,iEnt_y + h/2,x + w/2,y + h/2);
                    end
                    if distance <= nRange then 
                        table.insert(tbCollisionList,{sType = iEnt.sType,id = iEnt.id})
                        bClosed = true
                    end
                end
            end
        end 
        if bClosed then 
            baseevent:getInstance():doEvent(self,'EvtCollisionHandler',iTargetEnt.id,iTargetEnt.sType,tbCollisionList)
            c_awaken:addAttribute("bAwaken",true);
        else 
            c_awaken:addAttribute("bAwaken",false);
        end
    end
end

if g_option.DEBUG >=2 then 
    function awakensystem:onDraw()
        for i,iTargetEnt in ipairs(self:getTargets()) do 
            local c_position = iTargetEnt:getComponent("position");
            local c_size = iTargetEnt:getComponent("size");
            local c_awaken = iTargetEnt:getComponent("awaken");
            if c_position and c_size and c_awaken then 
                local x = c_position:getAttribute("x");
                local y = c_position:getAttribute("y");
                local w = c_size:getAttribute("w");
                local h = c_size:getAttribute("h");
                local nRange = c_awaken:getAttribute("nRange");
                local bAwaken = c_awaken:getAttribute("bAwaken");
                local bOffset = c_awaken:getAttribute("bOffset");
                love.graphics.setColor({0.5,1,0.5,1});
                if bOffset then 
                    love.graphics.circle("line",x ,y,nRange);
                else 
                    love.graphics.circle("line",x + w/2 ,y + h/2,nRange);
                end
                if bAwaken then 
                    love.graphics.setColor(g_color.WARN_AWAKEN);
                else 
                    love.graphics.setColor(g_color.NORMAL_AWAKEN);
                end
                if bOffset then 
                    love.graphics.circle("fill",x  ,y ,nRange);
                else 
                    love.graphics.circle("fill",x + w/2 ,y + h/2,nRange);
                end
            end
        end 
    end
end