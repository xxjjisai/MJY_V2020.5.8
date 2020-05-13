baseui = class("baseui",baseclass)

function baseui:init()
    self.id = baseorigin:getInstance():getID();
    self.compos = {};
    self.bVisible = true;
    self.nLayerIndex = 1;
end

function baseui:create()
    -- 装载组件等
    self:trace(2,"UI not create yet !!!")
end

function baseui:AddCompo(sCompo,compo)
    self.compos[sCompo] = compo;
end

function baseui:RemoveCompo(sCompo)
    self.compos[sCompo] = nil;
end

function baseui:GetCompo(sCompo)
    return self.compos[sCompo];
end

function baseui:Destory()
    for sCompo,_ in pairs(self.compos) do 
        self:RemoveCompo(sCompo);
    end 
    self.compos = nil;
end

function baseui:GetData(sCompo,sKey)
    return self:GetCompo(sCompo)[sKey]
end

function baseui:SetData(sCompo,sKey,nValue)
    self:GetCompo(sCompo)[sKey] = nValue
end

function baseui:SetPositionCenter(ox,oy)
    local ox = ox or 0;
    local oy = oy or 0;
    self:SetData('Position', "x", W / 2 - self:GetData("Size", "w") / 2 + ox);
    self:SetData('Position', "y", H / 2 - self:GetData("Size", "h") / 2 + oy );
end

function baseui:SetText(sText)
    local sText = sText or "文字";
    self:SetData('Style', "sText", sText );
end