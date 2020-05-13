_G.inputmgr = class('inputmgr',manager)

function inputmgr:mousepressed(x,y,button)
    uimgr:getInstance():mousepressed(x,y,button)
end

function inputmgr:keypressed(key)
    uimgr:getInstance():keypressed(key)
end