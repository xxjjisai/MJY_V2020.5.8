_G.welcomescene = class('welcomescene',basescene)

function welcomescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "标准空工程", 
                                                        sVersion = "V2020.5.8", color = g_color.WHITE});
    
        local e_gametitle = gametitle:new({c_title});
    
        local s_welcomesystem = welcomesystem:new();

        self:initCamera();
    
        local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
        btn_enter:SetPositionCenter(0,130);
        btn_enter:SetText("开始");
        btn_enter:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("gamescene");
        end)
    
        local btn_setting = uimgr:getInstance():create("shapebutton","btn_setting");
        btn_setting:SetPositionCenter(0,130 + 55);
        btn_setting:SetText("设置");
        btn_setting:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("setscene");
        end)
    end)
end