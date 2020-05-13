_G.manager = class('manager',baseclass)

function manager:init()
    self.id = baseorigin:getInstance():getID();
    self.tbListenerList = {};
end

function manager:getInstance()
    if self.instance == nil then 
        self.instance = self:new();
    end
    return self.instance;
end