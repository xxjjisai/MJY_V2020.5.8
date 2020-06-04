_G.drawshapesystem = class("drawshapesystem", system);

function drawshapesystem:getRequestComponents()
    return {'position','size','shaperender'};
end

function drawshapesystem:onDraw()
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local x = c_position:getAttribute("x");
        local y = c_position:getAttribute("y");
        local c_size = iTargetEnt:getComponent("size");
        local w = c_size:getAttribute("w");
        local h = c_size:getAttribute("h");
        local c_shaperender = iTargetEnt:getComponent("shaperender");
        local color = c_shaperender:getAttribute("color");
        local shapeType = c_shaperender:getAttribute("shapeType");
        local fillType = c_shaperender:getAttribute("fillType");
        love.graphics.setColor(color);
        if shapeType == "rectangle" then
            love.graphics.rectangle(fillType,x,y,w,h);
        end
        if shapeType == "circle" then
            love.graphics.circle(fillType,x ,y,w);
        end
    end 
end