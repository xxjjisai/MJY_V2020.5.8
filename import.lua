local function new(filename) 
    local maindir = "src/games/"
    local prodir = string.format("%s%s",maindir,filename);
    ----------------------------------------
    local common_compos = g_CommonScript.compos;
    for _,cls in ipairs(common_compos) do 
        require("src/core/common/compos/"..cls);
    end
    ----------------------------------------
    local common_systems = g_CommonScript.systems;
    for _,cls in ipairs(common_systems) do 
        require("src/core/common/systems/"..cls);
    end
    ----------------------------------------
    require(prodir.."/enter")
    local enter_dir = prodir.."/";
    ----------------------------------------
    local configs = enter.configs;
    for _,cls in ipairs(configs) do 
        require(enter_dir.."configs/"..cls);
    end
    ----------------------------------------
    local compos = enter.compos;
    for _,cls in ipairs(compos) do 
        require(enter_dir.."compos/"..cls);
    end
    ----------------------------------------
    local entities = enter.entities;
    for _,cls in ipairs(entities) do 
        require(enter_dir.."entities/"..cls);
    end
    ----------------------------------------
    local scenes = enter.scenes;
    for _,cls in ipairs(scenes) do 
        require(enter_dir.."scenes/"..cls);
    end
    ----------------------------------------
    local systems = enter.systems;
    for _,cls in ipairs(systems) do 
        require(enter_dir.."systems/"..cls);
    end
    ----------------------------------------
end

return new
