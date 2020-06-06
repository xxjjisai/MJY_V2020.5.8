_G.enemyshootsystem = class("enemyshootsystem", system);

function enemyshootsystem:getRequestComponents()
    return {'position','enemyshoot'};
end

-- function enemyshootsystem:onUpdate(dt)
--     for i,iTargetEnt in ipairs(self:getTargets()) do 
--         self:ShootHandler(iTargetEnt);
--     end
-- end

function enemyshootsystem:onEnterScene()
    baseevent:getInstance():addEvent(baseworld:getInstance():getSystem('awakensystem'),self);
end 

function enemyshootsystem:onExitScene()
    baseevent:getInstance():removeEvent(self,baseworld:getInstance():getSystem('awakensystem'));
end 

function enemyshootsystem:EvtCollisionHandler(nColliderID,sColliderType,tbCollisionList)
    if sColliderType == "enemy" then 
        local iEnemy = baseworld:getInstance():getEntity(nColliderID);
        local c_enemyshoot = iEnemy:getComponent('enemyshoot');
        local c_awaken = iEnemy:getComponent('awaken');
        local nProgNum = c_enemyshoot:getAttribute('nProgNum');
        local nJianGe = c_enemyshoot:getAttribute('nJianGe');
        nProgNum = nProgNum + 1
        c_enemyshoot:addAttribute('nProgNum',nProgNum + 1);
        if nProgNum%nJianGe ~= 0 then
            return;
        end
        CheckInTargets = function (tbTargetTypes,tTmpType)
            for _,sType in ipairs(tbTargetTypes) do 
                if sType == tTmpType then 
                    return true
                end 
            end     
            return false;
        end
        for i,v in ipairs(tbCollisionList) do 
            local tbTargetTypes = c_awaken:getAttribute("tbTargetTypes");
            if CheckInTargets(tbTargetTypes,v.sType) then 
                local iHero = baseworld:getInstance():getEntity(v.id);
                local hx = iHero:getComponent('position'):getAttribute('x') + 16;
                local hy = iHero:getComponent('position'):getAttribute('y') + 16;
                local ox = iEnemy:getComponent('position'):getAttribute('x') + 16;
                local oy = iEnemy:getComponent('position'):getAttribute('y') + 16;
                local n_firetheta,_ = Angle('x',ox,oy,hx,hy);
                local tbPos = { -0.1,0,0.1 };
                for i = 1, 3 do 
                    self:CreateBullet(ox,oy,n_firetheta + tbPos[i],iEnemy.id);
                end 
            end
        end
    end
end 

function enemyshootsystem:CreateBullet(x,y,fireAngle,id)
    local c_bullet_position = position:new({ x = x, y = y });
    local c_bullet_size = size:new({ w = 5, h = 5 });
    local c_bullet_speed = speed:new({ speed = 5 });
    local c_bullet_awaken = awaken:new({nRange = 10,bAwaken = false, bOffset = true,tbTargetTypes = {'hero'}});
    local c_bullet_bulletsfly = bulletsfly:new({shooterID = id,fireAngle = fireAngle, distance = math.random(400,405)});
    local c_bullet_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
    local c_bullet_shaperender = shaperender:new({ color = g_color.PURPLE, drawType="shape",shapeType = "circle", 
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