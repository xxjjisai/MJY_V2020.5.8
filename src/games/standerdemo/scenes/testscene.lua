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
        local c__hero_position = position:new({ x = 300, y = 300 });
        local c__hero_size = size:new({ w = 32, h = 32 });
        local c__hero_shaperender = shaperender:new({ color = g_color.GREEN, drawType="shape",shapeType = "rectangle", fillType = "line" });
        -------------------------------------------------------------------------------------------------
        local e_hero = hero:new({ c__hero_position,c__hero_size,c__hero_shaperender });
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