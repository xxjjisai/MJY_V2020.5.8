_G.uimgr = class('uimgr',manager)

function uimgr:create(sUIType,sUIName)
    local ui = _G[sUIType]:new();
    self.tbUIList = self.tbUIList or {};
    self.tbUIList[sUIName] = ui;
    self.bBubbling = false;
    ui:create();
    return ui;
end

function uimgr:remove(ui)
    if self.tbUIList == nil then 
        return 
    end 
    local tmp_sName = ""
    for sName,iUI in pairs(self.tbUIList) do 
        if iUI.id == ui.id then 
            tmp_sName = sName;
            break;
        end 
    end
    self.tbUIList[tmp_sName] = nil;
    return;
end

function uimgr:getByName(sNamex)
    if self.tbUIList == nil then 
        return 
    end 
    local tmp_ui = nil;
    for sName,iUI in pairs(self.tbUIList) do 
        if sName == sNamex then 
            tmp_ui = iUI;
            break;
        end 
    end
    return tmp_ui;
end

function uimgr:getByID(id)
    if self.tbUIList == nil then 
        return 
    end 
    local tmp_ui = nil;
    for sName,iUI in pairs(self.tbUIList) do 
        if iUI.id == ui.id then 
            tmp_ui = iUI;
            break;
        end 
    end
    return tmp_ui;
end

function uimgr:destory()
    if self.tbUIList == nil then 
        return 
    end 
    for _,iUI in pairs(self.tbUIList) do 
        -- iUI:Destory();
        iUI = nil;
    end
    self.tbUIList = nil;
end

function uimgr:draw()
    if self.tbUIList == nil then 
        return 
    end 
    for _,iUI in pairs(self.tbUIList) do 
        if iUI then 
            if iUI.draw then 
                if iUI.bVisible then 
                    iUI:draw();
                end
            end 
        end 
    end
end

function uimgr:update(dt)
    if self.tbUIList == nil then 
        return 
    end 
    for sName,iUI in pairs(self.tbUIList) do 
        if iUI then 
            if iUI.update then 
                iUI:update(dt);
            end 
        end 
    end
end

function uimgr:mousepressed(x,y,button)
    if self.tbUIList == nil then 
        return 
    end 
    for _,iUI in pairs(self.tbUIList) do 
        if iUI then 
            if iUI.mousepressed then 
                iUI:mousepressed(x,y,button);
            end 
        end
    end
end

function uimgr:keypressed(key)
    if self.tbUIList == nil then 
        return 
    end 
    for _,iUI in pairs(self.tbUIList) do 
        if iUI and iUI.keypressed then 
            iUI:keypressed(key);
        end 
    end
end

function uimgr:SetInputFocus(sFocusid)
    self.sFocusid = sFocusid;
end

function uimgr:IsBubbling()
    if self.tbUIList == nil then 
        return 
    end 
    for sName,iUI in pairs(self.tbUIList) do 
        if iUI.bBubbling then 
            return true;
        end 
    end
    return false;
end