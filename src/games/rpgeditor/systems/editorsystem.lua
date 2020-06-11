editorsystem = class("editorsystem", system);

function editorsystem:getRequestComponents()
    return {};
end

function editorsystem:keypressed(key)
    if key == "n" then 
        local tbBumpList = self:getSystem('makebumpsystem'):getBumpList();
        local str = '_G.map={\n';
        str = str .. '\ttbBumpList={\n';
        for _,iTargetEnt in ipairs(tbBumpList) do 
            local c_position = iTargetEnt:getComponent("position");
            local x = c_position:getAttribute("x");
            local y = c_position:getAttribute("y");
            local c_size = iTargetEnt:getComponent("size");
            local w = c_size:getAttribute("w");
            local h = c_size:getAttribute("h");
            str = str .. string.format('\t\t{%s,%s,%s,%s};\n', x,y,w,h)
        end 
        str = str .. '\t};\n'
        str = str .. '}\n'
        local file = io.open('map.lua', 'w')
        if file ~= nil then 
            file:write(str.."\n");
            file:close();
        end
    end 
end

