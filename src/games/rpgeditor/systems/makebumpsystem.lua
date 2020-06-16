makebumpsystem = class("makebumpsystem", system);

function makebumpsystem:getRequestComponents()
    return {};
end

function makebumpsystem:onEnterScene()
    self:addEvent('moveselectsystem');
end

function makebumpsystem:onExitScene()
    self:removeEvent('moveselectsystem');
    self.tbBumpList = nil;
end

function makebumpsystem:getBumpList()
    return self.tbBumpList;
end

function makebumpsystem:addBumpList(iBump)
    self.tbBumpList = self.tbBumpList or {};
    table.insert(self.tbBumpList, iBump);
end

function makebumpsystem:EvtSelectAreInfo(x,y,w,h)
    local c_position = position:new({ x = x, y = y });
    local c_size = size:new({ w = w, h = h });
    local c_bumprect = bumprect:new();
    local c_sortorder = sortorder:new({nLayerIndex = g_tbLayer.HUMAN;});
    local c_shaperender = shaperender:new({ color = g_color.RED, drawType="shape",shapeType = "rectangle", 
                                                        fillType = "line" });
    local e_hero = hero:new({ c_position,c_size,c_bumprect,c_sortorder,c_shaperender });

    self:addBumpList(e_hero);
    
end