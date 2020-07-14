_G.drawshapesystem = class("drawshapesystem", system);

function drawshapesystem:getRequestComponents()
    return {'position','size','shaperender'};
end

function drawshapesystem:onDraw()
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        self:StepHandler(iTargetEnt)
    end 
end

function drawshapesystem:StepHandler(iTargetEnt)
    local c_position = iTargetEnt:getComponent("position");
    if not c_position then 
        return;
    end 
    local x = c_position:getAttribute("x");
    local y = c_position:getAttribute("y");
    local c_size = iTargetEnt:getComponent("size");
    if not c_size then 
        return;
    end 
    local w = c_size:getAttribute("w");
    local h = c_size:getAttribute("h");
    local c_shaperender = iTargetEnt:getComponent("shaperender");
    if not c_shaperender then 
        return;
    end 

    -- local nCol = math.floor(x / w) + 1;
    -- local nRow = math.floor(y / h) + 1;

    local color = c_shaperender:getAttribute("color");
    local shapeType = c_shaperender:getAttribute("shapeType");
    local fillType = c_shaperender:getAttribute("fillType");
    love.graphics.setColor(color);
    if shapeType == "rectangle" then
        love.graphics.rectangle(fillType,x,y,w,h);
        -- love.graphics.rectangle('fill',x,y,w,h);
        -- love.graphics.setColor(g_color.WHITE);
        -- love.graphics.rectangle('line',x,y,w,h);
        -- love.graphics.setFont(resmgr:getInstance():GetFont(12));
        -- love.graphics.print(string.format('%s,%s', nCol,nRow),x,y + 10)
        -- love.graphics.print(string.format('%s,%s', x,y),x,y + 28)
    end
    if shapeType == "circle" then
        love.graphics.circle(fillType,x ,y,w);
    end
end