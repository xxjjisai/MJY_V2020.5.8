_G.playeropersystem = class("playeropersystem", system);

function playeropersystem:getRequestComponents()
    return {'position','playeropr'};
end

function playeropersystem:onEnterScene()
    self.nChangeMapType = 1;
    self.nBuildOrMap = 1;
end

function playeropersystem:onExitScene()
    self.nChangeMapType = nil;
    self.nBuildOrMap = nil;
end

function playeropersystem:playinmap(x,y,button)
    local tbMap = self:getSystem('mapsystem'):getCurMap();
    local mx,my = cameramgr:getInstance():GetMousePosition();
    local nMCol,nMRow = math.floor(mx/g_gameCfg.nBumpWorldCellSize) + 1,math.floor(my/g_gameCfg.nBumpWorldCellSize) + 1;
    if tbMap[nMRow] == nil then 
        return 
    end 
    if tbMap[nMRow][nMCol] == nil then 
        return;
    end 
    if tbMap[nMRow][nMCol] == -1 then 
        return;
    end 
    if tbMap[nMRow][nMCol] == 0 then 
        return;
    end 
    local tbExplorerMapInfo = self:getSystem('mapsystem').tbExplorerMapInfo;
    if button == 1 then 
        if self.nBuildOrMap == buildtypeconfig.nTileType then -- 设置地图类型
            if tbMap[nMRow][nMCol] ~= 1 then 
                return;
            end
            if tbExplorerMapInfo[nMRow][nMCol] ~= 2 then 
                return
            end 
            -- self:trace(1,table.show(self:getSystem('playersystem').tbMineralRound[self.nChangeMapType],"tbMineralRound[nMapType]"))
            -- local nCount = 0
            -- if self.nChangeMapType < 5 then 
            --     nCount = self:getSystem('playersystem').tbMineralRound[self.nChangeMapType + 1];
            --     if nCount - 3 < 0 then 
            --         return ;
            --     end
            --     self:getSystem('playersystem').tbMineralRound[self.nChangeMapType + 1] = self:getSystem('playersystem').tbMineralRound[self.nChangeMapType + 1] - 3;
            --     self:getSystem('playersystem'):ShowUI(self:getSystem('playersystem').tbMineralInfo[self.nChangeMapType + 1],self:getSystem('playersystem').tbMineralRound[self.nChangeMapType + 1],self.nChangeMapType + 1);
            -- end
            tbMap[nMRow][nMCol] = self.nChangeMapType;
            local nErrorCode = self:getSystem('buildsystem'):BuildTile(nMRow,nMCol,tbMap[nMRow][nMCol]);
            if nErrorCode == errorcode.error_code_11 then 
                -- self:trace(1,tbMap[nMRow][nMCol]);
            end
        elseif self.nBuildOrMap == buildtypeconfig.nCoreType then -- 建筑核芯
            self:getSystem('buildsystem'):BuildCore(nMRow,nMCol,tbMap[nMRow][nMCol]);
        elseif self.nBuildOrMap == buildtypeconfig.nArmyType then -- 建筑军队
            self:getSystem('buildsystem'):BuildArmy(nMRow,nMCol,tbMap[nMRow][nMCol]);
        elseif self.nBuildOrMap == buildtypeconfig.nXieZai then -- 卸载
            self:getSystem('buildsystem'):BuildUninstall(nMRow,nMCol,tbMap[nMRow][nMCol]);
        end
    end
end

function playeropersystem:playinexplorermap(x,y,button)
    local tbExplorerMapInfo = self:getSystem('mapsystem').tbExplorerMapInfo;
    local mx,my = cameramgr:getInstance():GetMousePosition();
    local nMCol,nMRow = math.floor(mx/g_gameCfg.nBumpWorldCellSize) + 1,math.floor(my/g_gameCfg.nBumpWorldCellSize) + 1;
    if tbExplorerMapInfo[nMRow] == nil then 
        return 
    end 
    if tbExplorerMapInfo[nMRow][nMCol] == nil then 
        return;
    end 
    if tbExplorerMapInfo[nMRow][nMCol] == -1 then 
        return;
    end 
    if tbExplorerMapInfo[nMRow][nMCol] == 0 then 
        return;
    end 
    if button == 1 then 
        tbExplorerMapInfo[nMRow][nMCol] = 2;
    end
end

function playeropersystem:mousepressed(x,y,button)
    if self:getSystem('mapsystem').bExplorerMap then 
        self:playinexplorermap(x,y,button);
    else 
        self:playinmap(x,y,button);
    end
end

function playeropersystem:SetChangeMapType(nChangeMapType)
    self.nChangeMapType = nChangeMapType;
end 

function playeropersystem:GetChangeMapType()
    return self.nChangeMapType
end

function playeropersystem:SetBuildOrMap(nBuildOrMap)
    self.nBuildOrMap = nBuildOrMap;
end 

function playeropersystem:GetBuildOrMap()
    return self.nBuildOrMap
end