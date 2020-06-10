_G.testscene = class('testscene',basescene)

function testscene:onEnterScene()
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
        local c_hero_position = position:new({ x = 300, y = 300 });
        local c_hero_size = size:new({ w = 32, h = 32 });
        local c_hero_shaperender = shaperender:new({ color = g_color.GREEN, drawType="shape",shapeType = "rectangle", 
                                                            fillType = "fill" });
        -------------------------------------------------------------------------------------------------
        local c_enemy_position = position:new({ x = 400, y = 300 });
        local c_enemy_size = size:new({ w = 32, h = 32 });
        local c_enemy_shaperender = shaperender:new({ color = g_color.BLUE, drawType="shape",shapeType = "rectangle", 
                                                            fillType = "fill" });
        -------------------------------------------------------------------------------------------------
        local c_enemy_position_2 = position:new({ x = 200, y = 300 });
        local c_enemy_size_2 = size:new({ w = 32, h = 32 });
        local c_enemy_shaperender_2 = shaperender:new({ color = g_color.BLUE, drawType="shape",shapeType = "rectangle", 
                                                            fillType = "fill" });
        -------------------------------------------------------------------------------------------------
        local e_hero = hero:new({ c_hero_position,c_hero_size,c_hero_shaperender });
        local e_enemy_1 = enemy:new({ c_enemy_position,c_enemy_size,c_enemy_shaperender });
        local e_enemy_2 = enemy:new({ c_enemy_position_2,c_enemy_size_2,c_enemy_shaperender_2 });
        -------------------------------------------------------------------------------------------------
        cameramgr:getInstance():SetFollowPlayer(e_hero);
        -------------------------------------------------------------------------------------------------
        local s_drawshapesystem = drawshapesystem:new();
        -------------------------------------------------------------------------------------------------
        scenemgr:getInstance():startupSystem(0.1,function () 
            s_drawshapesystem:startup();
        end)
        -------------------------------------------------------------------------------------------------
    end)
end