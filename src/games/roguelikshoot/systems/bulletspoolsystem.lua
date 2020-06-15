_G.bulletspoolsystem = class("bulletspoolsystem", system);

function bulletspoolsystem:getRequestComponents()
    return {};
end

function bulletspoolsystem:comeInPool(sTag,iEnt)
    self.tbPoolList = self.tbPoolList or {};
    self.tbPoolList[sTag] = self.tbPoolList[sTag] or {};
    table.insert(self.tbPoolList[sTag],iEnt);
end 

function bulletspoolsystem:comeOutPool(sTag)
    self.tbPoolList = self.tbPoolList or {};
    self.tbPoolList[sTag] = self.tbPoolList[sTag] or {};
    local iEnt = nil;
    if next(self.tbPoolList[sTag]) then 
        iEnt = self.tbPoolList[sTag][1];
        table.remove(self.tbPoolList[sTag], 1);
    end
    return iEnt;
end

function bulletspoolsystem:onExitScene()
    self.tbPoolList = nil;
end