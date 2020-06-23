shapetextinput = class("shapetextinput",baseui)

function shapetextinput:create()
    self.id = baseorigin:getInstance():getID();
    self.nLayerIndex = 1;
    local tbCompo = 
    {
        ['Position'] = {x = 100,y = 100};
        ['Size'] = {w = 200,h = 50};
        ['Oper'] = {
            onClick = nil; -- 点击
            onHover = nil; -- 滑入
            bHover = false; -- 是否滑入
            bHoverMove = false; -- 是否滑入移动
            bShowHover = true; 
            bNumber = false; -- 是否限制只输入数字 
            bInput = true; -- 是否能够输入
        };
        ['Style'] = {
            bBg = true;
            bBorder = false;
            sborderFill = "line";
            sbgFill = "fill";
            nFontSize = 24;
            bgcolor = {1,1,1,0};
            txtcolor = g_color.WHITE;
            bordercolor = {1,1,1,0};
            bHoverColor = {0.9,0.9,0.9,0};
            sText = "11111";
        };
    }
    for i,v in pairs(tbCompo) do 
        self:AddCompo(i,v)
    end
    self:OpenRepeat(true);
    uimgr:getInstance():SetInputFocus(self.id);
end

function shapetextinput:OpenRepeat(bRepeat)
    love.keyboard.setKeyRepeat(bRepeat);
end

function shapetextinput:update(dt)
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
 
function shapetextinput:draw()
    if not self.bVisible then 
        return 
    end 
    love.graphics.setColor(1,1,1,1);
    local bgcolor = self:GetData("Style","bgcolor"); 
    local txtcolor = self:GetData("Style","txtcolor");
    local bordercolor = self:GetData("Style","bordercolor");
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
            love.graphics.setColor(bordercolor);
            love.graphics.rectangle(self:GetData("Style","sborderFill"),
                self:GetData("Position","x"),self:GetData("Position","y"),
                self:GetData("Size","w"),self:GetData("Size","h"))
        end
    end
    love.graphics.setColor(txtcolor);
    local font = resmgr:GetFont(self:GetData("Style","nFontSize"));
    love.graphics.setFont(font);
    local nFontx = ((self:GetData("Position","x") + self:GetData("Size","w")*0.5) ) - font:getWidth(self:GetData("Style","sText"))*0.5;
    local nFonty = ((self:GetData("Position","y") + self:GetData("Size","h")*0.5) ) - font:getHeight(self:GetData("Style","sText"))*0.5;
    love.graphics.print(self:GetData("Style","sText"),nFontx,nFonty);
    love.graphics.setColor(1,1,1,1);
end

function shapetextinput:textinput(text)
    if not self.bVisible then 
        return 
    end
    if not self:GetData("Oper","bInput") then
        return
    end
    if self:GetData("Oper","bNumber") then
       text = tonumber(text);
       if not text then return end
    end
    if uimgr:GetInputFocus() ~= self.id then 
       return
    end
    local font = resmgr:GetFont(self:GetData("Style","nFontSize"));
    if font:getWidth(self:GetData("Style","sText")) >= (self:GetData("Size","w")-20) then 
       return;
    end
    self:SetData("Style","sText",self:GetData("Style","sText")..text);
 end

 function shapetextinput:keyreleased(act,key)
    if not self.bVisible then 
        return 
    end
    if not self:GetData("Oper","bInput") then
        return
    end
    if key == "backspace" then
       if uimgr:GetInputFocus() ~= self.id then 
          return 
       end
       local byteoffset = utf8.offset(self:GetData("Style","sText"), -1);
       if byteoffset then
          local text = string.sub(self:GetData("Style","sText"), 1, byteoffset - 1);
          self:SetData("Style","sText",text);
       end
    end
end

function shapetextinput:mousepressed(actors,x,y,button)
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
       uimgr:getInstance():SetInputFocus(self.id);
       if self:GetData("Oper","onClick") then 
            self:GetData("Oper","onClick")();
            return
        end
    end 
 end