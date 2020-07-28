_G.mapsystem = class("mapsystem", system);

function mapsystem:getRequestComponents()
    return {};
end

function mapsystem:onEnterScene()

end

function mapsystem:onExitScene()
    self.tbMapInfo = nil;
    self.tbExplorerMapInfo = nil;
    self.bExplorerMap = false;
end

function mapsystem:MakeMap()
    self.tbMapInfo = clone(map15);
    for i = 1, #self.tbMapInfo do 
        for j = 1, #self.tbMapInfo[i] do 
            if self.tbMapInfo[i][j] == 1 then 
                if math.random(1,10) == 3 then 
                    self.tbMapInfo[i][j] = 0;
                end
            end 
        end
    end
    self.tbExplorerMapInfo = clone(self.tbMapInfo);
    self.bExplorerMap = false;
end

function mapsystem:getCurMap()
    return self.tbMapInfo;
end

function mapsystem:switchMapShow(bExplorerMap)
    self.bExplorerMap = bExplorerMap;
end

function mapsystem:onDraw()
    self:drawMap();
    if self.bExplorerMap then 
        self:drawExplorerMap();
    else 
        self:drawExplorerMap2();
    end
end

function mapsystem:drawMap()
    for i = 1, #self.tbMapInfo do 
        for j = 1, #self.tbMapInfo[i] do 
            -- if self.tbMapInfo[i][j] == -1 then 
            --     love.graphics.setColor(0,1,1,0.3);
            --     love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            -- end
            -- if self.tbMapInfo[i][j] == 0 then 
            --     love.graphics.setColor(0,1,1,0.3);
            --     love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            -- end
            if self.tbMapInfo[i][j] == 1 then 
                love.graphics.setColor(1,1,1,0.1);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            end
            if self.tbMapInfo[i][j] == 2 then 
                love.graphics.setColor(128/255,0,128/255,1);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
                -- love.graphics.setColor(1,1,1,1);
                -- local sImg_iImage = resmgr:getInstance():GetTexture("tile_2");
                -- love.graphics.draw(sImg_iImage, (j-1) * 32,(i-1) * 32);
            end
            if self.tbMapInfo[i][j] == 3 then 
                love.graphics.setColor(65/255,105/255,225/255,1);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            end
            if self.tbMapInfo[i][j] == 4 then 
                love.graphics.setColor(144/255,238/255,144/255,1);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            end
            if self.tbMapInfo[i][j] == 5 then 
                love.graphics.setColor(0/255,128/255,128/255,1);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            end
        end 
    end
end

function mapsystem:drawExplorerMap()
    for i = 1, #self.tbExplorerMapInfo do 
        for j = 1, #self.tbExplorerMapInfo[i] do 
            if self.tbExplorerMapInfo[i][j] == 1 then 
                love.graphics.setColor(1,1,1,0.5);
                love.graphics.rectangle("line",(j-1) * 32,(i-1) * 32,32,32);
            end
            if self.tbExplorerMapInfo[i][j] == 2 then 
                love.graphics.setColor(0.7,0.7,0.7,0.5);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            end
        end 
    end
end

function mapsystem:drawExplorerMap2()
    for i = 1, #self.tbExplorerMapInfo do 
        for j = 1, #self.tbExplorerMapInfo[i] do 
            if self.tbExplorerMapInfo[i][j] == 2 then 
                love.graphics.setColor(0.7,0.7,0.7,0.2);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            end
        end 
    end
end