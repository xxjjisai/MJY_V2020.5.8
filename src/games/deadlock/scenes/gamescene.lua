_G.gamescene = class('gamescene',basescene)

function gamescene:onExitScene()
    g_project.CUR_PROJECT_CAMERA_SCALE = 0.1;
    self.e_follow_camera = nil;
end

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        -- if g_option.DEBUG > 0 then 
        --     local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "游戏", 
        --                                                     sVersion = "V2020.5.8", color = g_color.SECURITY});
        --     local e_gametitle = actor:new({c_title});
        --     local s_welcomesystem = welcomesystem:new();
        -- end


        local s_starskysystem = starskysystem:new();
        local s_drawshapesystem = drawshapesystem:new();
        local s_wasdmovesystem = wasdmovesystem:new();
        local s_animationsystem = animationsystem:new();
        local s_bumprectsystem = bumprectsystem:new();
        local s_actormovesystem = actormovesystem:new();
        local s_findpathsystem = findpathsystem:new();
        local s_playeropersystem = playeropersystem:new();
        local s_buildsystem = buildsystem:new();
        local s_collectmineralsystem = collectmineralsystem:new();
        local s_tilesystem = tilesystem:new();
        local s_playersystem = playersystem:new();
        local s_mapsystem = mapsystem:new();
        local s_armysystem = armysystem:new();

        scenemgr:getInstance():startupSystem(0.1,function ()
            s_drawshapesystem:startup();
            s_wasdmovesystem:startup();
            s_bumprectsystem:startup();
            s_actormovesystem:startup();
            s_findpathsystem:startup();
            s_mapsystem:startup();
            s_playeropersystem:startup();
            s_buildsystem:startup();
            s_collectmineralsystem:startup();
            s_tilesystem:startup();
            s_playersystem:startup();
            s_animationsystem:startup();
            s_armysystem:startup();
            s_starskysystem:startup();
        end)

        
        self:getSystem('mapsystem'):MakeMap();
        self:CreateCameraFollowActor();
        self:CreatePlanetSide();
        self:CreateSide();

        cameramgr:TweenScale(3,0.55,function ()
            g_project.CUR_PROJECT_CAMERA_SCALE = 0.55;
        end)
        self:CreateRokt(function () 
            self:CreateUI();
        end);
    end)
end

