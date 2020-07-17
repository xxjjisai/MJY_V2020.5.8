_G.mapsystem = class("mapsystem", system);

function mapsystem:getRequestComponents()
    return {};
end

function mapsystem:onEnterScene()

end

function mapsystem:onExitScene()

end

function mapsystem:MakeMap()
    self.tbMapInfo = map15;
end

function mapsystem:getCurMap()
    return self.tbMapInfo;
end

function mapsystem:onDraw()
    for i = 1, #self.tbMapInfo do 
        for j = 1, #self.tbMapInfo[i] do 
            -- if self.tbMapInfo[i][j] == -1 then 
            --     love.graphics.setColor(0,1,1,0.3);
            --     love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            -- end
            if self.tbMapInfo[i][j] == 0 then 
                love.graphics.setColor(0,1,1,0.3);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            end
            if self.tbMapInfo[i][j] == 1 then 
                love.graphics.setColor(1,1,1,0.1);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
            end
            if self.tbMapInfo[i][j] == 2 then 
                love.graphics.setColor(128/255,0,128/255,1);
                love.graphics.rectangle("fill",(j-1) * 32,(i-1) * 32,32,32);
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