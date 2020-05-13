_G.mainscene = class('mainscene',basescene)

function mainscene:onEnterScene()
    self:trace(1,"====================== 333 ")
    scenemgr:getInstance():switchScene("welcomescene");
end