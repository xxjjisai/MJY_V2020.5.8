_G.findpathsystem = class("findpathsystem", system);

function findpathsystem:getRequestComponents()
    return {};
end

function findpathsystem:onEnterScene()

end

function findpathsystem:onExitScene()

end

function findpathsystem:FindWay(walkable,p1,p2,pfn)
    local tbMap = self:getSystem('mapsystem'):getCurMap();
    if tbMap == nil then 
        self:trace(3,"Map is nil!")
        return 
    end 
    local grid = Grid(tbMap)
    local myFinder = Pathfinder(grid, g_project.CUR_PROJECT_FINDPATHTYPE, walkable)
    local startx, starty = p1.x,p1.y;
    local endx, endy = p2.x,p2.y;
    local path = myFinder:getPath(startx, starty, endx, endy)
    if path then
        -- self:trace(2,('Path found! Length: %.2f'):format(path:getLength()))
        -- local tbPathList = {};
        -- for node, count in path:nodes() do
        --     table.insert(tbPathList, {x = (node:getX()-1) * g_gameCfg.nBumpWorldCellSize, y = (node:getY()-1) * g_gameCfg.nBumpWorldCellSize })
        -- end 
        -- if pfn then
        --     table.remove(tbPathList, 1);
        --     pfn(tbPathList);
        -- end
        if pfn then
            local tbPathList = {};
            for node, count in path:nodes() do
                table.insert(tbPathList, { x = node:getX(), y = node:getY() });
            end
            pfn(tbPathList);
        end
    else 
        self:trace(2,"Path Not Found!")
    end 
end
