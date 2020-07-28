_G.welcomescene = class('welcomescene',basescene)

function welcomescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "僵局", 
                                                        sVersion = "V2020.5.8", color = g_color.WHITE});
    
        local e_gametitle = actor:new({c_title});
    
        local s_welcomesystem = welcomesystem:new();

        self:initCamera();
    
        local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
        btn_enter:SetPositionCenter(0,130);
        btn_enter:SetText("开始");
        btn_enter:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("gamescene");
        end)
    
        local btn_settings = uimgr:getInstance():create("shapebutton","btn_settings");
        btn_settings:SetPositionCenter(0,190);
        btn_settings:SetText("选项");
        btn_settings:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("settingscene");
        end)
    end)
end