function gamescene:CreateRokt(pfn)
    local tbMap = self:getSystem('mapsystem'):getCurMap();
    local tbBornList = {};
    for i = 1, #tbMap do 
        for j = 1, #tbMap[i] do 
            if tbMap[i][j] == 1 then 
                table.insert(tbBornList,{ nCol = i, nRow = j })
            end
        end
    end
    local tbBornPoint = tbBornList[math.random(1,#tbBornList)];
    local nBornX,nBornY = (tbBornPoint.nRow-1) * g_gameCfg.nBumpWorldCellSize,(tbBornPoint.nCol-1) * g_gameCfg.nBumpWorldCellSize

    local c_position = position:new({ x = nBornX, y = -2000 });
    local c_size = size:new({ w = g_gameCfg.nBumpWorldCellSize, h = g_gameCfg.nBumpWorldCellSize });
    local c_direction = direction:new({x = 1, y= 1 });
    local c_speed = speed:new({speed=450}); 
    local c_animaterender = animaterender:new({
        bRunning = true, 
        color = {1,1,1,1}, 
        nStartFrame = 1, 
        nEndFrame = 1, 
        bStartPlay = true, 
        sImg = "rokt", 
        nQuadW = 32, 
        nQuadH = 32, 
        nTotalFrame= 1, 
        nLoop = 1, 
        nTotalPlayCount = 0, 
        nTimeAfterPlay = 0.15,
    });
    local e_rokt = actor:new({c_position,c_size,c_direction,c_speed,c_animaterender});
    timer:tween(5, e_rokt:tweenData('position'), { y = nBornY }, 'in-out-cubic', function() 
        local tbExplorerMapInfo = self:getSystem('mapsystem').tbExplorerMapInfo;
        tbExplorerMapInfo[tbBornPoint.nCol][tbBornPoint.nRow] = 2;
        local tbNegi = {
            { tbBornPoint.nCol, tbBornPoint.nRow - 1 },
            { tbBornPoint.nCol, tbBornPoint.nRow + 1 },
            { tbBornPoint.nCol - 1, tbBornPoint.nRow },
            { tbBornPoint.nCol + 1, tbBornPoint.nRow },
        }
        for i,v in ipairs(tbNegi) do 
            if tbExplorerMapInfo[v[1]][v[2]] == 1 then 
                tbExplorerMapInfo[v[1]][v[2]] = 2;
            end 
        end 
        self.e_follow_camera:getComponent('position'):addAttribute('x', nBornX);
        self.e_follow_camera:getComponent('position'):addAttribute('y', nBornY);
        cameramgr:TweenScale(1,1,function ()
            g_project.CUR_PROJECT_CAMERA_SCALE = 0.55;
            timer:tween(2, e_rokt:tweenData('animaterender'), { color = {1,1,1,0} }, 'in-out-cubic', function() 
                -- e_rokt:getComponent('animaterender'):addAttribute('color', {1,1,1,1});
                if pfn then 
                    pfn()
                end
            end)
        end)

    end)
end

function gamescene:CreatePlanetSide()
    local c_pos = position:new({ x = 16 * g_gameCfg.nBumpWorldCellSize, y = 16 * g_gameCfg.nBumpWorldCellSize });
    local c_siz = size:new({ w = 16 * g_gameCfg.nBumpWorldCellSize, h = 16 * g_gameCfg.nBumpWorldCellSize });
    local c_shaperender = shaperender:new({ 
        color = {1,1,1,0.1},
        drawType="shape",
        shapeType = "circle", 
        nSideCount = 100,
        fillType = "fill"
    });
    local c_planet = actor:new({c_pos,c_siz,c_shaperender});
end

function gamescene:CreateCameraFollowActor()
    local c_position = position:new({ x = (g_gameCfg.nBumpWorldCellSize * 32)/2 - g_gameCfg.nBumpWorldCellSize/2, y = (g_gameCfg.nBumpWorldCellSize * 32)/2 - g_gameCfg.nBumpWorldCellSize/2 });
    local c_size = size:new({ w = g_gameCfg.nBumpWorldCellSize, h = g_gameCfg.nBumpWorldCellSize });
    local c_direction = direction:new({x = 1, y= 1 });
    local c_speed = speed:new({speed=450}); 
    local c_wasdmove = wasdmove:new();
    local c_bumprect = bumprect:new();
    self.e_follow_camera = actor:new({c_position,c_size,c_direction,c_speed,c_wasdmove,c_bumprect});
    cameramgr:getInstance():SetFollowPlayer(self.e_follow_camera);
end

function gamescene:CreateSide()

    local tbMap = self:getSystem('mapsystem'):getCurMap();
    local nTotal = #tbMap;
    local nCellSize = g_gameCfg.nBumpWorldCellSize;
    
    local nBumpRectH = nTotal * nCellSize;
    local nBumpRectW = nCellSize;
    local c_pos_left = position:new({ x = -32, y = 0 });
    local c_siz_left = size:new({ w = nBumpRectW, h = nBumpRectH });
    local c_shaperender_left = shaperender:new({ color = g_color.ALPHA,drawType="shape",shapeType = "rectangle", fillType = "fill"});
    local c_bumprect_left = bumprect:new();
    local c_tile_left = actor:new({c_pos_left,c_siz_left,c_bumprect_left,c_shaperender_left});

    nBumpRectH = nTotal * nCellSize;
    nBumpRectW = nCellSize;
    local c_pos_right = position:new({ x = nTotal * nCellSize, y = 0 });
    local c_siz_right = size:new({ w = nBumpRectW, h = nBumpRectH });
    local c_shaperender_right = shaperender:new({ color = g_color.ALPHA,drawType="shape",shapeType = "rectangle", fillType = "fill"});
    local c_bumprect_right = bumprect:new();
    local c_tile_right = actor:new({c_pos_right,c_siz_right,c_bumprect_right,c_shaperender_right});

    local nBumpRectH = nCellSize;
    local nBumpRectW = nTotal * nCellSize;
    local c_pos_up = position:new({ x = 0, y = -32 });
    local c_siz_up = size:new({ w = nBumpRectW, h = nBumpRectH });
    local c_shaperender_up = shaperender:new({ color = g_color.ALPHA,drawType="shape",shapeType = "rectangle", fillType = "fill"});
    local c_bumprect_up = bumprect:new();
    local c_tile_up = actor:new({c_pos_up,c_siz_up,c_bumprect_up,c_shaperender_up});

    nBumpRectH = nCellSize;
    nBumpRectW = nTotal * nCellSize;
    local c_pos_down = position:new({ x = 0, y = nTotal * nCellSize });
    local c_siz_down = size:new({ w = nBumpRectW, h = nBumpRectH });
    local c_shaperender_down = shaperender:new({ color = g_color.ALPHA,drawType="shape",shapeType = "rectangle", fillType = "fill"});
    local c_bumprect_down = bumprect:new();
    local c_tile_down = actor:new({c_pos_down,c_siz_down,c_bumprect_down,c_shaperender_down});
end

function gamescene:CreateUI()

    local tbMapBuildList = {};
    for i,v in ipairs(maptypeconfig) do 
        local btn_mapbuild = uimgr:getInstance():create("shapebutton","btn_mapbuild"..v.sName);
        btn_mapbuild:SetPosition(3, (H - 43) - (i * (40 + 3)));
        btn_mapbuild:SetSize(v.w,v.h);
        btn_mapbuild:SetText(' ');
        -- if i == 1 then 
        --     btn_mapbuild:SetData("Image", "bNeedImg",true);
        --     btn_mapbuild:SetData("Image", "sImg","tile_2");
        -- end 
        btn_mapbuild:SetData("Style", "bgcolor", v.color);--{1,0.3,0.3,1});
        -- btn_mapbuild:SetData("Style", "bHoverColor", {1,0.5,0.5,1});
        btn_mapbuild:SetData("Oper", "onClick", function ()
            self:getSystem('playeropersystem'):SetBuildOrMap(buildtypeconfig.nTileType);
            self:getSystem('playeropersystem'):SetChangeMapType(v.nType);
        end)
        btn_mapbuild.bVisible = false;
        table.insert(tbMapBuildList, btn_mapbuild);

        local ipt_mapbuild = uimgr:getInstance():create("shapetextinput","ipt_mapbuild"..v.sName);
        ipt_mapbuild:SetPosition(3 + 103, (H - 43) - (i * (40 + 3)));
        ipt_mapbuild:SetSize(100,40);
        ipt_mapbuild:SetText(" ");
        ipt_mapbuild:SetData("Style", "nFontSize", 20);
        ipt_mapbuild:SetData("Style", "bCenter", false);
        ipt_mapbuild:SetStyle(1);
        ipt_mapbuild.bVisible = false;
        ipt_mapbuild.bOpenbBubbling = false; -- 可以鼠标穿透
        table.insert(tbMapBuildList, ipt_mapbuild);
    end 

    local btn_build = uimgr:getInstance():create("shapebutton","btn_build");
    btn_build:SetPosition(40 + 6, H - 43);
    btn_build:SetSize(80,40);
    btn_build:SetText("核芯");
    btn_build:SetData("Style", "nFontSize", 20);
    btn_build.bVisible = false;
    btn_build:SetData("Oper", "onClick", function ()
        self:getSystem('playeropersystem'):SetBuildOrMap(buildtypeconfig.nCoreType);
    end)

    local btn_army = uimgr:getInstance():create("shapebutton","btn_army");
    btn_army:SetPosition(48 + 82, H - 43);
    btn_army:SetSize(80,40);
    btn_army:SetText("防御");
    btn_army:SetData("Style", "nFontSize", 20);
    btn_army.bVisible = false;
    btn_army:SetData("Oper", "onClick", function ()
        self:getSystem('playeropersystem'):SetBuildOrMap(buildtypeconfig.nArmyType);
    end)

    local btn_uninstall = uimgr:getInstance():create("shapebutton","btn_uninstall");
    btn_uninstall:SetPosition(50 + 82 * 2, H - 43);
    btn_uninstall:SetSize(80,40);
    btn_uninstall:SetText("卸载");
    btn_uninstall:SetData("Style", "nFontSize", 20);
    btn_uninstall.bVisible = false;
    btn_uninstall:SetData("Oper", "onClick", function ()
        self:getSystem('playeropersystem'):SetBuildOrMap(buildtypeconfig.nXieZai);
    end)

    local btn_explorer = uimgr:getInstance():create("shapebutton","btn_explorer");
    btn_explorer:SetPosition(50 + 2 + 82 * 3, H - 43);
    btn_explorer:SetSize(80,40);
    btn_explorer:SetText("探索");
    btn_explorer:SetData("Style", "nFontSize", 20);
    btn_explorer.bVisible = false;
    btn_explorer:SetData("Oper", "onClick", function ()
        if self:getSystem('mapsystem').bExplorerMap then 
            self:getSystem('mapsystem'):switchMapShow(false);
            btn_explorer:SetText("探索");
            for i,v in ipairs(tbMapBuildList) do 
                v.bGrey = false;
            end 
            btn_build.bGrey = false;
            btn_army.bGrey = false;
            btn_uninstall.bGrey = false;
        else 
            self:getSystem('mapsystem'):switchMapShow(true);
            btn_explorer:SetText("采集");
            for i,v in ipairs(tbMapBuildList) do 
                v.bGrey = true;
            end 
            btn_build.bGrey = true;
            btn_army.bGrey = true;
            btn_uninstall.bGrey = true;
        end
    end)

    local btn_map = uimgr:getInstance():create("shapebutton","btn_map");
    btn_map:SetPosition(3, H - 43);
    btn_map:SetSize(40,40);
    btn_map:SetText("+");
    btn_map:SetData("Oper", "onClick", function ()
        for i,v in ipairs(tbMapBuildList) do 
            v.bVisible = not v.bVisible;
        end 
        btn_build.bVisible = not btn_build.bVisible;
        btn_army.bVisible = not btn_army.bVisible;
        btn_uninstall.bVisible = not btn_uninstall.bVisible;
        btn_explorer.bVisible = not btn_explorer.bVisible;
        if btn_build.bVisible == true then 
            btn_map:SetText("-");
        else 
            btn_map:SetText("+");
        end
    end)


    -- local btn_menu = uimgr:getInstance():create("shapebutton","btn_menu");
    -- btn_menu:SetPosition(W - 82, H - 43);
    -- btn_menu:SetSize(80,40);
    -- btn_menu:SetText("菜单");
    -- btn_menu:SetData("Style", "nFontSize", 20);
    -- btn_menu:SetData("Oper", "onClick", function ()
    --     scenemgr:getInstance():switchScene("welcomescene");
    -- end)
end