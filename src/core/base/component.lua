_G.component = class('component',baseclass)

function component:init(tbData)
    self.tbData = tbData or {};
    baseclass:init();
end

function component:addAttribute(sKey,nValue)
    self.tbData[sKey] = nValue;
end

function component:getAttribute(sKey)
    return self.tbData[sKey];
end