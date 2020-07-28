_G.playersystem = class("playersystem", system);

function playersystem:getRequestComponents()
    return {};
end

function playersystem:onEnterScene()
    self.tbMineralInfo = {};
    self.tbMineralRound = {};
    baseevent:getInstance():addEvent(self:getSystem('collectmineralsystem'),self);
end

function playersystem:onExitScene()
    self.tbMineralInfo = nil;
    self.tbMineralRound = nil;
    baseevent:getInstance():removeEvent(self,self:getSystem('collectmineralsystem'));
end

function playersystem:EvtCollectMineral(nMapType)
    self.tbMineralRound[nMapType] = self.tbMineralRound[nMapType] or 0;
    self.tbMineralInfo[nMapType] = self.tbMineralInfo[nMapType] or 0;
    self.tbMineralInfo[nMapType] = self.tbMineralInfo[nMapType] + 1;
    if self.tbMineralInfo[nMapType] >= mineraltotalconfig[100 + nMapType] then 
        self.tbMineralInfo[nMapType] = 0;
        self.tbMineralRound[nMapType] = self.tbMineralRound[nMapType] + 1;
    end 
    self:ShowUI(self.tbMineralInfo[nMapType],self.tbMineralRound[nMapType],nMapType);
    -- local btn_tmpui = uimgr:getInstance():getByName("btn_mapbuild"..nMapType);
    -- -- btn_tmpui:SetText(' x '..self.tbMineralInfo[nMapType]);
    -- btn_tmpui:SetText(self.tbMineralInfo[nMapType]);

    -- if self.tbMineralRound[nMapType] > 0 then 
    --     local ipt_tmpui = uimgr:getInstance():getByName("ipt_mapbuild"..nMapType);
    --     ipt_tmpui:SetText(' x '..self.tbMineralRound[nMapType]);
    -- end
end

function playersystem:ShowUI(a,b,nMapType)
    local btn_tmpui = uimgr:getInstance():getByName("btn_mapbuild"..nMapType);
    -- btn_tmpui:SetText(' x '..self.tbMineralInfo[nMapType]);
    btn_tmpui:SetText(a);

    if b > 0 then 
        local ipt_tmpui = uimgr:getInstance():getByName("ipt_mapbuild"..nMapType);
        ipt_tmpui:SetText(' x '..b);
    end
end
