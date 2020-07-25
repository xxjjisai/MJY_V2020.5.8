_G.buildsystem = class("buildsystem", system);

function buildsystem:getRequestComponents()
    return {};
end

function buildsystem:onEnterScene()
    self.tbCoreList = {};
    self.tbTileList = {};
    self.tbMineralTypeList = {};
    self.tbMapBuildList = {};
    self.tbArmyList = {};
end

function buildsystem:onExitScene()
    self.tbCoreList = nil;
    self.tbTileList = nil;
    self.tbMineralTypeList = nil;
    self.tbMapBuildList = nil;
    self.tbArmyList = nil;
end

function buildsystem:getCoreList()
    return self.tbCoreList;
end

function buildsystem:getTileList()
    return self.tbTileList;
end

function buildsystem:getMineralList()
    return self.tbMineralTypeList;
end

function buildsystem:SetMapBuild(nCol,nRow,bIn)
    self.tbMapBuildList = self.tbMapBuildList or {};
    self.tbMapBuildList[nCol] = self.tbMapBuildList[nCol] or {};
    self.tbMapBuildList[nCol][nRow] = bIn;
end

function buildsystem:CheckInTile(nCol,nRow)
    self.tbMapBuildList = self.tbMapBuildList or {};
    self.tbMapBuildList[nCol] = self.tbMapBuildList[nCol] or {};
    self.tbMapBuildList[nCol][nRow] = self.tbMapBuildList[nCol][nRow] or false;
    return self.tbMapBuildList[nCol][nRow];
end 

function buildsystem:BuildMineral(nMRow,nMCol,nMapType)
    if nMapType == 1 or nMapType == 0 then 
        return errorcode.error_code_10 
    end;
    self.tbMineralTypeList = self.tbMineralTypeList or {};
    self.tbMineralTypeList[nMapType] = self.tbMineralTypeList[nMapType] or {};
    local iExist = nil;
    for i,v in ipairs(self.tbMineralTypeList[nMapType]) do 
        if v.nMRow == nMRow and v.nMCol == nMCol then 
            iExist = v; 
        end
    end 
    if iExist ~= nil then return errorcode.error_code_11 end;
    if not self:getSystem("buildsystem"):CheckInTile(nMCol,nMRow) then 
        self:getSystem("buildsystem"):SetMapBuild(nMCol,nMRow,true);
    else 
        return errorcode.error_code_11;
    end 
    local tbMap = self:getSystem('mapsystem'):getCurMap();
    if tbMap[nMRow][nMCol] == 1 then 
        return errorcode.error_code_10 
    end 
    local nSize = 10;
    local px = (nMCol-1) * g_gameCfg.nBumpWorldCellSize+ g_gameCfg.nBumpWorldCellSize/2;
    local py = (nMRow-1) * g_gameCfg.nBumpWorldCellSize+ g_gameCfg.nBumpWorldCellSize/2;
    local c_pos = position:new({ x = px, y = py });
    local c_siz = size:new({ w = nSize, h = nSize });
    local c_sortorder = sortorder:new({nLayerIndex = g_tbLayer.SKY});
    local c_shaperender = shaperender:new({ 
        color = mineralcolorconfig[100 + nMapType],
        nSideCount = 3;
        drawType="shape",
        shapeType = "circle", 
        fillType = "fill"
    });
    local c_core = actor:new({c_pos,c_siz,c_shaperender,c_sortorder});
    self.tbMineralTypeList = self.tbMineralTypeList or {};
    self.tbMineralTypeList[nMapType] = self.tbMineralTypeList[nMapType] or {};
    table.insert(self.tbMineralTypeList[nMapType],{ 
        nMapType = nMapType, 
        coreID = c_core.id;
        nMRow = nMRow;
        nMCol = nMCol;
    });
    return errorcode.error_code_0
end

