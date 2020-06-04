_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "TEST", 
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});
            local e_gametitle = gametitle:new({c_title});
            local s_welceomsystem = welceomsystem:new();
        end
        cameramgr:getInstance():SetCameraStyle(g_project.CUR_PROJECT_CAMERA_FOLLOWLERP,
                g_project.CUR_PROJECT_CAMERA_FOLLOWSTYLE,g_project.CUR_PROJECT_CAMERA_SCALE);
        local CheckRepeatDir = function (tbdlist,lr,ud) 
            for i,v in ipairs(tbdlist) do 
                if v.x == lr and v.y == ud then 
                    return true;
                end 
            end
            return false;
        end
        local offsetRoomIdx = 0;
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
        for i,v in ipairs(tbUniqueDirList) do 
            for a = 1, 10 do 
                for b = 1, 10 do 
                    if a == 1 or a == 10 or b == 1 or b == 10 then 
                        local e_wall_id = self:CreateWall(v.x + (b-1) * 96,v.y + (a-1) * 64);
                        tbRoomList[v.sRoomID] = tbRoomList[v.sRoomID] or {};
                        tbRoomList[v.sRoomID][a] = tbRoomList[v.sRoomID][a] or {};
                        tbRoomList[v.sRoomID][a][b] = { id = e_wall_id, x = v.x + (b-1) * 96, y = v.y + (a-1) * 64};
                    end 
                end 
            end 
            if i == 1 then 
                herox = v.x + W/2 - 16;
                heroy = v.y + H/2 - 16;
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
        local tbDoorPreList = {};
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
                        local mywall = tbRoomList[v.sRoomID][nDoorRandom][10];
                        local newall = tbRoomList[sRoomID][nDoorRandom][1];
                        baseworld:getInstance():removeEntity(mywall.id);
                        baseworld:getInstance():removeEntity(newall.id);
                        self:CreateTile(mywall.x,mywall.y,96,64);
                        self:CreateTile(newall.x,newall.y,96,64);
                        self:CreateDoor(mywall.x + (96 - 16),mywall.y, 32, 64);
                        tbDoorPreList[sRoomID] = tbDoorPreList[sRoomID] or {};
                        tbDoorPreList[sRoomID].key = tbDoorPreList[sRoomID].key or 0;
                        tbDoorPreList[sRoomID].key = tbDoorPreList[sRoomID].key + 1;
                    elseif nDir == 'd' then
                        local mywall = tbRoomList[v.sRoomID][10][nDoorRandom];
                        local newall = tbRoomList[sRoomID][1][nDoorRandom];
                        baseworld:getInstance():removeEntity(mywall.id);
                        baseworld:getInstance():removeEntity(newall.id);
                        self:CreateTile(mywall.x,mywall.y,96,64);
                        self:CreateTile(newall.x,newall.y,96,64);
                        self:CreateDoor(mywall.x,mywall.y + (64 - 16), 96, 32);
                        tbDoorPreList[sRoomID] = tbDoorPreList[sRoomID] or {};
                        tbDoorPreList[sRoomID].key = tbDoorPreList[sRoomID].key or 0;
                        tbDoorPreList[sRoomID].key = tbDoorPreList[sRoomID].key + 1;
                    end
                end 
            end 
        end 
        self:CreateHero(herox,heroy);
        for i,v in ipairs(tbUniqueDirList) do 
            self:CreateTile(v.x + 96 ,v.y + 64,960 - 96*2, 640 - 64*2);
            for a = 1, 10 do 
                for b = 1, 10 do 
                    if not (a == 1 or a == 10 or b == 1 or b == 10) then 
                        self:RandomMakeItem(v.x + (b-1) * 96,v.y + (a-1) * 64);
                        if i ~= 1 then 
                            self:RandomMakeEnemy(v.x + (b-1) * 96,v.y + (a-1) * 64);
                        end
                    end 
                end 
            end
        end
        local s_drawshapesystem = drawshapesystem:new();
        local s_wasdmovesystem = wasdmovesystem:new();
        local s_bumprectsystem = bumprectsystem:new();
        local s_moveshapesystem = moveshapesystem:new();
        local s_randomdirsystem = randomdirsystem:new();
        local s_shootfiresystem = shootfiresystem:new();
        local s_awakensystem = awakensystem:new();
        local s_bulletsflystem = bulletsflystem:new();
        local btn_txt = uimgr:getInstance():create("shapebutton","btn_txt");
        btn_txt:SetData('Position', "x",0);
        btn_txt:SetData('Position', "y",0);
        btn_txt:SetText("Day 1");
        btn_txt:SetData("Size","w",W);
        btn_txt:SetData("Size","h",H);
        btn_txt:SetData("Style","bgcolor",{0,0,0,1});
        btn_txt:SetData("Style","bHoverColor",{0,0,0,1});
        btn_txt:SetData("Style","nFontSize",36);
        scenemgr:getInstance():startupSystem(1,function () 
            timer:tween(3, btn_txt:GetCompo("Style"), {bgcolor = {0,0,0,0}, bHoverColor = {0,0,0,0}, txtcolor={1,1,1,0}}, 'in-out-cubic', function() 
                uimgr:getInstance():remove(btn_txt);
                s_drawshapesystem:startup();
                s_wasdmovesystem:startup();
                s_bumprectsystem:startup();
                s_moveshapesystem:startup();
                s_randomdirsystem:startup();
                s_shootfiresystem:startup();
                s_awakensystem:startup();
                s_bulletsflystem:startup();
            end)
        end)
        -- 测试随机生成场景用
        -- local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
        -- btn_enter:SetPositionCenter(0,130);
        -- btn_enter:SetText("开始");
        -- btn_enter:SetData("Oper", "onClick", function ()
        --     scenemgr:getInstance():switchScene("gamescene");
        -- end)
    end)
