_G.scenemgr = class('scenemgr',manager)

function scenemgr:create()
    self.sSceneName = g_project.CUR_PROJECT_MAINSCENE;
    self.tbSceneList = {};
    self.tbSceneList = self.tbSceneList or {};
    self:createScene(g_project.CUR_PROJECT_MAINSCENE);
    cameramgr:getInstance():create();
end

function scenemgr:createScene(sSceneName,...)
    if _G[sSceneName] == nil then 
        self:trace(3,"check scene name",sSceneName);
        return
    end 
    self.tbSceneList[sSceneName] = sSceneName;
    _G[sSceneName]:getInstance():create();
    _G[sSceneName]:getInstance():enterScene(...);
    self.sSceneName = sSceneName;
end

function scenemgr:update(dt)
    cameramgr:getInstance():update(dt);
    _G[self.sSceneName]:getInstance():update(dt);
end

function scenemgr:draw()
    cameramgr:getInstance():RenderAttach(function ()
        if g_option.DEBUG >= 3 then 
            bump_debug.draw(BumpWorld);
        end
        _G[self.sSceneName]:getInstance():draw();
    end);
end

function scenemgr:switchScene(sSceneName,...)
    if _G[self.sSceneName] then 
        uimgr:getInstance():destory();
        _G[self.sSceneName]:getInstance():exitScene();
    end 
    if not self.tbSceneList[sSceneName] then 
        self:createScene(sSceneName,...);
        return
    end
    _G[sSceneName]:getInstance():create();
    _G[sSceneName]:getInstance():enterScene(...);
    self.sSceneName = sSceneName;
end

function scenemgr:transitionScene(pfn)
    local nTime = g_project.CUR_PROJECT_SCENE_TRANSITION_TIME;
    local pfn = pfn;
    cameramgr:getInstance():Fade(nTime,0,0,0,1,function ()
        if pfn then 
            pfn();
            baseworld:getInstance():enterScene();
        end
        cameramgr:getInstance():Fade(nTime,0,0,0,0);
    end);
end

function scenemgr:startupSystem(sTime,pfn)
    local nTime = g_project.CUR_PROJECT_SCENE_TRANSITION_TIME;
    local pfn = pfn;
    local sTime = sTime or 0.1;
    timer:after(sTime,function ()
        if pfn then 
            pfn();
        end 
    end)
end
