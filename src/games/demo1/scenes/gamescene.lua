_G.gamescene = class('gamescene',basescene)

function gamescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "游戏", 
                                                        sVersion = "V2020.5.8", color = g_color.SECURITY});

        local e_gametitle = gametitle:new({c_title});

        local s_welceomsystem = welceomsystem:new();

        -------------------------------------------------------------------------------------------------

        for i=1,1000 do
            local randomNum = math.random();
            local c_position_1 = position:new({ x = math.random(1,960), y = math.random(1,640) });
            local c_direction_1 = direction:new({ x = 1, y = 1 });
            local c_size_1 = size:new({ w = math.random(10,30), h = math.random(10,30) });
            local c_speed_1 = speed:new({speed = math.random(5,10) });
            local c_sortorder_1 = sortorder:new({nLayerIndex = g_tbLayer.HUMAN});
            local c_animaterender_1 = animaterender:new({
                order = 1, 
                color = g_color.WHITE, 
                nStartFrame = math.random(1, 8), 
                nEndFrame = math.random(8, 16), 
                bStartPlay = true, 
                sImg = "mt_4", 
                nQuadW = 32, 
                nQuadH = 32, 
                nTotalFrame= 1, 
                nLoop = 1, 
                nTotalPlayCount = 0, 
                nTimeAfterPlay = 0.15,
            });
            local c_shaperender_1 = shaperender:new({
                order = 1, 
                color = {math.random(),math.random(),math.random(),1}, 
                drawType="shape",
                shapeType = "rectangle",
                fillType = "line"
            });
            local e_hero1 = hero:new({c_position_1,c_size_1,c_shaperender_1,c_speed_1,c_animaterender_1,c_sortorder_1,c_direction_1});
        end

        -- local s_drawshapesystem = drawshapesystem:new();
        local s_moveshapesystem = moveshapesystem:new();
        local s_animationsystem = animationsystem:new();
        local s_randomdirsystem = randomdirsystem:new();

        -- local btn_help = uimgr:getInstance():create("shapebutton","btn_help");
        -- btn_help:SetPositionCenter(0,130);
        -- btn_help:SetText("小汤山");
        -- btn_help:SetData("Oper", "onClick", function ()
        --     scenemgr:getInstance():switchScene("xiaotangshanscene");
        -- end)

        local btn_startup = uimgr:getInstance():create("shapebutton","btn_startup");
        btn_startup:SetPositionCenter(0,130);
        btn_startup:SetText("启动");
        btn_startup:SetData("Oper", "onClick", function ()
            s_randomdirsystem:startup();
            s_moveshapesystem:startup();
            s_animationsystem:startup();
            uimgr:getInstance():remove(btn_startup);
        end)
    end)
end