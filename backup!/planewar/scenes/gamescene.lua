_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "游戏", 
                                                        sVersion = "V2020.5.8", color = g_color.SECURITY});

        local e_gametitle = gametitle:new({c_title});
        local s_welceomsystem = welceomsystem:new();
        -------------------------------------------------------------------------------------------------

        local e_myplane = myplane:new({
            position:new({ x = W / 2 - 128/2, y = H - 128 - 30 });
            size:new({ w = 128, h = 128 });
            animaterender:new({ order = 1, color = g_color.WHITE, nStartFrame = 1, nEndFrame = 1, bStartPlay = true, sImg = "myplane", nQuadW = 128, nQuadH = 128, nTotalFrame= 1, nLoop = 1, nTotalPlayCount = 0, nTimeAfterPlay = 0.15,});
            direction:new({ x = 0, y = 0 });
            speed:new({speed = 150 }); 
            ctoldir:new({});
            planefire:new({});
            randomtime:new({ nProgNum = 9, nJianGe = 30 });
        });

        for i = 1, 100 do 
            local e_enemy = enemy:new({
                position:new({ x = math.random(0,W - 64), y = math.random(-64,-700) });
                size:new({ w = 64, h = 64 });
                animaterender:new({ order = 1, color = g_color.WHITE, nStartFrame = 1, nEndFrame = 1, bStartPlay = true, sImg = "enemy", nQuadW = 64, nQuadH = 64, nTotalFrame= 1, nLoop = 1, nTotalPlayCount = 0, nTimeAfterPlay = 0.15,});
                direction:new({ x = 0, y = 1 });
                speed:new({speed = math.random(100,300) }); 
                resetposition:new({resetDir ='v' }); 
            });
        end

        local s_animationsystem = animationsystem:new();
        local s_moveshapesystem = moveshapesystem:new();
        local s_resetpositionsystem = resetpositionsystem:new();
        local s_ctoldirsystem = ctoldirsystem:new();
        local s_planefiresystem = planefiresystem:new();

        scenemgr:getInstance():startupSystem(0.1,function ()
            s_animationsystem:startup();
            s_moveshapesystem:startup();
            s_resetpositionsystem:startup();
            s_ctoldirsystem:startup();
            s_planefiresystem:startup();
        end)
    end)
end