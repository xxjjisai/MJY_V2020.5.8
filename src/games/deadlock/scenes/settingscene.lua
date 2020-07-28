_G.settingscene = class('settingscene',basescene)

function settingscene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "选项", 
                                                        sVersion = "V2020.5.8", color = g_color.SECURITY});
    
        local e_gametitle = actor:new({c_title});
    
        local s_welcomesystem = welcomesystem:new();

        self:initCamera();
    
        local btn_back = uimgr:getInstance():create("shapebutton","btn_back");
        btn_back:SetPosition( 10, H - 60);
        btn_back:SetText("返回");
        btn_back:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("welcomescene");
        end)
    
        local btn_exe = uimgr:getInstance():create("shapebutton","btn_exe");
        btn_exe:SetPosition( W - 90 - 10, H - 60);
        btn_exe:SetText("生效");
        btn_exe:SetData("Oper", "onClick", function ()

        end)
    end)
end