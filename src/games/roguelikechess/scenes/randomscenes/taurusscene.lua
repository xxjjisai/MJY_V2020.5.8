-- 金牛座 Taurus
_G.taurusscene = class('taurusscene',basescene)

function taurusscene:onEnterScene()
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "金牛座", 
                                                            sVersion = "V2020.6.16", color = g_color.SECURITY});

            local e_gametitle = gametitle:new({c_title});
            local s_welcomesystem = welcomesystem:new();
        end
        -------------------------------------------------------------------------------------------------

        

    end)
end