_G.basescene = class('basescene',baseclass)

function basescene:init()
    baseclass:init();
end

function basescene:getInstance()
    if self.instance == nil then 
        self.instance = self:new();
    end
    return self.instance;
end

function basescene:create()
    baseworld:getInstance():create();
end

function basescene:update(dt)
    baseworld:getInstance():update(dt);
end

function basescene:draw()
    baseworld:getInstance():draw();
end

function basescene:destory()
    baseworld:getInstance():destory();
end

function basescene:enterScene()
    self:onEnterScene();
    baseworld:getInstance():enterScene();
end

function basescene:exitScene()
    self:onExitScene();
    baseworld:getInstance():exitScene();
end

----------------------------------------------

function basescene:onEnterScene()

end

function basescene:onExitScene()

end