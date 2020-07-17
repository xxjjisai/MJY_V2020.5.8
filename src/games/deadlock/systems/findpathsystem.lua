_G.findpathsystem = class("findpathsystem", system);

function findpathsystem:getRequestComponents()
    return {};
end

function findpathsystem:onEnterScene()

end

function findpathsystem:onExitScene()

end

function findpathsystem:ConvertColRowHandler(x,y)
    local nHCol = math.floor( x / g_gameCfg.nBumpWorldCellSize ) + 1;
    local nHRow = math.floor( y / g_gameCfg.nBumpWorldCellSize ) + 1;
    return nHCol,nHRow;
end

-- local tbStart = { x = 100, y = 100 };
-- local tbEnd = { x = 100, y = 100 }
-- self:getSystem('findpathsystem'):FindWay(1,tbStart,tbEnd,function (tbPathList)
--     self.tbPathList = tbPathList;
-- end)

function findpathsystem:FindWay(walkable,p1,p2,pfn)
    local tbMap = self:getSystem('mapsystem'):getCurMap();
    if tbMap == nil then 
        self:trace(3,"Map is nil!");
        return 
    end 
    local startx, starty = self:ConvertColRowHandler(p1.x,p1.y);
    local endx, endy = self:ConvertColRowHandler(p2.x,p2.y);
    local grid = Grid(tbMap);
    local myFinder = Pathfinder(grid, g_project.CUR_PROJECT_FINDPATHTYPE, walkable);
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
        -- self:trace(2,"Path Not Found!")
        if pfn then
            pfn(nil);
        end
    end 
end
