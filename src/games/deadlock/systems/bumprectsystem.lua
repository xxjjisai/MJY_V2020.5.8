_G.bumprectsystem = class("bumprectsystem", system);

function bumprectsystem:getRequestComponents()
    return {'position','size','bumprect'};
end

function bumprectsystem:onEnterScene()
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local c_size = iTargetEnt:getComponent("size");
        BumpWorld:add(iTargetEnt,   c_position:getAttribute("x"),
                                c_position:getAttribute("y"),
                                c_size:getAttribute("w"),
                                c_size:getAttribute("h")) 
    end
end

function bumprectsystem:remove(iEnt)
    if BumpWorld:hasItem(iEnt) then 
        BumpWorld:remove(iEnt)
    end
end

function bumprectsystem:destory()
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        self:remove(iTargetEnt);
    end
end

function bumprectsystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_position = iTargetEnt:getComponent("position");
        local actualX, actualY, _, _ = BumpWorld:move(iTargetEnt, c_position:getAttribute("x"),c_position:getAttribute("y"))
        c_position:addAttribute("x",actualX);
        c_position:addAttribute("y",actualY);
    end
end