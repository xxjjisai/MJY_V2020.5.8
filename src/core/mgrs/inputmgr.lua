_G.inputmgr = class('inputmgr',manager)

function inputmgr:mousepressed(x,y,button)
    uimgr:getInstance():mousepressed(x,y,button)
    if not uimgr:getInstance():IsBubbling() then 
        baseworld:getInstance():mousepressed(x,y,button)
    end
end

function inputmgr:keypressed(key)
    uimgr:getInstance():keypressed(key)
    baseworld:getInstance():keypressed(key)
    if key == 'escape' then 
        love.event.quit();
    end 
    if key == 'x' then 
        g_option.DEBUG = 0;
    end 
    if key == 'C' then 
        g_option.DEBUG = 2;
    end 
end