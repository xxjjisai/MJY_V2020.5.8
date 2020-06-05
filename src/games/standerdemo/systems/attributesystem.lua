_G.attributesystem = class("attributesystem", system);

function attributesystem:getRequestComponents()
    return {'position','attribute'};
end

if g_option.DEBUG >=2 then 
    function attributesystem:onDraw()
        for i,iTargetEnt in ipairs(self:getTargets()) do 
            local c_position = iTargetEnt:getComponent("position");
            local c_attribute = iTargetEnt:getComponent("attribute");
            if c_position and c_attribute then 
                local hp = c_attribute:getAttribute('hp');
                love.graphics.setColor(1,1,1,0.3);
                love.graphics.rectangle("fill",c_position:getAttribute('x'),c_position:getAttribute('y')-6,32,5);
                love.graphics.setColor(1,0,0,1);
                love.graphics.rectangle("fill",c_position:getAttribute('x'),c_position:getAttribute('y')-6,hp,5);
            end 
        end 
    end
end