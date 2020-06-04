_G.awakensystem = class("awakensystem", system);

function awakensystem:getRequestComponents()
    return {'position','size','awaken'};
end

function awakensystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position"); 
        local c_size = iTargetEnt:getComponent("size"); 
        local c_awaken = iTargetEnt:getComponent("awaken");
        local nRange = c_awaken:getAttribute("nRange");
        local tbTargetTypes = c_awaken:getAttribute("tbTargetTypes");
        local bClosed = false;
        for _,sTargetType in ipairs(tbTargetTypes) do 
            local tbEntList = baseworld:getInstance():getEntityByType(sTargetType);
            for _,iEnt in ipairs(tbEntList) do 
                local c_position_iEnt = iEnt:getComponent("position"); 
                local c_size_iEnt = iEnt:getComponent("size"); 
                local iEnt_x = c_position_iEnt:getAttribute("x");
                local iEnt_y = c_position_iEnt:getAttribute("y");
                local x = c_position:getAttribute("x");
                local y = c_position:getAttribute("y");
                local iEnt_w = c_size_iEnt:getAttribute("w");
                local iEnt_h = c_size_iEnt:getAttribute("h");
                local w = c_size:getAttribute("w");
                local h = c_size:getAttribute("h");
                local distance = Dist(iEnt_x + w/2,iEnt_y + h/2,x + w/2,y + h/2);
                if distance <= nRange then 
                    bClosed = true
                end
            end
        end 
        if bClosed then 
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
            local x = c_position:getAttribute("x");
            local y = c_position:getAttribute("y");
            local w = c_size:getAttribute("w");
            local h = c_size:getAttribute("h");
            local nRange = c_awaken:getAttribute("nRange");
            local bAwaken = c_awaken:getAttribute("bAwaken");
            love.graphics.setColor({0.5,1,0.5,1});
            love.graphics.circle("line",x + w/2 ,y + h/2,nRange);
            if bAwaken then 
                love.graphics.setColor(g_color.WARN_AWAKEN);
            else 
                love.graphics.setColor(g_color.NORMAL_AWAKEN);
            end
            love.graphics.circle("fill",x + w/2 ,y + h/2,nRange);
        end 
    end
end