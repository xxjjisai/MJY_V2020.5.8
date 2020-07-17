_G.buildsystem = class("buildsystem", system);

function buildsystem:getRequestComponents()
    return {};
end

function buildsystem:onEnterScene()
    self.tbCoreList = {};
    self.tbTileList = {};
    self.tbMineralTypeList = {};
end

function buildsystem:onExitScene()
    self.tbCoreList = nil;
    self.tbTileList = nil;
    self.tbMineralTypeList = nil;
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

function buildsystem:BuildMineral(nMRow,nMCol,nMapType)
    if nMapType == 1 or nMapType == 0 then return errorcode.error_code_10 end;
    self.tbMineralTypeList = self.tbMineralTypeList or {};
    self.tbMineralTypeList[nMapType] = self.tbMineralTypeList[nMapType] or {};
    local iExist = nil;
    for i,v in ipairs(self.tbMineralTypeList[nMapType]) do 
        if v.nMRow == nMRow and v.nMCol == nMCol then 
            iExist = v; 
        end
    end 
    if iExist ~= nil then return errorcode.error_code_11 end;
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
        nJianGe = 10;
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
        nMoveTime = 0.3;
    });
    local c_collect = collect:new({
        nWalkAbled = nMapType,
    });
    local c_shaperender = shaperender:new({ 
        color = {1,1,1,1},
        nSideCount = 5;
        drawType="shape",
        shapeType = "circle", 
        fillType = "line"
    });
    local c_collect = actor:new({c_pos,c_siz,c_shaperender,c_collect,c_actormove,c_sortorder});
    table.insert(self.tbCoreList,{ 
        -- iEnt = c_core;
        nMapType = nMapType, 
        coreID = c_core.id;
        nMRow = nMRow;
        nMCol = nMCol;
    });
    return errorcode.error_code_0
end