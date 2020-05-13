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

function system:onDraw()

end

function system:onUpdate(dt)

end