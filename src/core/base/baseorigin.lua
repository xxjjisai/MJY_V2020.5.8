_G.baseorigin = class('baseorigin')

baseorigin.id = 0

function baseorigin:getID()
    self.id = self.id + 1;
    return self.id;
end

function baseorigin:getInstance()
    if self.instance == nil then 
        self.instance = self:new();
    end
    return self.instance;
end