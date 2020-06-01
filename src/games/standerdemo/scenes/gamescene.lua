_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "游戏", 
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});

            local e_gametitle = gametitle:new({c_title});
            local s_welceomsystem = welceomsystem:new();
        end
        -------------------------------------------------------------------------------------------------

        cameramgr:getInstance():SetCameraStyle(g_project.CUR_PROJECT_CAMERA_FOLLOWLERP,
				g_project.CUR_PROJECT_CAMERA_FOLLOWSTYLE,g_project.CUR_PROJECT_CAMERA_SCALE);

        local padding = 1;
        local tile_w = 32;
        local tile_h = 25;

        for i = 1, 10 do 
            for j = 1, 10 do 
                local c_position = position:new({ x = (i-1) * (tile_w + padding), y = (j-1) * (tile_h + padding) });
                local c_size = size:new({ w = tile_w, h = tile_h });
                local c_shaperender = shaperender:new({ 
                    color = g_color.GREEN, 
                    drawType="shape",
                    shapeType = "rectangle", 
                    fillType = "line"
                });
                local e_hero = hero:new({ c_position,c_size,c_shaperender });
                if i == 5 and j == 5 then 
                    cameramgr:getInstance():SetFollowPlayer(e_hero);
                end
            end 
        end 


        local s_drawshapesystem = drawshapesystem:new();

    end)
end