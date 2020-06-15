editorsystem = class("editorsystem", system);

function editorsystem:getRequestComponents()
    return {};
end

function editorsystem:keypressed(key)
    if key == "n" then 
        self:SaveFileHandler();
    end 
end

function editorsystem:SaveFileHandler()
    local tbBumpList = self:getSystem('makebumpsystem'):getBumpList();
    local str = '_G.map={\n';
    str = str .. '\ttbBumpList={\n';
    tbBumpList = tbBumpList or {};
    for _,iTargetEnt in ipairs(tbBumpList) do 
        local c_position = iTargetEnt:getComponent("position");
        local x = GetPreciseDecimal(c_position:getAttribute("x"), 2);
        local y = GetPreciseDecimal(c_position:getAttribute("y"), 2);
        local c_size = iTargetEnt:getComponent("size");
        local w = GetPreciseDecimal(c_size:getAttribute("w"),2);
        local h = GetPreciseDecimal(c_size:getAttribute("h"),2);
        if w ~= 0 or h ~= 0 then 
            str = str .. string.format('\t\t{%s,%s,%s,%s};\n', x,y,w,h)
            -- str = str .. string.format('\t\t{%.2f,%.2f,%.2f,%.2f};\n', x,y,w,h)
        end
    end 
    str = str .. '\t};\n'
    str = str .. '}\n'
    local file = io.open('map.lua', 'w')
    if file ~= nil then 
        file:write(str.."\n");
        file:close();
    end
end

