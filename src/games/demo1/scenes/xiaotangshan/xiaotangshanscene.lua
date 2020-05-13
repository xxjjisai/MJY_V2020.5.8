_G.xiaotangshanscene = class('xiaotangshanscene',basescene)

function xiaotangshanscene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "小汤山", 
                                                        sVersion = "V2020.5.8", color = g_color.SECURITY});

        local e_gametitle = gametitle:new({c_title});

        local s_welceomsystem = welceomsystem:new();

        local btn_help = uimgr:getInstance():create("shapebutton","btn_help");
        btn_help:SetPositionCenter(0,130);
        btn_help:SetText("欢迎");
        btn_help:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("welcomescene");
        end)
    end)
end