function buildsystem:BuildTile(nMRow,nMCol,nMapType)
    if nMapType == 0 then return errorcode.error_code_10 end;
    self.tbTileList = self.tbTileList or {};
    local iExist = nil;
    for i,v in ipairs(self.tbTileList) do 
        if v.nMRow == nMRow and v.nMCol == nMCol then 
            iExist = v; 
        end
    end 
    if iExist ~= nil then 
        if nMapType == 1 then 
            baseworld:getInstance():removeEntity(iExist.coreID);
        end 
        return errorcode.error_code_11 
    end;
    if nMapType == 1 then 
        return errorcode.error_code_10
    end
    --todo...随机一个事件，如物品或者怪物，如果随机出来怪物，需要根据当前实力生成数值
    --todo...根据事件来明确此地是否可以铺设
    local nSize = g_gameCfg.nBumpWorldCellSize;
    local px = (nMCol-1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2 - nSize/2;
    local py = (nMRow-1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2 - nSize/2;
    local c_pos = position:new({ x = px, y = py });
    local c_siz = size:new({ w = nSize, h = nSize });
    local c_tiletype = tiletype:new({
        nMapType = nMapType;
        nCreateTime = GetTime();
        nJianGe = math.random(10,20);
        nLastTime = GetTime();
        nHasMineral = false;
    });
    local c_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND});
    local c_shaperender = shaperender:new({ 
        color = g_color.ALPHA; --tilecolorconfig[100 + nMapType],
        drawType="shape",
        shapeType = "rectangle", 
        fillType = "fill"});
    local c_core = actor:new({c_pos,c_siz,c_shaperender,c_sortorder,c_tiletype});
    table.insert(self.tbTileList,{ 
        -- iEnt = c_core;
        nMapType = nMapType, 
        coreID = c_core.id;
        nMRow = nMRow;
        nMCol = nMCol;
    });
    return errorcode.error_code_0
end

function buildsystem:BuildCore(nMRow,nMCol,nMapType)
    if nMapType == 1 or nMapType == 0 then return errorcode.error_code_10 end;
    self.tbCoreList = self.tbCoreList or {};
    local iExist = nil;
    for i,v in ipairs(self.tbCoreList) do 
        if v.nMRow == nMRow and v.nMCol == nMCol then 
            iExist = v; 
        end
    end 
    if iExist ~= nil then return errorcode.error_code_11 end;
    if not self:getSystem("buildsystem"):CheckInTile(nMCol,nMRow) then 
        self:getSystem("buildsystem"):SetMapBuild(nMCol,nMRow,true);
    else 
        -- self:trace(1,string.format('end create nMCol:%s,nMRow:%s', nMCol,nMRow));
        return errorcode.error_code_11;
    end 
    local nSize = 13;
    -- 核芯堆
    local px = (nMCol-1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2 - nSize/2;
    local py = (nMRow-1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2 - nSize/2;
    local c_pos = position:new({ x = px, y = py });
    local c_siz = size:new({ w = nSize, h = nSize });
    local c_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN_DOWN});
    local c_shaperender = shaperender:new({ 
        color = corecolorconfig[100 + nMapType],
        drawType="shape",
        shapeType = "rectangle", 
        fillType = "fill"
    });
    local c_core = actor:new({c_pos,c_siz,c_shaperender,c_sortorder});
    -- 收集者
    local px = (nMCol-1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2;
    local py = (nMRow-1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2;
    local c_pos = position:new({ x = px, y = py });
    local c_siz = size:new({ w = 10, h = 10 });
    local c_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN});
    local c_actormove = actormove:new({
        nMoveTime = math.random(0.1,0.4);
    });
    local c_collect = collect:new({
        nWalkAbled = nMapType,
    });
    local c_shaperender = shaperender:new({ 
        color = {1,1,1,1},
        nSideCount = 100;
        drawType="shape",
        shapeType = "circle", 
        fillType = "line"
    });
    local c_collect = actor:new({c_pos,c_siz,c_shaperender,c_collect,c_actormove,c_sortorder});
    table.insert(self.tbCoreList,{ 
        -- iEnt = c_core;
        nMapType = nMapType, 
        coreID = c_core.id;
        nCollectID = c_collect.id;
        nMRow = nMRow;
        nMCol = nMCol;
    });
    return errorcode.error_code_0
end