end

function gamescene:CreateTile(x,y,w,h)
    local c_tile_position = position:new({ x = x, y = y });
    local c_tile_size = size:new({ w = w, h = h });
    local c_tile_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
    local c_tile_shaperender = shaperender:new({ color = {0.6,0.3,0.7,0.4}, drawType="shape",shapeType = "rectangle", 
                                                        fillType = "fill" });
    local e_tile = tile:new({ c_tile_position,c_tile_size,c_tile_shaperender,c_tile_sortorder });
end

function gamescene:CreateItem(x,y)
    local c_item_position = position:new({ x = x, y = y });
    local c_item_size = size:new({ w = 32, h = 32 });
    local c_item_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN_DOWN;});
    local c_item_bumprect = bumprect:new();
    local c_item_shaperender = shaperender:new({ color = {1,0.2,0.5,1}, drawType="shape",shapeType = "rectangle", 
                                                        fillType = "fill" });
    local e_item = item:new({ c_item_position,c_item_size,c_item_shaperender,c_item_sortorder,c_item_bumprect });
end

function gamescene:CreateEnemy(x,y)
    local c_enemy_position = position:new({ x = x, y = y });
    local c_enemy_size = size:new({ w = 32, h = 32 });
    local c_enemy_direction = direction:new({ x = 0, y = 0 });
    local c_enemy_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
    local c_enemy_randomdir = randomdir:new({nProgNum = 199, nJianGe = math.random(100,300)});
    local c_enemy_moveshape = moveshape:new();
    local c_enemy_bumprect = bumprect:new();
    local c_enemy_speed = speed:new({ speed = 70 });
    local c_enemy_awaken = awaken:new({nRange = 100,bAwaken = false, bOffset = false,tbTargetTypes = {'hero'}});
    local c_enemy_shaperender = shaperender:new({ color = {0.7,1,0,0.7}, drawType="shape",shapeType = "rectangle", 
                                                        fillType = "fill" });
    local e_item = enemy:new({ c_enemy_position,c_enemy_size,c_enemy_shaperender,c_enemy_direction,
                    c_enemy_sortorder,c_enemy_randomdir,c_enemy_moveshape,c_enemy_bumprect,c_enemy_speed,
                    c_enemy_awaken });
end

function gamescene:CreateHero(x,y)
    local c_hero_position = position:new({ x = x, y = y });
    local c_hero_size = size:new({ w = 32, h = 32 });
    local c_hero_direction = direction:new({ x= 0, y = 0 });
    local c_hero_speed = speed:new({ speed = 160 });
    local c_hero_wasdmove = wasdmove:new();
    local c_hero_bumprect = bumprect:new();
    local c_hero_awaken = awaken:new({nRange = 32,bAwaken = false, bOffset = false,tbTargetTypes = {'enemy','item','door'}});
    local c_hero_shootfire = shootfire:new({nProgNum = 1, nJianGe = 16});
    local c_hero_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
    local c_hero_shaperender = shaperender:new({ color = g_color.BLUE, drawType="shape",shapeType = "rectangle", 
                                                        fillType = "fill" });
    local e_hero = hero:new({ c_hero_position,c_hero_size,c_hero_shaperender,
    c_hero_direction,c_hero_speed,c_hero_wasdmove,c_hero_sortorder,c_hero_bumprect,
    c_hero_awaken,c_hero_shootfire });
    cameramgr:getInstance():SetFollowPlayer(e_hero);
end

function gamescene:CreateDoor(x,y,w,h)
    local c_door_position = position:new({ x = x, y = y });
    local c_door_size = size:new({ w = w, h = h });
    local c_door_bumprect = bumprect:new();
    local c_door_sortorder = sortorder:new({nLayerIndex = g_tbLayer.DOOR;});
    local c_door_shaperender = shaperender:new({ color = {1,1,1,1}, drawType="shape",shapeType = "rectangle", 
                                                        fillType = "fill" });
    local e_door = door:new({ c_door_position,c_door_size,c_door_shaperender,c_door_sortorder , c_door_bumprect });
end

function gamescene:CreateWall(x,y)
    local c_wall_position = position:new({ x = x, y = y });
    local c_wall_size = size:new({ w = 96, h = 64 });
    local c_wall_bumprect = bumprect:new();
    local c_wall_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND;});
    local c_wall_shaperender = shaperender:new({ color = {205/255,129/255,98/255,0}, drawType="shape",shapeType = "rectangle", 
                                                        fillType = "fill" });
    local e_wall = wall:new({ c_wall_position,c_wall_size,c_wall_shaperender,c_wall_sortorder,c_wall_bumprect });
    return e_wall.id;
end

function gamescene:RandomMakeItem(x,y)
    local commitPercent_item = 0.06;
    local percent_item = commitPercent_item*10000;
    local randomNum = math.random(1,10000);
    if randomNum <= percent_item then 
        self:CreateItem(x,y);
    end 
end

function gamescene:RandomMakeEnemy(x,y)
    local commitPercent_enemy = 0.1;
    local percent_enemy = commitPercent_enemy*10000;
    local randomNum = math.random(1,10000);
    if randomNum <= percent_enemy then 
        self:CreateEnemy(x,y);
    end 
end