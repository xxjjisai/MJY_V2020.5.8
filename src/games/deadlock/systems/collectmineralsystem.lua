_G.collectmineralsystem = class("collectmineralsystem", system);

function collectmineralsystem:getRequestComponents()
    return {'position','size','collect'};
end

function collectmineralsystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        self:StepHandler(iTargetEnt);
    end
end

function collectmineralsystem:StepHandler(iTargetEnt)
    local c_collect = iTargetEnt:getComponent("collect").tbData;
    local tbMineralList = self:getSystem("buildsystem"):getMineralList()[c_collect.nWalkAbled];
    if tbMineralList and next(tbMineralList) then 
        if not c_collect.bStartExe then 
            c_collect.bStartExe = true;
            c_collect.tbTarget = clone(tbMineralList[1]);
            table.remove(tbMineralList, 1);
            iTargetEnt:getComponent("collect").tbData.go_tbstart = 
            { 
                x = iTargetEnt:getComponent("position"):getAttribute("x");
                y = iTargetEnt:getComponent("position"):getAttribute("y");
            };
            iTargetEnt:getComponent("collect").tbData.go_tbEnd = 
            { 
                x = baseworld:getInstance():getEntity(iTargetEnt:getComponent("collect").tbData.tbTarget.coreID):getComponent("position"):getAttribute("x");
                y = baseworld:getInstance():getEntity(iTargetEnt:getComponent("collect").tbData.tbTarget.coreID):getComponent("position"):getAttribute("y");
            };
            iTargetEnt:getComponent("collect").tbData.back_tbStart = 
            { 
                x = baseworld:getInstance():getEntity(iTargetEnt:getComponent("collect").tbData.tbTarget.coreID):getComponent("position"):getAttribute("x");
                y = baseworld:getInstance():getEntity(iTargetEnt:getComponent("collect").tbData.tbTarget.coreID):getComponent("position"):getAttribute("y");
            };
            iTargetEnt:getComponent("collect").tbData.back_tbEnd = 
            { 
                x = iTargetEnt:getComponent("position"):getAttribute("x");
                y = iTargetEnt:getComponent("position"):getAttribute("y");
            };
            self:getSystem('findpathsystem'):FindWay(iTargetEnt:getComponent("collect").tbData.nWalkAbled,iTargetEnt:getComponent("collect").tbData.go_tbstart,iTargetEnt:getComponent("collect").tbData.go_tbEnd,function (tbPathList)
                if tbPathList == nil then 
                    iTargetEnt:getComponent("collect").tbData.bStartExe = false;
                    table.insert(tbMineralList, iTargetEnt:getComponent("collect").tbData.tbTarget);
                    iTargetEnt:getComponent("collect").tbData.tbTarget = nil;
                    return;
                end 
                self:getSystem('actormovesystem'):MovePath(iTargetEnt,tbPathList,function ()
                    self:getSystem('tilesystem'):ReClearTile(iTargetEnt:getComponent("collect").tbData.tbTarget.coreID);
                    baseevent:getInstance():doEvent(self,'EvtCollectMineral',iTargetEnt:getComponent("collect").tbData.tbTarget.nMapType);
                    baseworld:getInstance():removeEntity(iTargetEnt:getComponent("collect").tbData.tbTarget.coreID);
                    self:getSystem('findpathsystem'):FindWay(iTargetEnt:getComponent("collect").tbData.nWalkAbled,iTargetEnt:getComponent("collect").tbData.back_tbStart,iTargetEnt:getComponent("collect").tbData.back_tbEnd,function (tbPathList)
                        self:getSystem('actormovesystem'):MovePath(iTargetEnt,tbPathList,function ()
                            iTargetEnt:getComponent("collect").tbData.bStartExe = false;
                        end)
                    end)
                end)
            end)
        end
    end
end