_G.setscene = class('setscene',basescene)

function setscene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "设置", 
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});

            local e_gametitle = gametitle:new({c_title});
            local s_welcomesystem = welcomesystem:new();
        end
        -------------------------------------------------------------------------------------------------

        local ipt_fenbianlv = uimgr:getInstance():create("shapetextinput","ipt_fenbianlv");
        ipt_fenbianlv:SetPositionCenter(0,-200);
        ipt_fenbianlv:SetText("分辨率");
        ipt_fenbianlv:SetStyle(1);

        local ipt_sounds = uimgr:getInstance():create("shapetextinput","ipt_sounds");
        ipt_sounds:SetPositionCenter(0,-150);
        ipt_sounds:SetText("声音");
        ipt_sounds:SetStyle(2);
        
        -- local ipt_sounds = uimgr:getInstance():create("shapetextinput","ipt_sounds");
        -- ipt_sounds:SetPositionCenter(-150,-150);
        -- ipt_sounds:SetText("声音");

        -- local ipt_text = uimgr:getInstance():create("shapetextinput","ipt_text");
        -- ipt_text:SetPositionCenter(-50,-200);
        -- ipt_text:SetText("分辨率");

        -- local ipt_text = uimgr:getInstance():create("shapetextinput","ipt_text");
        -- ipt_text:SetPositionCenter(-0,-200);
        -- ipt_text:SetText("分辨率");

        local btn_cancel = uimgr:getInstance():create("shapebutton","btn_cancel");
        btn_cancel:SetPositionCenter(-150,150 + 55);
        btn_cancel:SetText("取消");
        btn_cancel:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("welcomescene");
        end)
        local btn_sure = uimgr:getInstance():create("shapebutton","btn_sure");
        btn_sure:SetPositionCenter(150,150 + 55);
        btn_sure:SetText("保存");
        btn_sure:SetData("Oper", "onClick", function ()
            scenemgr:getInstance():switchScene("welcomescene");
        end)
    end)
end