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

-- function collectmineralsystem:StepHandlerX(iTargetEnt)
--     local c_position = iTargetEnt:getComponent("position"); 
--     local c_size = iTargetEnt:getComponent("size"); 
--     local c_collect = iTargetEnt:getComponent("collect");
--     local tbMineralList = self:getSystem("buildsystem"):getMineralList();
--     if c_position and c_size and c_collect and tbMineralList and next(tbMineralList) then 
--         local cx = c_position:getAttribute("x");
--         local cy = c_position:getAttribute("y");
--         local nIdx = 1--math.random(1, #tbMineralList);
--         local nCoreID = tbMineralList[nIdx].coreID;
        
--         local iMineral = baseworld:getInstance():getEntity(nCoreID);
--         local c_position_h = iMineral:getComponent("position"); 
--         if c_position_h then 
--             local hx = c_position_h:getAttribute("x");
--             local hy = c_position_h:getAttribute("y");
--             local tbStart = { x = cx, y = cy };
--             local tbEnd = { x = hx, y = hy };
--             local nWalkAbled = c_collect:getAttribute("nWalkAbled");
--             local bStartExe = c_collect:getAttribute("bStartExe") or false;
--             if not bStartExe then 
--                 bStartExe = true;
--                 local tbMineralList = tbMineralList;
--                 local nIdx = nIdx;
--                 self:getSystem('findpathsystem'):FindWay(nWalkAbled,tbStart,tbEnd,function (tbPathList)
--                     self:getSystem('actormovesystem'):MovePath(iTargetEnt,tbPathList,function ()
--                         local tbEnd = { x = cx, y = cy };
--                         local tbStart = { x = hx, y = hy };
--                         table.remove(tbMineralList,nIdx);
--                         baseworld:getInstance():removeEntity(nCoreID);
--                         self:getSystem('findpathsystem'):FindWay(nWalkAbled,tbStart,tbEnd,function (tbPathList)
--                             self:getSystem('actormovesystem'):MovePath(iTargetEnt,tbPathList,function ()
--                                 bStartExe = false;
--                             end)
--                         end)
--                     end)
--                 end)
--             end
--         end
        
--     end
-- end