function buildsystem:BuildArmy(nMRow,nMCol,nMapType)
    self:trace(1,'======================== 111 ')
    if nMapType == 1 or nMapType == 0 then return errorcode.error_code_10 end;
    self.tbArmyList = self.tbArmyList or {};
    local iExist = nil;
    for i,v in ipairs(self.tbArmyList) do 
        if v.nMRow == nMRow and v.nMCol == nMCol then 
            iExist = v; 
        end
    end 
    self:trace(1,'======================== 222 ')
    if iExist ~= nil then return errorcode.error_code_11 end;
    self:trace(1,'======================== 333 ')
    if not self:getSystem("buildsystem"):CheckInTile(nMCol,nMRow) then 
        self:getSystem("buildsystem"):SetMapBuild(nMCol,nMRow,true);
    else 
        self:trace(1,'======================== 444 ')
        return errorcode.error_code_11;
    end
    self:trace(1,'======================== 555 ')
    local nSize = 13;
    local px = (nMCol-1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2 - nSize/2;
    local py = (nMRow-1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2 - nSize/2;
    local c_pos = position:new({ x = px, y = py });
    local c_siz = size:new({ w = nSize, h = nSize });
    local c_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN_DOWN});
    local c_shaperender = shaperender:new({ 
        color = {23/255,8/255,69/255,1},
        drawType="shape",
        shapeType = "rectangle", 
        fillType = "fill",
    });
    local c_army = actor:new({c_pos,c_siz,c_shaperender,c_sortorder});
    table.insert(self.tbArmyList,{ 
        -- iEnt = c_core;
        nMapType = nMapType, 
        coreID = c_army.id;
        nMRow = nMRow;
        nMCol = nMCol;
    });
end

function buildsystem:BuildUninstall(nMRow,nMCol,nMapType)
    local tbMap = self:getSystem('mapsystem'):getCurMap();
    -- minal------------------------------------------------------------------------
    local iExist = nil;
    local idx = nil;
    self:getSystem('buildsystem').tbMineralTypeList[nMapType] = self:getSystem('buildsystem').tbMineralTypeList[nMapType] or {};
    for i,v in ipairs(self:getSystem('buildsystem').tbMineralTypeList[nMapType]) do 
        if v.nMRow == nMRow and v.nMCol == nMCol then 
            iExist = v; 
            idx = i;
        end
    end 
    if iExist ~= nil then 
        self:getSystem('tilesystem'):ReClearTile(iExist.coreID);
        baseworld:getInstance():removeEntity(iExist.coreID);
        self:getSystem("buildsystem"):SetMapBuild(nMCol,nMRow,false);
        table.remove(self:getSystem('buildsystem').tbMineralTypeList[nMapType],idx);
        iExist = nil;
        return
    end;
    -- army-------------------------------------------------------------------------
    local iExist = nil;
    local idx = nil;
    for i,v in ipairs(self:getSystem('buildsystem').tbArmyList) do 
        if v.nMRow == nMRow and v.nMCol == nMCol then 
            iExist = v; 
            idx = i;
        end
    end 
    if iExist ~= nil then 
        baseworld:getInstance():removeEntity(iExist.coreID);
        self:getSystem("buildsystem"):SetMapBuild(nMCol,nMRow,false);
        table.remove(self:getSystem('buildsystem').tbArmyList,idx);
        iExist = nil;
        return
    end;
    -- core------------------------------------------------------------------------
    local iExist = nil;
    local idx = nil;
    for i,v in ipairs(self:getSystem('buildsystem').tbCoreList) do 
        if v.nMRow == nMRow and v.nMCol == nMCol then 
            iExist = v; 
            idx = i;
        end
    end 
    if iExist ~= nil then 
        local tbColloer = baseworld:getInstance():getEntity(iExist.nCollectID);
        local tbMineralList = self:getSystem("buildsystem"):getMineralList()[nMapType];
        table.insert(tbMineralList, tbColloer:getComponent("collect").tbData.tbTarget);
        tbColloer:getComponent("collect").tbData.bStartExe = false;
        tbColloer:getComponent("collect").tbData.tbTarget = nil;
        baseworld:getInstance():removeEntity(iExist.coreID);
        baseworld:getInstance():removeEntity(iExist.nCollectID);
        self:getSystem("buildsystem"):SetMapBuild(nMCol,nMRow,false);
        table.remove(self:getSystem('buildsystem').tbCoreList,idx);
        iExist = nil;
        return
    end;

    -- tile-----------------------------------------------------------------------
    local iExist = nil;
    local idx = nil;
    for i,v in ipairs(self:getSystem('buildsystem').tbTileList) do 
        if v.nMRow == nMRow and v.nMCol == nMCol then 
            iExist = v; 
            idx = i;
        end
    end
    if iExist ~= nil then 
        baseworld:getInstance():removeEntity(iExist.coreID);
        table.remove(self:getSystem('buildsystem').tbTileList,idx);
        iExist = nil;
    end;
    tbMap[nMRow][nMCol] = 1;
    return;
end