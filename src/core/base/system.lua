_G.system = class('system',baseclass)

function system:init(tbComponent)
    self.tbMethodList = self.tbMethodList or {};
    self.tbComponent = tbComponent or {};
    self.targets = nil;
    self.tbListenerList = {};
    self.id = baseorigin:getInstance():getID();
    baseworld:getInstance():registerSystem(self);
end

function system:getTargets()
    return self.targets;
end

function system:update(dt)
    self:filterTargetHandler();
    if not self.bStartUpUpdate then 
        return
    end
    self:onUpdate(dt)
end

function system:filterTargetHandler()
    self.tbComponent = self:getRequestComponents();
    self.targets = baseworld:getInstance():getFilterTarget( self.tbComponent );
end

function system:draw()
    self:onDraw()
end

function system:enterScene()
    self:filterTargetHandler();
    self.bStartUpUpdate = false;
    self:onEnterScene();
end

function system:startup()
    self.bStartUpUpdate = true;
end

function system:exitScene()
    self:destory();
    self.bStartUpUpdate = nil;
    self:onExitScene();
end

function system:addMethod(sFunc,pfn)
    self.tbMethodList[sFunc] = pfn;
end

function system:doMethod(sFunc,...)
    self.tbMethodList[sFunc](...);
end

function system:destory()
    self.tbMethodList = nil;
    self.tbComponent = nil;
    self.targets = nil;
    self.tbListenerList = nil;
end

--------------------------------------

function system:getRequestComponents()

end

function system:onEnterScene()

end

function system:onExitScene()

end

function system:mousepressed(x,y,button)

end

function system:keypressed(key)

end

function system:onDraw()
    -- for i,iTargetEnt in ipairs(self:getTargets()) do 
    --     -- todo ...
    -- end
end

function system:onUpdate(dt)
    -- for i,iTargetEnt in ipairs(self:getTargets()) do 
    --     -- todo ...
    -- end
end

function system:getSystem(sClassName)
    return baseworld:getInstance():getSystem(sClassName);
end

function system:getEntity(eid)
    return baseworld:getInstance():getEntity(eid)
end

function system:addEvent(sSysName)
    baseevent:getInstance():addEvent(baseworld:getInstance():getSystem(sSysName),self);
end

function system:removeEvent(sSysName)
    baseevent:getInstance():removeEvent(self,baseworld:getInstance():getSystem(sSysName));
end

function system:doEvent(sFunc,...)
    baseevent:getInstance():doEvent(self,sFunc,...);
end