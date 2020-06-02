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
            {1,1,1,0};
            {1,0,1,0};
            {1,0,0,0};
            {1,1,0,0};
        }
        local nRoomCount = 1;
        local nTotalRoomCount = 50;
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
        local nHeroX = 0;
        local nHeroY = 0;
        for i,v in ipairs(tbUniqueDirList) do 
            local nDoorRandom = math.random(2,9);
            for a = 1, 10 do 
                for b = 1, 10 do 
                    if a == 1 or a == 10 or b == 1 or b == 10 then 
                        local c_wall_position = position:new({ x = v.x + (b-1) * 96, y = v.y + (a-1) * 64 });
                        local c_wall_size = size:new({ w = 96, h = 64 });
                        local c_wall_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
                        local c_wall_shaperender = shaperender:new({ color = tbRoomColor[v.nIdx], drawType="shape",shapeType = "rectangle", 
                                                                            fillType = "fill" });
                        local e_wall = wall:new({ c_wall_position,c_wall_size,c_wall_shaperender,c_wall_sortorder });
                        tbRoomList[v.sRoomID] = tbRoomList[v.sRoomID] or {};
                        tbRoomList[v.sRoomID][a] = tbRoomList[v.sRoomID][a] or {};
                        tbRoomList[v.sRoomID][a][b] = { id = e_wall.id, x = v.x + (b-1) * 96, y = v.y + (a-1) * 64};
                    else 
                        local c_tile_position = position:new({ x = v.x + (b-1) * 96, y = v.y + (a-1) * 64 });
                        local c_tile_size = size:new({ w = 96, h = 64 });
                        local c_tile_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
                        local c_tile_shaperender = shaperender:new({ color = {0.6,0.3,0.7,0.4}, drawType="shape",shapeType = "rectangle", 
                                                                            fillType = "fill" });
                        local e_tile = tile:new({ c_tile_position,c_tile_size,c_tile_shaperender,c_tile_sortorder });
                        -----------------------------------------------------------------------------------------------
                        if math.random(1,100) % 5 == 0 then 
                            local c_item_position = position:new({ x = v.x + (b-1) * 96 + 32, y = v.y + (a-1) * 64 + 16 });
                            local c_item_size = size:new({ w = 32, h = 32 });
                            local c_item_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN_DOWN;});
                            local c_item_shaperender = shaperender:new({ color = {0.7,0.7,0,0.7}, drawType="shape",shapeType = "rectangle", 
                                                                                fillType = "fill" });
                            local e_item = item:new({ c_item_position,c_item_size,c_item_shaperender,c_item_sortorder });
                        end 
                    end 
                end 
            end 
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
        local c_hero_position = position:new({ x = 300, y = 300 });
        local c_hero_size = size:new({ w = 32, h = 32 });
        local c_hero_direction = direction:new({ x= 0, y = 0 });
        local c_hero_speed = speed:new({ speed = 210 });
        local c_hero_wasdmove = wasdmove:new();
        local c_hero_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
        local c_hero_shaperender = shaperender:new({ color = g_color.BLUE, drawType="shape",shapeType = "rectangle", 
                                                            fillType = "fill" });
        -------------------------------------------------------------------------------------------------
        local e_hero = hero:new({ c_hero_position,c_hero_size,c_hero_shaperender,c_hero_direction,c_hero_speed,c_hero_wasdmove,c_hero_sortorder });
        -------------------------------------------------------------------------------------------------
        cameramgr:getInstance():SetFollowPlayer(e_hero);
        -------------------------------------------------------------------------------------------------
        local s_drawshapesystem = drawshapesystem:new();
        local s_wasdmovesystem = wasdmovesystem:new();
        -------------------------------------------------------------------------------------------------
        scenemgr:getInstance():startupSystem(0.1,function () 
            s_drawshapesystem:startup();
            s_wasdmovesystem:startup();
        end)
        -------------------------------------------------------------------------------------------------
    end)
end