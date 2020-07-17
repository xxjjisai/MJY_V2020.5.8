_G.playersystem = class("playersystem", system);

function playersystem:getRequestComponents()
    return {};
end

function playersystem:onEnterScene()
    self.tbMineralInfo = {};
    baseevent:getInstance():addEvent(self:getSystem('collectmineralsystem'),self);
end

function playersystem:onExitScene()
    self.tbMineralInfo = nil;
    baseevent:getInstance():removeEvent(self,self:getSystem('collectmineralsystem'));
end

function playersystem:EvtCollectMineral(nMapType)
    self.tbMineralInfo[nMapType] = self.tbMineralInfo[nMapType] or 0;
    self.tbMineralInfo[nMapType] = self.tbMineralInfo[nMapType] + 1;
    local tmpui = uimgr:getInstance():getByName("ipt_mapbuild"..nMapType);
    tmpui:SetText(' x '..self.tbMineralInfo[nMapType]);
    -- self:trace(1,self.tbMineralInfo[nMapType]);
end
