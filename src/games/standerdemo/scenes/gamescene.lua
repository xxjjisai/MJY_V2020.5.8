_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "游戏", 
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});

            local e_gametitle = actor:new({c_title});
            local s_welcomesystem = welcomesystem:new();
        end

        local s_drawshapesystem = drawshapesystem:new();
        local s_wasdmovesystem = wasdmovesystem:new();
        local s_bumprectsystem = bumprectsystem:new();

        scenemgr:getInstance():startupSystem(0.1,function ()
            s_drawshapesystem:startup();
            s_wasdmovesystem:startup();
            s_bumprectsystem:startup();
        end)

        local c_position = position:new({ x = W/2 - 128/2, y = H/2 - 128/2 });
        local c_size = size:new({ w = 128, h = 128 });
        local c_direction = direction:new({x = 1,y=1});
        local c_speed = speed:new({speed=450}); 
        local c_wasdmove = wasdmove:new();
        local c_heroopr = heroopr:new(); 
        local c_bumprect = bumprect:new();
        local e_follow_camera = actor:new({c_position,c_size,c_direction,c_speed,c_wasdmove,c_heroopr,c_bumprect});
        cameramgr:getInstance():SetFollowPlayer(e_follow_camera);

    end)
end