moveselectsystem = class("moveselectsystem", system);

function moveselectsystem:getRequestComponents()
    return {'position','size','moveselect'};
end

function moveselectsystem:onEnterScene()
    self.nMSX = nil;
    self.nMSY = nil;
    self.distanceW = nil;
    self.distanceH = nil;
    self.tbEntList = {};
end

function moveselectsystem:onExitScene()
    self.nMSX = nil;
    self.nMSY = nil;
    self.distanceW = nil;
    self.distanceH = nil;
    self.tbEntList = nil;
end

function moveselectsystem:onUpdate(dt)
    local mx,my = cameramgr:getInstance():GetMousePosition();
    local bDown = love.mouse.isDown( 1 );
    -- local bDown2 = love.mouse.isDown( 2 );
    if bDown then 
        if self.nMSX == nil and self.nMSY == nil then 
            self.nMSX = mx;
            self.nMSY = my;
        end 
        self.distanceW = Dist(self.nMSX,0,mx,0);
        self.distanceH = Dist(0,self.nMSY,0,my);
        if self.nMSX - mx > 0 then self.distanceW = self.distanceW * -1; end
        if self.nMSY - my > 0 then self.distanceH = self.distanceH * -1; end
        -- for i,iTargetEnt in ipairs(self:getTargets()) do 
        --     -- local c_position = iTargetEnt:getComponent("position");
        --     -- local ex = c_position:getAttribute("x");
        --     -- local ey = c_position:getAttribute("y");
        --     -- local c_size = iTargetEnt:getComponent("size");
        --     -- local ew = c_size:getAttribute("w");
        --     -- local eh = c_size:getAttribute("h");
        -- end
    else 
        if self.nMSX ~= nil and self.nMSY ~= nil then 
            -- if not bDown2 then 
            --     baseevent:getInstance():doEvent(self,'EvtSelectAreInfo',self.nMSX,self.nMSY,self.distanceW,self.distanceH);
            -- end 
            self:doEvent('EvtSelectAreInfo',self.nMSX,self.nMSY,self.distanceW,self.distanceH);
            for _,eid in ipairs(self.tbEntList) do 
                baseworld:getInstance():getEntity(eid):removeComponent("shaperender");
            end
            self.tbEntList = {};
            local nSelectCount = 0;
            for i,iTargetEnt in ipairs(self:getTargets()) do 
                local c_position = iTargetEnt:getComponent("position");
                local ex = c_position:getAttribute("x");
                local ey = c_position:getAttribute("y");
                local c_size = iTargetEnt:getComponent("size");
                local ew = c_size:getAttribute("w");
                local eh = c_size:getAttribute("h");
                local dx = self.nMSX;
                local dy = self.nMSY;
                local dw = self.distanceW;
                local dh = self.distanceH;
                local tbp1 = { x = dx, y = dy, w = dw, h = dh };
                local tbp2 = { x = ex, y = ey, w = ew, h = eh };
                if hitTestObject(tbp1,tbp2) then 
                    nSelectCount = nSelectCount + 1;
                    table.insert(self.tbEntList,iTargetEnt.id);
                    local c_shaperender_1 = shaperender:new({
                        order = 1, 
                        color = { math.random(), math.random(), math.random(),1 }, 
                        drawType="shape",
                        shapeType = "rectangle",
                        fillType = "fill"
                    });
                    iTargetEnt:addComponent(c_shaperender_1);
                end
            end
            -- self:trace(1,table.show(self.tbEntList,"self.tbEntList"))
            -- self:trace(1,"select num: "..nSelectCount);
            self.nMSX = nil;
            self.nMSY = nil;
        end
    end
end

function moveselectsystem:onDraw()
    if self.nMSX and self.nMSY and self.distanceW and self.distanceH then 
        love.graphics.setColor(g_color.BLUE);
        love.graphics.rectangle("line",self.nMSX,self.nMSY,self.distanceW,self.distanceH);
    end
end

function moveselectsystem:getSelectedEntList()
    return self.tbEntList;
end