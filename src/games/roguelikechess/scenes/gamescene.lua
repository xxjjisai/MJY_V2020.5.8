_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "游戏", 
                                                            sVersion = "V2020.6.16", color = g_color.SECURITY});

            local e_gametitle = gametitle:new({c_title});
            local s_welcomesystem = welcomesystem:new();
        end
        -------------------------------------------------------------------------------------------------

        local s_bumprectsystem = bumprectsystem:new();
        local s_drawshapesystem = drawshapesystem:new();
        local s_wasdmovesystem = wasdmovesystem:new();

        local c_hero_position = position:new({ x = 600, y = 200 });
        local c_hero_size = size:new({ w = 32, h = 32 });
        local c_hero_speed = speed:new({ speed = 200 });
        local c_hero_direction = direction:new({ x = 0, y = 0 });
        local c_hero_wasdmove = wasdmove:new();
        local c_hero_bumprect = bumprect:new();
        local c_hero_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
        local c_hero_shaperender = shaperender:new({ color = g_color.GREEN, drawType="shape",shapeType = "rectangle", 
                                                            fillType = "line" });
        local e_hero = hero:new({ 
            c_hero_position,
            c_hero_size,
            c_hero_speed,
            c_hero_direction,
            c_hero_wasdmove,
            c_hero_sortorder,
            c_hero_shaperender,
            c_hero_bumprect,
         });
        
        cameramgr:getInstance():SetFollowPlayer(e_hero);

        local tbTileList = map1.tbTileList;
        for i = 1, #map1.tbTileList do
            for j = 1, #map1.tbTileList[i] do
                local sTile = map1.tbTileList[i][j];
                if sTile == "#" then
                    local c_tile_position = position:new({ x = (j-1)*96, y = (i-1)*64 });
                    local c_tile_size = size:new({ w = 96, h = 64 });
                    local c_tile_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
                    local c_tile_shaperender = shaperender:new({ color = g_color.BLUE, drawType="shape",shapeType = "rectangle", 
                                                                        fillType = "line" });
                    local e_tile = tile:new({ 
                        c_tile_position,
                        c_tile_size,
                        c_tile_sortorder,
                        c_tile_shaperender,
                     });
                end
            end
        end

        local tbBumpList = map1.tbBumpList;
        for i,v in ipairs(tbBumpList) do
            local c_tile_position = position:new({ x = v[1], y = v[2] });
            local c_tile_size = size:new({ w = v[3], h = v[4] });
            local c_tile_bumprect = bumprect:new();
            local c_tile_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
            local c_tile_shaperender = shaperender:new({ color = g_color.ALPHA, drawType="shape",shapeType = "rectangle", 
                                                                fillType = "line" });
            local e_tile = tile:new({ 
                c_tile_position,
                c_tile_size,
                c_tile_sortorder,
                c_tile_shaperender,
                c_tile_bumprect,
            });
        end

        scenemgr:startupSystem(0.1,function ()
            s_bumprectsystem:startup();
            s_drawshapesystem:startup();
            s_wasdmovesystem:startup();
        end)

    end)
end