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

function playeropersystem:mousepressed(x,y,button)
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
    if button == 1 then 
        if self.nBuildOrMap == 1 then -- 设置地图类型
            if tbMap[nMRow][nMCol] ~= 1 then 
                return;
            end 
            tbMap[nMRow][nMCol] = self.nChangeMapType;
            local nErrorCode = self:getSystem('buildsystem'):BuildTile(nMRow,nMCol,tbMap[nMRow][nMCol]);
            if nErrorCode == errorcode.error_code_11 then 
                -- self:trace(1,tbMap[nMRow][nMCol]);
            end
        elseif self.nBuildOrMap == 2 then -- 建筑核芯
            self:getSystem('buildsystem'):BuildCore(nMRow,nMCol,tbMap[nMRow][nMCol]);
        end
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