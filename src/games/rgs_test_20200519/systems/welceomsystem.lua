_G.welceomsystem = class("welceomsystem", system);

function welceomsystem:getRequestComponents()
    return {'title'};
end

function welceomsystem:onDraw()
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_title = iTargetEnt:getComponent("title");
        local color = c_title:getAttribute("color");
        local sTitleName = c_title:getAttribute("sTitleName");
        local sVersion = c_title:getAttribute("sVersion");
        local nTitleNameFontSize = c_title:getAttribute("nTitleNameFontSize");
        local nVersionFontSize = c_title:getAttribute("nVersionFontSize");
        love.graphics.setColor(color);
        love.graphics.setFont(resmgr:GetFont(nTitleNameFontSize));
        love.graphics.print(sTitleName, (windows.w*0.5) - resmgr:GetFont(nTitleNameFontSize):getWidth(sTitleName)*0.5,
        (windows.h*0.5) - resmgr:GetFont(nTitleNameFontSize):getHeight(sTitleName)*0.5);
        love.graphics.setFont(resmgr:GetFont(nVersionFontSize)); 
        love.graphics.print(sVersion, 10, windows.h - resmgr:GetFont(nVersionFontSize):getHeight(sVersion) - 10);
    end 
end