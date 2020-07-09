_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "游戏", 
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});

            local e_gametitle = gametitle:new({c_title});
            local s_welcomesystem = welcomesystem:new();
        end
        -------------------------------------------------------------------------------------------------

        -- self:initCamera();

        -- cameramgr:getInstance():SetCameraStyle(g_project.CUR_PROJECT_CAMERA_FOLLOWLERP,
        -- g_project.CUR_PROJECT_CAMERA_FOLLOWSTYLE,g_project.CUR_PROJECT_CAMERA_SCALE);

        -- cameramgr:getInstance():SetFollowPlayer(hero_he);

    end)
end