_G.huoshenshanscene = class('huoshenshanscene',basescene)

function huoshenshanscene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "火神山", 
                                                        sVersion = "V2020.5.8", color = g_color.SECURITY});
        local e_gametitle = gametitle:new({c_title});

        local s_welceomsystem = welceomsystem:new();

        self:initCamera();

        local btn_help = uimgr:getInstance():create("shapebutton","btn_help");
        btn_help:SetPositionCenter(0,130);
        btn_help:SetText("欢迎");
        btn_help:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("welcomescene");
        end)
    end)
end