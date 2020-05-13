_G.scenemgr = class('scenemgr',manager)

function scenemgr:create()
    self.sSceneName = "mainscene";
    self.tbSceneList = {};
    self.tbSceneList = self.tbSceneList or {};
    self:createScene("mainscene");
    cameramgr:getInstance():create();
end

function scenemgr:createScene(sSceneName)
    if _G[sSceneName] == nil then 
        self:trace(3,"check scene name",sSceneName);
        return
    end 
    _G[sSceneName]:getInstance():create();
    self.tbSceneList[sSceneName] = sSceneName;
    _G[sSceneName]:getInstance():enterScene();
    self.sSceneName = sSceneName;
end

function scenemgr:update(dt)
    cameramgr:getInstance():update(dt);
    _G[self.sSceneName]:getInstance():update(dt);
end

function scenemgr:draw()
    cameramgr:getInstance():RenderAttach(function ()
        _G[self.sSceneName]:getInstance():draw();
    end);
end

function scenemgr:switchScene(sSceneName)
    if _G[self.sSceneName] then 
        uimgr:getInstance():destory();
        _G[self.sSceneName]:getInstance():exitScene();
    end 
    if not self.tbSceneList[sSceneName] then 
        self:createScene(sSceneName);
        return
    end
    -- todo...场景切换效果
    _G[sSceneName]:getInstance():create();
    -- todo...场景切换效果
    _G[sSceneName]:getInstance():enterScene();
    self.sSceneName = sSceneName;
end

