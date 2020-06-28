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

        cameramgr:getInstance():SetCameraStyle(g_project.CUR_PROJECT_CAMERA_FOLLOWLERP,
        g_project.CUR_PROJECT_CAMERA_FOLLOWSTYLE,g_project.CUR_PROJECT_CAMERA_SCALE);

        local s_drawshapesystem = drawshapesystem:new();
        local s_wasdmovesystem = wasdmovesystem:new();
        local s_animationsystem = animationsystem:new();
        local s_moveselectsystem = moveselectsystem:new();
        
        scenemgr:getInstance():startupSystem(0.1,function ()
            s_drawshapesystem:startup();
            s_wasdmovesystem:startup();
            s_moveselectsystem:startup();
            s_animationsystem:startup();
        end)

        for i = 1, 50 do 
            for j = 1, 50 do 
                local c_position    = position:new({ x = (j-1) * 96, y = (i-1) * 64});
                local c_size        = size:new({ w = 96, h = 64 });
                local c_moveselect  = moveselect:new();
                -- local c_shaperender = shaperender:new({ 
                --     order = 1, 
                --     color = g_color.ALPHA, 
                --     drawType="shape",
                --     shapeType = "rectangle", 
                --     fillType = "line", 
                -- });
                local c_animaterender = animaterender:new({
                    bRunning = true, 
                    color = g_color.RED, 
                    nStartFrame = 1, 
                    nEndFrame = 4, 
                    bStartPlay = true, 
                    sImg = "mt_4", 
                    nQuadW = 32, 
                    nQuadH = 32, 
                    nTotalFrame= 1, 
                    nLoop = 1, 
                    nTotalPlayCount = 0, 
                    nTimeAfterPlay = 0.15 
                });
                local e_hero = hero:new({
                    c_position, 
                    c_size, 
                    c_animaterender,
                    -- c_shaperender,
                    c_moveselect,
                });
            end
        end

        local c_position    = position:new({ x = 0, y = 0 });
        local c_size        = size:new({ w = 10, h = 10 });
        local c_direction   = direction:new({x = 0, y = 0});
        local c_speed       = speed:new({ speed = 200 });
        local c_wasdmove    = wasdmove:new();
        local c_moveselect  = moveselect:new();
        local c_shaperender = shaperender:new({ 
            order = 1, 
            color = g_color.BLUE, 
            drawType="shape",
            shapeType = "rectangle", 
            fillType = "fill", 
        });
        local e_hero = hero:new({
            c_position,
            c_size,
            c_direction,
            c_speed,
            c_wasdmove,
            c_shaperender,      
            c_moveselect,
        });
        cameramgr:getInstance():SetFollowPlayer(e_hero);
    end)
end