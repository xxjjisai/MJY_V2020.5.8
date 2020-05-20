_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "游戏", 
                                                        sVersion = "V2020.5.8", color = g_color.SECURITY});

        local e_gametitle = gametitle:new({c_title});
        local s_welceomsystem = welceomsystem:new();
        -------------------------------------------------------------------------------------------------

        cameramgr:getInstance():SetCameraStyle("LOCKON",0.09,1);

        for i = 1, 30 do 
            for j = 1, 30 do 
                local maptile = self:CreateMapTile();
                maptile:getComponent("position"):addAttribute("x",(j - 1) * 33);
                maptile:getComponent("position"):addAttribute("y",(i - 1) * 33);
                if i == 1 or j == 1 or i == 30 or j == 30 then 
                    maptile:getComponent("shaperender"):addAttribute("color", colorconfig.MAP_TILE_SIDE );
                end
            end 
        end 

        local hero_he   = self:CreateHeroHe();
        local hero_he_2 = self:CreateHeroHe();
        hero_he_2:removeComponent("wasdmove");
        hero_he_2:getComponent("position"):addAttribute("x", 33 * 8 );
        hero_he_2:getComponent("position"):addAttribute("y", 33 * 8 );
        hero_he_2:getComponent("shaperender"):addAttribute("color", {1,1,0,1} );

        local s_drawshapesystem = drawshapesystem:new();
        local s_wasdmovesystem = wasdmovesystem:new();
        local s_editorsystem = editorsystem:new();

        scenemgr:getInstance():startupSystem(0.1,function ()
            s_wasdmovesystem:startup();
        end)
        
        cameramgr:getInstance():SetFollowPlayer(hero_he);

    end)
end

function gamescene:CreateHeroHe()
    local c_position = position:new({ x = W/2-16, y = H/2-16 });
    local c_size = size:new({ w = 32, h = 32 });
    local c_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN});
    local c_wasdmove = wasdmove:new({});
    local c_speed = speed:new({ speed = 120 });
    local c_direction = direction:new({ x = 1, y = 1 });
    local c_shaperender = shaperender:new({
        order = 1, 
        color = colorconfig.HERO_HE, 
        drawType="shape",
        shapeType = "rectangle",
        fillType = "fill"
    });
    local hero_he = hero:new({c_position,c_size,c_shaperender,c_sortorder,c_wasdmove,c_direction,c_speed});
    return hero_he;
end

function gamescene:CreateMapTile()
    local c_position = position:new({ x = W/2-16, y = H/2-16 });
    local c_size = size:new({ w = 32, h = 32 });
    local c_editor = editor:new({});
    local c_sortorder = sortorder:new({nLayerIndex = g_tbLayer.GROUND});
    local c_shaperender = shaperender:new({
        order = 1, 
        color = colorconfig.MAP_TILE, 
        drawType="shape",
        shapeType = "rectangle",
        fillType = "fill"
    });
    local maptile = tile:new({c_position,c_size,c_shaperender,c_sortorder,c_editor});
    return maptile;
end