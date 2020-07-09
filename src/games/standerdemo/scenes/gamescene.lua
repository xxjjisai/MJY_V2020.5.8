_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "游戏", 
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});

            local e_gametitle = actor:new({c_title});
            local s_welcomesystem = welcomesystem:new();
        end
        -------------------------------------------------------------------------------------------------

        -- self:initCamera();

        -- cameramgr:getInstance():SetCameraStyle(g_project.CUR_PROJECT_CAMERA_FOLLOWLERP,
        -- g_project.CUR_PROJECT_CAMERA_FOLLOWSTYLE,g_project.CUR_PROJECT_CAMERA_SCALE);

        -- 生成地图
        -- local c_mapmaker = mapmaker:new({});
        -- local e_map = actor:new({c_mapmaker});

        -- 生成Hero
        -- local c_position = position:new({ x = 1, y = 1 });
        -- local c_size = size:new({ w = 64, h = 64 });
        -- local c_shaperender = shaperender:new({ color = g_color.RED, drawType="shape",shapeType = "rectangle", fillType = "fill" });
        -- local e_hero = actor:new({c_position,c_size,c_shaperender});
        
        -- cameramgr:getInstance():SetFollowPlayer(e_hero);

        -- local s_drawshapesystem = drawshapesystem:new();
        -- scenemgr:getInstance():startupSystem(0.1,function ()
        --     s_drawshapesystem:startup();
        -- end)

    end)
end