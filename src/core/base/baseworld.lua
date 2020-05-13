_G.baseworld = class('baseworld',baseclass)

function baseworld:init()
    baseclass:init();
end

function baseworld:create()
    self.tbEntitiesList = {};
    self.tbSystemList = {};
end

function baseworld:getInstance()
    if self.instance == nil then 
        self.instance = self:new();
    end
    return self.instance;
end

function baseworld:addEntity(iEnt)
    local sEntName = iEnt.class.name .. iEnt.id;
    self.tbEntitiesList[sEntName] = iEnt;
end

function baseworld:removeEntity(iEnt)
    for _,tmp_iEnt in pairs(self.tbEntitiesList) do 
        if tmp_iEnt.id == iEnt.id then 
            tmp_iEnt:destory();
            tmp_iEnt = nil;
        end 
    end 
end

function baseworld:registerSystem(iSys)
    self.tbSystemList[iSys.class.name] = iSys;
end

function baseworld:removeSystem(iSys)
    for _,tmp_iSys in pairs(self.tbSystemList) do 
        if tmp_iSys.id == iSys.id then 
            tmp_iSys:destory();
            tmp_iSys = nil;
        end 
    end 
end

function baseworld:getFilterTarget( tbCompoList )
    local tbEntList = {};
    for i,iEnt in pairs(self.tbEntitiesList) do
        local nCount = 0;
        for _,sCompoName in ipairs(tbCompoList) do 
            if iEnt:getComponent(sCompoName) then 
                nCount = nCount + 1;
            end
            if #tbCompoList == nCount then 
                table.insert(tbEntList, iEnt);
            end
        end
    end

    table.sort(tbEntList, function(a,b)
        if a ~= nil and b ~= nil then 
            local a_c_sortorder = a:getComponent("sortorder");
            local b_c_sortorder = b:getComponent("sortorder");
            local a_c_position = a:getComponent("position");
            local b_c_position = b:getComponent("position");
            local a_c_size = a:getComponent("size"); 
            local b_c_size = b:getComponent("size"); 
            if a_c_sortorder and b_c_sortorder and 
            a_c_position and b_c_position and 
            a_c_size and b_c_size then 
                local a_nLayerIndex = a_c_sortorder:getAttribute("nLayerIndex");
                local b_nLayerIndex = b_c_sortorder:getAttribute("nLayerIndex");
                local ay = a_c_position:getAttribute("y") + a_c_size:getAttribute("h");
                local by = b_c_position:getAttribute("y") + b_c_size:getAttribute("h");
                if a_nLayerIndex == g_tbLayer.HUMAN and b_nLayerIndex == g_tbLayer.HUMAN then
                    return ay < by;
                elseif a_nLayerIndex == g_tbLayer.HUMAN_DOWN and b_nLayerIndex == g_tbLayer.HUMAN_DOWN then
                    return ay < by;
                elseif a_nLayerIndex == g_tbLayer.GROUND_UP and b_nLayerIndex == g_tbLayer.GROUND_UP then
                    return ay < by;
                elseif a_nLayerIndex == g_tbLayer.SKY and b_nLayerIndex == g_tbLayer.SKY then
                    return ay < by;
                elseif a_nLayerIndex == g_tbLayer.GROUND and b_nLayerIndex == g_tbLayer.GROUND then
                    return ay < by;
                else 
                    return ay < by;
                end
            end 
        end
    end)

    return tbEntList;
end

function baseworld:update(dt)
    for _,iSys in pairs(self.tbSystemList) do 
        if iSys.update then 
            iSys:update(dt);
        end 
    end 
end

function baseworld:draw()
    for _,iSys in pairs(self.tbSystemList) do 
        if iSys.draw then 
            iSys:draw();
        end 
    end 
end

function baseworld:enterScene()
    for _,iSys in pairs(self.tbSystemList) do 
        if iSys.enterScene then 
            iSys:enterScene();
        end 
    end 
end

function baseworld:exitScene()
    for _,iSys in pairs(self.tbSystemList) do 
        if iSys.exitScene then 
            iSys:exitScene();
        end 
    end 
    self:destory();
end

function baseworld:destory()
    for _,iSys in pairs(self.tbSystemList) do 
        if iSys.destory then 
            iSys:destory();
            iSys = nil;
        end 
    end 
    for _,iEnt in pairs(self.tbEntitiesList) do 
        if iEnt.destory then 
            iEnt:destory();
            iEnt = nil;
        end 
    end 
    self.tbEntitiesList = nil;
    self.tbSystemList = nil;
end