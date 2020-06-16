_G.welcomescene = class('welcomescene',basescene)

function welcomescene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "RPG编辑器", 
                                                        sVersion = "V2020.5.8", color = g_color.WHITE});
    
        local e_gametitle = gametitle:new({c_title});
    
        local s_welcomesystem = welcomesystem:new();

        self:initCamera();
    
        local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
        btn_enter:SetPositionCenter(0,130);
        btn_enter:SetText("新建");
        btn_enter:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("gamescene");
        end)
    
        local btn_read = uimgr:getInstance():create("shapebutton","btn_read");
        btn_read:SetPositionCenter(0,190);
        btn_read:SetText("读取");
        btn_read:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("gamescene",true);
        end)
    end)
end