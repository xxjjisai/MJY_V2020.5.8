_G.cameramgr = class("cameramgr",manager)

function cameramgr:create()
    self.iFollowPlayer = nil;
end

function cameramgr:SetCameraStyle(Camera_Follow_Lerp,Camera_Follow_Style,scale)
    camera:setFollowLerp(Camera_Follow_Lerp);
    camera:setFollowStyle(Camera_Follow_Style);
    camera.scale = scale or 1;
end

function cameramgr:SetFollowPlayer(iTargetEnt)
    self.iFollowPlayer = iTargetEnt;
end

function cameramgr:update(dt)
    -- 移动镜头 鼠标方式
    -- if option.bCamera_MouseMove then 
    --     if option.bMouse_Move then 
    --         local mx,my = cameramgr:getInstance():GetMousePosition();
    --         camera:follow(mx, my); 
    --     end
    -- end
    -- 移动镜头 键盘方式
    local keyi = love.keyboard.isDown("lshift");
    if keyi then 
        local mx,my = cameramgr:GetMousePosition();
        camera:follow(mx, my); 
    end
    -- 缩小镜头 
    local keyi = love.keyboard.isDown("]");
    if keyi then 
        if camera.scale <= 0.1 then return end;
        camera.scale = camera.scale - 0.01; 
    end 
    -- 放大镜头
    local keyu = love.keyboard.isDown("[");
    if keyu then 
        if camera.scale >= 10 then return end;
        camera.scale = camera.scale + 0.01; 
    end
    -- 还原镜头
    local keyu = love.keyboard.isDown("o");
    if keyu then  
        camera.scale = g_project.CUR_PROJECT_CAMERA_SCALE;
    end 
    camera:update(dt);
    self:Follow();
end 

function cameramgr:TweenScale(nTime,nScale,pfn)
    timer:tween(nTime, camera, {scale = nScale}, 'in-out-cubic', pfn)
end

function cameramgr:TweenRotate(nTime,nRotate,pfn)
    timer:tween(nTime, camera, {rotation = nRotate * math.pi}, 'in-out-cubic', pfn)
end

function cameramgr:Follow()  
    if not self.iFollowPlayer then return end;
    local iTargetEnt = self.iFollowPlayer;
    local c_position = iTargetEnt:getComponent("position");
    local c_size = iTargetEnt:getComponent("size");
    if c_position and c_size then
        local x = c_position:getAttribute("x");
        local y = c_position:getAttribute("y");
        local w = c_size:getAttribute("w");
        local h = c_size:getAttribute("h");
        local tx,ty = x + w * 0.5, y + h * 0.5;
        camera:follow(tx,ty);
    end
    -- local c_speed = iTargetEnt:getComponent("speed");
    -- if c_speed then 
    --     local keyi = love.keyboard.isDown("lshift");
    --     if keyi then 
    --         c_speed:addAttribute('speed', 500);     
    --     else 
    --         c_speed:addAttribute('speed', 100);    
    --     end
    -- end
end 

function cameramgr:Attach()
    camera:attach()
end 

function cameramgr:Detach()
    camera:detach() 
    camera:draw()
end 

function cameramgr:RenderAttach(pfn)
    self:Attach();
    if pfn then 
        pfn();
    end 
    self:Detach();
end 

function cameramgr:Shake(nDouFU,nDuration, nHz)
    camera:shake(nDouFU or 8,nDuration or 1, nHz or 60)
end 

function cameramgr:Fade(nDuration,r,g,b,a,pfn)
    camera:fade(nDuration, {r,g,b,a},pfn)
end 

function cameramgr:Flash(nDuration,r,g,b,a)
    camera:flash(nDuration, {r,g,b,a})
end  

function cameramgr:GetMousePosition()
    return camera:getMousePosition();
end

function cameramgr:SetDeadzone(x, y, w, h)
    return camera:setDeadzone(x, y, w, h);
end