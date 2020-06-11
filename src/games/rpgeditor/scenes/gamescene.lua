_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "编辑器", 
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});

            local e_gametitle = gametitle:new({c_title});
            local s_welceomsystem = welceomsystem:new();
        end
        -------------------------------------------------------------------------------------------------

        local c_position = position:new({ x = 0, y = 0 });
        local c_size = size:new({ w = 1, h = 1 });
        local c_speed = speed:new({ speed = 100 });
        local c_direction = direction:new({ x = 0, y = 0 });
        local c_wasdmove = wasdmove:new();
        local c_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
        local c_shaperender = shaperender:new({ color = g_color.ALPHA, drawType="shape",shapeType = "rectangle", 
                                                            fillType = "line" });
        local e_hero = hero:new({ c_position,c_size,c_speed,c_direction,c_wasdmove,c_sortorder,c_shaperender });
        
        cameramgr:getInstance():SetFollowPlayer(e_hero);

        local s_moveselectsystem = moveselectsystem:new();
        local s_makebumpsystem   = makebumpsystem:new();
        local s_drawshapesystem  = drawshapesystem:new();
        local s_wasdmovesystem   = wasdmovesystem:new();
        local s_editorsystem   = editorsystem:new();

        scenemgr:getInstance():startupSystem(0.1,function ()
            s_drawshapesystem:startup();
            s_wasdmovesystem:startup();
            s_moveselectsystem:startup();
            s_makebumpsystem:startup();
            s_editorsystem:startup();
        end)


    end)
end