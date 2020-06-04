_G.shootfiresystem = class("shootfiresystem", system);

function shootfiresystem:getRequestComponents()
    return {'position','shootfire'};
end

function shootfiresystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        self:ShootHandler(iTargetEnt);
    end
end

function shootfiresystem:ShootHandler(iTargetEnt)
    local c_position = iTargetEnt:getComponent("position");
    local c_shootfire = iTargetEnt:getComponent("shootfire");
    local nProgNum = c_shootfire:getAttribute('nProgNum');
    local nJianGe = c_shootfire:getAttribute('nJianGe');
    nProgNum = nProgNum + 1
    c_shootfire:addAttribute('nProgNum',nProgNum + 1);
    if nProgNum%nJianGe ~= 0 then
        return;
    end
    if love.mouse.isDown(1) then 
        local mx,my = cameramgr:getInstance():GetMousePosition();
        local ox = c_position:getAttribute("x") + 16;
        local oy = c_position:getAttribute("y") + 16;
        local n_firetheta,_ = Angle('x',ox,oy,mx,my);
        tbPos = { -0.2,-0.1,0,0.1,0.2 } -- 五弹
        tbPos = { -0.1,0,0.1 } -- 三弹
        -- tbPos = { 0 }
        for i = 1, 3 do 
            self:CreateBullet(ox,oy,n_firetheta + tbPos[i]);
        end 
    end
end

function shootfiresystem:CreateBullet(x,y,fireAngle)
    local c_bullet_position = position:new({ x = x, y = y });
    local c_bullet_size = size:new({ w = 5, h = 5 });
    local c_bullet_speed = speed:new({ speed = 6 });
    local c_bullet_awaken = awaken:new({nRange = 10,bAwaken = false, tbTargetTypes = {'enemy','item','door','wall'}});
    local c_bullet_bulletsfly = bulletsfly:new({fireAngle = fireAngle, distance = 2000});
    local c_bullet_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
    local c_bullet_shaperender = shaperender:new({ color = g_color.RED, drawType="shape",shapeType = "circle", 
                                                        fillType = "fill" });
    local e_bullet = bullet:new({ 
        c_bullet_position,
        c_bullet_size,
        c_bullet_shaperender,
        c_bullet_speed,
        c_bullet_sortorder,
        c_bullet_bulletsfly,
        c_bullet_awaken,
        c_bullet_shootfire, 
    });
end