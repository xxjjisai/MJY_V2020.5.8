_G.welcomescene = class('welcomescene',basescene)

function welcomescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "Demo1", 
                                                        sVersion = "V2020.5.8", color = g_color.WHITE});
    
        local e_gametitle = gametitle:new({c_title});
    
        local s_welceomsystem = welceomsystem:new();

        self:initCamera();
    
        local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
        btn_enter:SetPositionCenter(0,130);
        btn_enter:SetText("开始");
        btn_enter:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("gamescene");
        end)
    
        local btn_help = uimgr:getInstance():create("shapebutton","btn_help");
        btn_help:SetPositionCenter(0,130 + btn_help:GetData("Size", "h") + 5);
        btn_help:SetText("帮助");
        btn_help:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("helpscene");
        end)
    end)
end