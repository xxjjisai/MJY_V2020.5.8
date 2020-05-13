shapebutton = class("shapebutton",baseui)

function shapebutton:create()
    self.id = baseorigin:getInstance():getID();
    self.nLayerIndex = 1;
    local tbCompo = 
    {
        ['Position'] = {x = 100,y = 100};
        ['Size'] = {w = 90,h = 50};
        ['Oper'] = {
            onClick = nil; -- 点击
            onHover = nil; -- 滑入
            bHover = false; -- 是否滑入
            bHoverMove = false; -- 是否滑入移动
            bShowHover = true; 
        };
        ['Style'] = {
            bBg = true;
            bBorder = false;
            sborderFill = "line",
            sbgFill = "fill",
            nFontSize = 24;
            bgcolor = {0.3,0.3,1,1},
            txtcolor = {1,1,1,1},
            bordercolor = {1,1,1,1},
            bHoverColor = {0.5,0.5,1,1},
            bGreyColor = {0.4,0.4,0.4,1};
            sText = "按钮";
        };
    }
    for i,v in pairs(tbCompo) do 
        self:AddCompo(i,v)
    end
end

function shapebutton:update(dt)
    if not self.bVisible then 
        return 
    end 
    local tbMouse = {
        x = love.mouse.getX(),
        y = love.mouse.getY(),
        w = 1,
        h = 1
    }
    local tbButton = {
        x = self:GetData("Position","x"),
        y = self:GetData("Position","y"),
        w = self:GetData("Size","w"),
        h = self:GetData("Size","h")
    }
    if hitTestObject(tbMouse,tbButton) then 
        self:SetData("Oper","bHover",true); 
        if self:GetData("Oper","onHover") then  
           if not self:GetData("Oper","bHoverMove") then  
              self:GetData("Oper","onHover")();
              self:SetData("Oper","bHoverMove",true);
           end
        end
    else
        self:SetData("Oper","bHover",false);
        self:SetData("Oper","bHoverMove",false);
    end 
end

function shapebutton:draw()
    if not self.bVisible then 
        return 
    end
    love.graphics.setColor(1,1,1,1);
    local bgcolor = self:GetData("Style","bgcolor");
    local txtcolor = self:GetData("Style","txtcolor");
    local bordercolor = self:GetData("Style","bordercolor");
    if self.bGrey then 
        local bGreyColor = self:GetData("Style","bGreyColor");
        bgcolor = {bGreyColor[1],bGreyColor[2],bGreyColor[3],bgcolor[4]};
    end
    if self:GetData("Oper","bShowHover") then 
        if self:GetData("Oper","bHover") then 
            local hovercolor = self:GetData("Style","bHoverColor");
            bgcolor = {hovercolor[1],hovercolor[2],hovercolor[3],bgcolor[4]};
        end
    end
    if self:GetData("Style","bBg") then 
        love.graphics.setColor(bgcolor);
        love.graphics.rectangle(self:GetData("Style","sbgFill"),
                self:GetData("Position","x"),self:GetData("Position","y"),
                self:GetData("Size","w"),self:GetData("Size","h"))
        if self:GetData("Style","bBorder") then 
            if self.bGrey then 
                love.graphics.setColor(bGreyColor);
            else
                love.graphics.setColor(bordercolor);
            end
            love.graphics.rectangle(self:GetData("Style",sborderFill),
                self:GetData("Position","x"),self:GetData("Position","y"),
                self:GetData("Size","w"),self:GetData("Size","h"))
        end
    end
    love.graphics.setColor(txtcolor);
    local font = resmgr:GetFont(self:GetData("Style","nFontSize"));
    love.graphics.setFont(font);
    local nFontx = ((self:GetData("Position","x") + self:GetData("Size","w")*0.5)) - font:getWidth(self:GetData("Style","sText"))*0.5;
    local nFonty = ((self:GetData("Position","y") + self:GetData("Size","h")*0.5)) - font:getHeight(self:GetData("Style","sText"))*0.5;
    love.graphics.print(self:GetData("Style","sText"),nFontx,nFonty)
    love.graphics.setColor(1,1,1,1);

    -- love.graphics.setStencilTest()
end

function shapebutton:mousepressed(x,y,button)
    if not self.bVisible then 
        return 
    end 
    local tbMouse = {
        x = x,
        y = y,
        w = 1,
        h = 1
    }
    local tbButton = {
        x = self:GetData("Position","x"),
        y = self:GetData("Position","y"),
        w = self:GetData("Size","w"),
        h = self:GetData("Size","h")
    }

    if hitTestObject(tbMouse,tbButton) then 
        if self:GetData("Oper","onClick") then 
            self:GetData("Oper","onClick")();
            return
        end
    end 
end