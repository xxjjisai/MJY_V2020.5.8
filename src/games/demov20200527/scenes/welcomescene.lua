_G.welcomescene = class('welcomescene',basescene)

function welcomescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "demov20200527", 
                                                        sVersion = "V2020.5.8", color = g_color.WHITE});
    
        local e_gametitle = gametitle:new({c_title});
    
        local s_welceomsystem = welceomsystem:new();

        self:initCamera();
        
        local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
        btn_enter:SetPositionCenter(0,130);
        btn_enter:SetText("新存档");
        btn_enter:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("gamescene");
        end)
        
        local btn_archives = uimgr:getInstance():create("shapebutton","btn_archives");
        btn_archives:SetPositionCenter(0,130 + 60);
        btn_archives:SetText("旧存档");
        btn_archives:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("archivesscene");
        end)

    end)
end