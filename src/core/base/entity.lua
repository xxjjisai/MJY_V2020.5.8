_G.entity = class('entity',baseclass)

function entity:init(tbComponent)
    self.id = baseorigin:getInstance():getID();
    self.tbComponent = self.tbComponent or {};
    local tbComponent = tbComponent or {};
    for i,iCompo in ipairs(tbComponent) do
        local sCompoName = iCompo.class.name;
        self.tbComponent[sCompoName] = iCompo;
    end
    baseworld:getInstance():addEntity(self);
    self:create();
end

function entity:create()

end

function entity:addComponent(iCompo)
    local sCompoName = iCompo.class.name;
    self.tbComponent[sCompoName] = iCompo;
end

function entity:getComponent(sCompoName)
    if self.tbComponent == nil then 
        return nil;
    end 
    return self.tbComponent[sCompoName];
end

function entity:removeComponent(sCompoName)
    self.tbComponent[sCompoName] = nil;
end

function entity:destory()
    self.tbComponent = nil;
end

function entity:tweenData(sCompoName)
    local iCompo = self.tbComponent[sCompoName];
    return iCompo.tbData;
end