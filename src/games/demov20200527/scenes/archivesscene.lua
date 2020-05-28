_G.archivesscene = class('archivesscene',basescene)

function archivesscene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "存档选择",
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});
            local e_gametitle = gametitle:new({c_title});
            local s_welceomsystem = welceomsystem:new();
        end
        -------------------------------------------------------------------------------------------------

        local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
        btn_enter:SetPositionCenter(100,250);
        btn_enter:SetText("开始");
        btn_enter:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("gamescene");
        end)

        local btn_fanhui = uimgr:getInstance():create("shapebutton","btn_fanhui");
        btn_fanhui:SetPositionCenter(-100,250);
        btn_fanhui:SetText("返回");
        btn_fanhui:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("welcomescene");
        end)

    end)
end