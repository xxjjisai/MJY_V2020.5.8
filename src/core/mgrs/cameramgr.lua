_G.cameramgr = class("cameramgr",manager)

function cameramgr:create()
    self.sFollowPlayer = "Player";
    self.iFollowPlayer = nil;
    self.tbOrigin = {x=0,y=0,scale=1}
end

function cameramgr:SetCameraStyle(Camera_Follow_Lerp,Camera_Follow_Style,scale)
    camera:setFollowLerp(Camera_Follow_Lerp);
    camera:setFollowStyle(Camera_Follow_Style);
    self.tbOrigin.x = camera.screen_x;
    self.tbOrigin.y = camera.screen_y;
    camera.scale = scale or 1;
    self.tbOrigin.scale = camera.scale;
end

function cameramgr:SetFollowPlayer(iTargetEnt)
    self.iFollowPlayer = iTargetEnt;
end

function cameramgr:RestCameraToOrigin()
    camera:follow(self.tbOrigin.x, self.tbOrigin.y); 
end

function cameramgr:update(dt)
    -- 移动镜头 鼠标方式
    -- if option.bCamera_MouseMove then 
    --     if option.bMouse_Move then 
    --         local mx,my = cameramgr:GetMousePosition();
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
        camera.scale = 1;
    end 
    camera:update(dt);
    self:Follow();
end 

function cameramgr:Follow()  
    if not self.iFollowPlayer then return end;
    local iTargetEnt = self.iFollowPlayer;
    local c_position = iTargetEnt:getComponent("position");
    local c_size = iTargetEnt:getComponent("size")
    if c_position and c_size then
        local x = c_position:getAttribute("x");
        local y = c_position:getAttribute("y");
        local w = c_size:getAttribute("w");
        local h = c_size:getAttribute("h");
        local tx,ty = x + w * 0.5, y + h * 0.5;
        camera:follow(tx,ty);
    end
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
    self:Detach()  
    if g_option.DEBUG >= 2 then 
        love.graphics.setColor(1,1,1,1)
        local x = W / 2 - 32 / 2 ;
        local y = H / 2 - 32 / 2 ;
        love.graphics.rectangle("line",x,y,32,32)
    end
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