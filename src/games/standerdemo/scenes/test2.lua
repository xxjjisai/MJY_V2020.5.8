




-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-- for i,v in ipairs(tbUniqueDirList) do 
        --     for a = 1, 10 do 
        --         for b = 1, 10 do 
        --             if a == 1 or a == 10 or b == 1 or b == 10 then 
        --                 local c_wall_position = position:new({ x = v.x + (b-1) * 96, y = v.y + (a-1) * 64 });
        --                 local c_wall_size = size:new({ w = 96, h = 64 });
        --                 local c_wall_bumprect = bumprect:new();
        --                 local c_wall_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
        --                 local c_wall_shaperender = shaperender:new({ color = tbRoomColor[v.nIdx], drawType="shape",shapeType = "rectangle", 
        --                                                                     fillType = "fill" });
        --                 local e_wall = wall:new({ c_wall_position,c_wall_size,c_wall_shaperender,c_wall_sortorder,c_wall_bumprect });
        --                 tbRoomList[v.sRoomID] = tbRoomList[v.sRoomID] or {};
        --                 tbRoomList[v.sRoomID][a] = tbRoomList[v.sRoomID][a] or {};
        --                 tbRoomList[v.sRoomID][a][b] = { id = e_wall.id, x = v.x + (b-1) * 96, y = v.y + (a-1) * 64};
        --             else 
        --                 -- if i == 1 then 
        --                     -- local c_tile_position = position:new({ x = v.x + (b-1) * 96, y = v.y + (a-1) * 64 });
        --                     -- local c_tile_size = size:new({ w = 96, h = 64 });
        --                     -- local c_tile_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
        --                     -- local c_tile_shaperender = shaperender:new({ color = {1,1,1,0.4}, drawType="shape",shapeType = "rectangle", 
        --                     --                                                     fillType = "fill" });
        --                     -- local e_tile = tile:new({ c_tile_position,c_tile_size,c_tile_shaperender,c_tile_sortorder });
        --                 -- else 
        --                     local c_tile_position = position:new({ x = v.x + (b-1) * 96, y = v.y + (a-1) * 64 });
        --                     local c_tile_size = size:new({ w = 96, h = 64 });
        --                     local c_tile_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
        --                     local c_tile_shaperender = shaperender:new({ color = {0.6,0.3,0.7,0.4}, drawType="shape",shapeType = "rectangle", 
        --                                                                         fillType = "fill" });
        --                     local e_tile = tile:new({ c_tile_position,c_tile_size,c_tile_shaperender,c_tile_sortorder });
        --                 -- end 
        --                 -----------------------------------------------------------------------------------------------
        --                 local randomNum = math.random(1,10000);
        --                 if randomNum <= percent_item then 
        --                     local c_item_position = position:new({ x = v.x + (b-1) * 96 + 32, y = v.y + (a-1) * 64 + 16 });
        --                     local c_item_size = size:new({ w = 32, h = 32 });
        --                     local c_item_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN_DOWN;});
        --                     local c_item_bumprect = bumprect:new();
        --                     local c_item_shaperender = shaperender:new({ color = {1,0.2,0.5,1}, drawType="shape",shapeType = "rectangle", 
        --                                                                         fillType = "fill" });
        --                     local e_item = item:new({ c_item_position,c_item_size,c_item_shaperender,
        --                                     c_item_sortorder,c_item_bumprect });
        --                 end 
        --                 if i == 1 then 

        --                 else 
        --                     local randomNum = math.random(1,10000);
        --                     if randomNum <= percent_enemy then 
        --                         local c_enemy_position = position:new({ x = v.x + (b-1) * 96 + 32, y = v.y + (a-1) * 64 + 16 });
        --                         local c_enemy_size = size:new({ w = 32, h = 32 });
        --                         local c_enemy_direction = direction:new({ x = 0, y = 0 });
        --                         local c_enemy_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
        --                         local c_enemy_randomdir = randomdir:new({nProgNum = 199, nJianGe = math.random(100,300)});
        --                         local c_enemy_moveshape = moveshape:new();
        --                         local c_enemy_bumprect = bumprect:new();
        --                         local c_enemy_speed = speed:new({ speed = 70 });
        --                         local c_enemy_shaperender = shaperender:new({ color = {0.7,1,0,0.7}, drawType="shape",shapeType = "rectangle", 
        --                                                                             fillType = "fill" });
        --                         local e_item = enemy:new({ c_enemy_position,c_enemy_size,c_enemy_shaperender,c_enemy_direction,
        --                                         c_enemy_sortorder,c_enemy_randomdir,c_enemy_moveshape,c_enemy_bumprect,c_enemy_speed });
        --                     end 
        --                 end
        --             end 
        --         end 
        --     end 
        --     if i == 1 then 
        --         herox = v.x + W/2 - 16;
        --         heroy = v.y + H/2 - 16;
        --     end
        --     -- if i == #tbUniqueDirList then 
        --     --     nextx = v
        --     -- end 
        -- end 