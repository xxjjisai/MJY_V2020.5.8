_G.tilesystem = class("tilesystem", system);

function tilesystem:getRequestComponents()
    return {'tiletype'};
end

function tilesystem:onEnterScene()

end

function tilesystem:onExitScene()

end

function tilesystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        self:CreateMineral(iTargetEnt);
    end
end

function tilesystem:CreateMineral(iTargetEnt)
    if iTargetEnt:getComponent("tiletype"):getAttribute("nHasMineral") then return end;
    if GetTime() - iTargetEnt:getComponent("tiletype"):getAttribute("nLastTime") >= iTargetEnt:getComponent("tiletype"):getAttribute("nJianGe") then -- miao
        local mx = iTargetEnt:getComponent("position"):getAttribute("x");
        local my = iTargetEnt:getComponent("position"):getAttribute("y");
        local nMCol,nMRow = math.floor(mx/g_gameCfg.nBumpWorldCellSize) + 1,math.floor(my/g_gameCfg.nBumpWorldCellSize) + 1;
        -- self:trace(1,string.format('start create nMCol:%s,nMRow:%s', nMCol,nMRow));
        local nErrorCode = self:getSystem('buildsystem'):BuildMineral(nMRow,nMCol,iTargetEnt:getComponent("tiletype"):getAttribute("nMapType"));
        if nErrorCode == errorcode.error_code_0 then 
            iTargetEnt:getComponent("tiletype"):addAttribute("nHasMineral",true);
            -- self:trace(1,nErrorCode)
        end
    end
end

function tilesystem:ReClearTile(coreID)
    local iMineral = baseworld:getInstance():getEntity(coreID);
    local mx,my = iMineral:getComponent("position"):getAttribute("x"),iMineral:getComponent("position"):getAttribute("y");
    local nMCol,nMRow = math.floor(mx/g_gameCfg.nBumpWorldCellSize) + 1,math.floor(my/g_gameCfg.nBumpWorldCellSize) + 1;
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        if iTargetEnt:getComponent("tiletype") then 
            local c_tiletype = iTargetEnt:getComponent("tiletype").tbData;
            local ex,ey = iTargetEnt:getComponent("position"):getAttribute("x"),iTargetEnt:getComponent("position"):getAttribute("y");
            local nECol,nERow = math.floor(ex/g_gameCfg.nBumpWorldCellSize) + 1,math.floor(ey/g_gameCfg.nBumpWorldCellSize) + 1; 
            if nMCol == nECol and nMRow == nERow then 
                c_tiletype.nHasMineral = false;
                self:getSystem('buildsystem'):SetMapBuild(nECol,nERow,false);
                -- self:trace(1,string.format('ReClearTile create nECol:%s,nERow:%s', nECol,nERow));
                iTargetEnt:getComponent("tiletype"):addAttribute("nLastTime",GetTime());
                break;
            end
        end
    end
end