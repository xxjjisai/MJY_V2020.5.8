_G.overscene = class('overscene',basescene)

function overscene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "永久死亡", 
                                                        sVersion = "", color = g_color.WHITE});
    
        local e_gametitle = gametitle:new({c_title});
    
        local s_welcomesystem = welcomesystem:new();

        self:initCamera();
    
        local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
        btn_enter:SetPositionCenter(0,130);
        btn_enter:SetData("Size","w",130);
        -- btn_enter:SetData("Size","h",H);
        btn_enter:SetText("重新开始");
        btn_enter:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("welcomescene");
        end)
    end)
end