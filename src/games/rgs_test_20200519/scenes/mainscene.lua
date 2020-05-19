_G.mainscene = class('mainscene',basescene)

function mainscene:onEnterScene()
    scenemgr:getInstance():switchScene("welcomescene");
end