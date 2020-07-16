actormovesystem = class("actormovesystem", system);

function actormovesystem:getRequestComponents()
    return {'position','size','actormove'};
end

function actormovesystem:onEnterScene()

end

function actormovesystem:MovePath(iEnt,tbPathList,pfn)
    local c_actormove = iEnt:getComponent('actormove').tbData;
    if c_actormove.bMoving then 
        return 
    end 
    table.remove(tbPathList, 1);
    c_actormove.tbPathList = tbPathList;
    c_actormove.bMoving = true;
    c_actormove.bStartMove = true;
    c_actormove.fCompleteHandler = pfn;
end

function actormovesystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do
        self:StepHandler(iTargetEnt);
    end
end 

function actormovesystem:StepHandler(iTargetEnt)
    local c_actormove = iTargetEnt:getComponent('actormove').tbData;
    local bStartMove = c_actormove.bStartMove or false;
    local tbPathList = c_actormove.tbPathList;
    local nMoveTime = c_actormove.nMoveTime;
    local bMoving = c_actormove.bMoving or false;
    local fCompleteHandler = c_actormove.fCompleteHandler;
    if bMoving then 
        if bStartMove then 
            c_actormove.bStartMove = false;
            if #tbPathList < 1 then 
                c_actormove.bMoving = false;
                if fCompleteHandler then 
                    fCompleteHandler();
                end 
                return;
            end 
            local nTargetX = (tbPathList[1].x - 1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2;
            local nTargetY = (tbPathList[1].y - 1) * g_gameCfg.nBumpWorldCellSize + g_gameCfg.nBumpWorldCellSize/2;
            timer:tween(nMoveTime, iTargetEnt:tweenData('position'), { x = nTargetX, y = nTargetY }, 'linear', function() 
                table.remove(tbPathList,1);
                c_actormove.bStartMove = true;
            end)
        end 
    end
end

-- function actormovesystem:onDraw()
--     for i,iTargetEnt in ipairs(self:getTargets()) do
--         local c_actormove = iTargetEnt:getComponent('actormove').tbData;
--         local tbPathList = c_actormove.tbPathList;
--         tbPathList = tbPathList or {};
--         for i,v in ipairs(tbPathList) do 
--             love.graphics.setColor(1,1,0,1);
--             love.graphics.rectangle("fill",(v.x - 1) * g_gameCfg.nBumpWorldCellSize,(v.y - 1) * g_gameCfg.nBumpWorldCellSize,g_gameCfg.nBumpWorldCellSize,g_gameCfg.nBumpWorldCellSize);
--             love.graphics.setColor(1,1,1,1);
--             love.graphics.rectangle("line",(v.x - 1) * g_gameCfg.nBumpWorldCellSize,(v.y - 1) * g_gameCfg.nBumpWorldCellSize,g_gameCfg.nBumpWorldCellSize,g_gameCfg.nBumpWorldCellSize);
--         end
--     end
-- end