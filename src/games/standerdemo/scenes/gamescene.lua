_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "TEST", 
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});
            local e_gametitle = gametitle:new({c_title});
            local s_welceomsystem = welceomsystem:new();
        end
        -------------------------------------------------------------------------------------------------
        cameramgr:getInstance():SetCameraStyle(g_project.CUR_PROJECT_CAMERA_FOLLOWLERP,
                g_project.CUR_PROJECT_CAMERA_FOLLOWSTYLE,g_project.CUR_PROJECT_CAMERA_SCALE);
        -------------------------------------------------------------------------------------------------
        local CheckRepeatDir = function (tbdlist,lr,ud) 
            for i,v in ipairs(tbdlist) do 
                if v.x == lr and v.y == ud then 
                    return true;
                end 
            end
            return false;
        end
        local offsetRoomIdx = 0;
        local tbRoomColor = {
            {205/255,129/255,98/255,1};
            {205/255,129/255,98/255,1};
            {205/255,129/255,98/255,1};
            {205/255,129/255,98/255,1};
        }
        local nRoomCount = 1;
        local nTotalRoomCount = 10;
        local tbDirList = {};
        local offsetRoomIdxUD = 0;
        local offsetRoomIdxLR = 0;
        while nRoomCount <= nTotalRoomCount do 
            local nDir = math.random(1,4);
            if nDir == 1 then -- up
                offsetRoomIdxUD = offsetRoomIdxUD - 640;
            elseif nDir == 2 then -- down
                offsetRoomIdxUD = offsetRoomIdxUD + 640;
            elseif nDir == 3 then -- left 
                offsetRoomIdxLR = offsetRoomIdxLR - 960;
            elseif nDir == 4 then -- right 
                offsetRoomIdxLR = offsetRoomIdxLR + 960;
            end
            if not CheckRepeatDir(tbDirList,offsetRoomIdxLR,offsetRoomIdxUD) then 
                table.insert(tbDirList,{ x = offsetRoomIdxLR, y = offsetRoomIdxUD, nIdx = nDir, sRoomID = "room"..nRoomCount });
            end
            nRoomCount = nRoomCount + 1;
        end
        local tbUniqueDirList = table.unique(tbDirList, false);
        local tbRoomList = {};
        -- 随机概率
        local successCount =0;
        local commitPercent = 0.09;
        local percent = commitPercent*10000;
        for i,v in ipairs(tbUniqueDirList) do 
            local nDoorRandom = math.random(2,9);
            for a = 1, 10 do 
                for b = 1, 10 do 
                    if a == 1 or a == 10 or b == 1 or b == 10 then 
                        local c_wall_position = position:new({ x = v.x + (b-1) * 96, y = v.y + (a-1) * 64 });
                        local c_wall_size = size:new({ w = 96, h = 64 });
                        local c_wall_bumprect = bumprect:new();
                        local c_wall_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
                        local c_wall_shaperender = shaperender:new({ color = tbRoomColor[v.nIdx], drawType="shape",shapeType = "rectangle", 
                                                                            fillType = "fill" });
                        local e_wall = wall:new({ c_wall_position,c_wall_size,c_wall_shaperender,c_wall_sortorder,c_wall_bumprect });
                        tbRoomList[v.sRoomID] = tbRoomList[v.sRoomID] or {};
                        tbRoomList[v.sRoomID][a] = tbRoomList[v.sRoomID][a] or {};
                        tbRoomList[v.sRoomID][a][b] = { id = e_wall.id, x = v.x + (b-1) * 96, y = v.y + (a-1) * 64};
                    else 
                        -- if i == 1 then 
                            -- local c_tile_position = position:new({ x = v.x + (b-1) * 96, y = v.y + (a-1) * 64 });
                            -- local c_tile_size = size:new({ w = 96, h = 64 });
                            -- local c_tile_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
                            -- local c_tile_shaperender = shaperender:new({ color = {1,1,1,0.4}, drawType="shape",shapeType = "rectangle", 
                            --                                                     fillType = "fill" });
                            -- local e_tile = tile:new({ c_tile_position,c_tile_size,c_tile_shaperender,c_tile_sortorder });
                        -- else 
                            local c_tile_position = position:new({ x = v.x + (b-1) * 96, y = v.y + (a-1) * 64 });
                            local c_tile_size = size:new({ w = 96, h = 64 });
                            local c_tile_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
                            local c_tile_shaperender = shaperender:new({ color = {0.6,0.3,0.7,0.4}, drawType="shape",shapeType = "rectangle", 
                                                                                fillType = "fill" });
                            local e_tile = tile:new({ c_tile_position,c_tile_size,c_tile_shaperender,c_tile_sortorder });
                        -- end 
                        -----------------------------------------------------------------------------------------------
                        local randomNum = math.random(1,10000);
                        if randomNum <= percent then 
                            local c_enemy_position = position:new({ x = v.x + (b-1) * 96 + 32, y = v.y + (a-1) * 64 + 16 });
                            local c_enemy_size = size:new({ w = 32, h = 32 });
                            local c_enemy_direction = direction:new({ x = 0, y = 0 });
                            local c_enemy_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN_DOWN;});
                            local c_enemy_randomdir = randomdir:new({nProgNum = 199, nJianGe = math.random(100,300)});
                            local c_enemy_moveshape = moveshape:new();
                            local c_enemy_bumprect = bumprect:new();
                            local c_enemy_speed = speed:new({ speed = 70 });
                            local c_enemy_shaperender = shaperender:new({ color = {0.7,0.7,0,0.7}, drawType="shape",shapeType = "rectangle", 
                                                                                fillType = "fill" });
                            local e_item = enemy:new({ c_enemy_position,c_enemy_size,c_enemy_shaperender,c_enemy_direction,
                                            c_enemy_sortorder,c_enemy_randomdir,c_enemy_moveshape,c_enemy_bumprect,c_enemy_speed });
                        end 
                    end 
                end 
            end 
            if i == 1 then 
                herox = v.x + W/2 - 16;
                heroy = v.y + H/2 - 16;
            end
            -- if i == #tbUniqueDirList then 
            --     nextx = v
            -- end 
        end 
        local CheckInList = function (x,y,ndir) 
            for i,v in ipairs(tbUniqueDirList) do 
                if v.x == x and v.y == y then 
                    return v.sRoomID,ndir;
                end 
            end
            return nil,nil;
        end
        for i,v in ipairs(tbUniqueDirList) do 
            local nDoorRandom = math.random(2,9);
            local tbNig = 
            {
                { v.x + 960, v.y, 'r' },
                { v.x - 960, v.y, 'l' },
                { v.x, v.y + 640, 'd' },
                { v.x, v.y - 640, 'u' },
            }
            for a,b in ipairs(tbNig) do 
                local sRoomID,nDir = CheckInList(b[1],b[2],b[3]);
                if sRoomID then 
                    if nDir == 'r' then
                        local mytile = tbRoomList[v.sRoomID][nDoorRandom][10];
                        local neitile = tbRoomList[sRoomID][nDoorRandom][1];
                        baseworld:getInstance():removeEntity(mytile.id);
                        baseworld:getInstance():removeEntity(neitile.id);
                        local c_tile_position_my = position:new({ x = mytile.x, y = mytile.y });
                        local c_tile_size_my = size:new({ w = 96, h = 64 });
                        local c_tile_sortorder_my = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
                        local c_tile_shaperender_my = shaperender:new({ color = {0.6,0.3,0.7,0.4}, drawType="shape",shapeType = "rectangle", 
                                                                            fillType = "fill" });
                        local e_tile_my = tile:new({ c_tile_position_my,c_tile_size_my,c_tile_shaperender_my,c_tile_sortorder_my });
                        ----------------------------------------------------------------------------------------------------------------
                        local c_tile_position_nei = position:new({ x = neitile.x, y = neitile.y });
                        local c_tile_size_nei = size:new({ w = 96, h = 64 });
                        local c_tile_sortorder_nei = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
                        local c_tile_shaperender_nei = shaperender:new({ color = {0.6,0.3,0.7,0.4}, drawType="shape",shapeType = "rectangle", 
                                                                            fillType = "fill" });
                        local e_tile_nei = tile:new({ c_tile_position_nei,c_tile_size_nei,c_tile_shaperender_nei,c_tile_sortorder_nei });
                    elseif nDir == 'd' then
                        local mytile = tbRoomList[v.sRoomID][10][nDoorRandom];
                        local neitile = tbRoomList[sRoomID][1][nDoorRandom];
                        baseworld:getInstance():removeEntity(mytile.id);
                        baseworld:getInstance():removeEntity(neitile.id);
                        local c_tile_position_my = position:new({ x = mytile.x, y = mytile.y });
                        local c_tile_size_my = size:new({ w = 96, h = 64 });
                        local c_tile_sortorder_my = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
                        local c_tile_shaperender_my = shaperender:new({ color = {0.6,0.3,0.7,0.4}, drawType="shape",shapeType = "rectangle", 
                                                                            fillType = "fill" });
                        local e_tile_my = tile:new({ c_tile_position_my,c_tile_size_my,c_tile_shaperender_my,c_tile_sortorder_my });
                        ----------------------------------------------------------------------------------------------------------------
                        local c_tile_position_nei = position:new({ x = neitile.x, y = neitile.y });
                        local c_tile_size_nei = size:new({ w = 96, h = 64 });
                        local c_tile_sortorder_nei = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
                        local c_tile_shaperender_nei = shaperender:new({ color = {0.6,0.3,0.7,0.4}, drawType="shape",shapeType = "rectangle", 
                                                                            fillType = "fill" });
                        local e_tile_nei = tile:new({ c_tile_position_nei,c_tile_size_nei,c_tile_shaperender_nei,c_tile_sortorder_nei });
                    end
                end 
            end 
        end 
        -------------------------------------------------------------------------------------------------
        local c_hero_position = position:new({ x = herox, y = heroy });
        local c_hero_size = size:new({ w = 32, h = 32 });
        local c_hero_direction = direction:new({ x= 0, y = 0 });
        local c_hero_speed = speed:new({ speed = 210 });
        local c_hero_wasdmove = wasdmove:new();
        local c_hero_bumprect = bumprect:new();
        local c_hero_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
        local c_hero_shaperender = shaperender:new({ color = g_color.BLUE, drawType="shape",shapeType = "rectangle", 
                                                            fillType = "fill" });
        -------------------------------------------------------------------------------------------------
        local e_hero = hero:new({ c_hero_position,c_hero_size,c_hero_shaperender,
        c_hero_direction,c_hero_speed,c_hero_wasdmove,c_hero_sortorder,c_hero_bumprect });
        -------------------------------------------------------------------------------------------------
        cameramgr:getInstance():SetFollowPlayer(e_hero);
        -------------------------------------------------------------------------------------------------
        local s_drawshapesystem = drawshapesystem:new();
        local s_wasdmovesystem = wasdmovesystem:new();
        local s_bumprectsystem = bumprectsystem:new();
        local s_moveshapesystem = moveshapesystem:new();
        local s_randomdirsystem = randomdirsystem:new();
        -------------------------------------------------------------------------------------------------
        -- scenemgr:getInstance():startupSystem(5.1,function () 

        -- end)
        -------------------------------------------------------------------------------------------------
        local btn_txt = uimgr:getInstance():create("shapebutton","btn_txt");
        btn_txt:SetData('Position', "x",0);
        btn_txt:SetData('Position', "y",0);
        btn_txt:SetText("Day 1");
        btn_txt:SetData("Size","w",W);
        btn_txt:SetData("Size","h",H);
        btn_txt:SetData("Style","bgcolor",{0,0,0,1});
        btn_txt:SetData("Style","bHoverColor",{0,0,0,1});
        scenemgr:getInstance():startupSystem(1,function () 
            timer:tween(3, btn_txt:GetCompo("Style"), {bgcolor = {0,0,0,0}, bHoverColor = {0,0,0,0}, txtcolor={1,1,1,0}}, 'in-out-cubic', function() 
                uimgr:getInstance():remove(btn_txt)
                s_drawshapesystem:startup();
                s_wasdmovesystem:startup();
                s_bumprectsystem:startup();
                s_moveshapesystem:startup();
                s_randomdirsystem:startup();
            end)
        end)
        -- 测试随机生成场景用
        -- local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
        -- btn_enter:SetPositionCenter(0,130);
        -- btn_enter:SetText("开始");
        -- btn_enter:SetData("Oper", "onClick", function ()
        --     scenemgr:getInstance():switchScene("gamescene");
        -- end)
        -------------------------------------------------------------------------------------------------
    end)
end