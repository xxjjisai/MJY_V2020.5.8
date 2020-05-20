_G.editorsystem = class("editorsystem", system);

function editorsystem:getRequestComponents()
    return {'editor'};
end

function editorsystem:mousepressed(x,y,button)
    local mx,my = cameramgr:getInstance():GetMousePosition();
    local nMCol = math.floor(mx/32);
    local nMRow = math.floor(my/32);
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local nECol = math.floor(c_position:getAttribute('x')/32);
        local nERow = math.floor(c_position:getAttribute('y')/32);
        if nMCol == nECol and nMRow == nERow then 
            iTargetEnt:getComponent("shaperender"):addAttribute("color", colorconfig.GRASS );
        end
    end 
end