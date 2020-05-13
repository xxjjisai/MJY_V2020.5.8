_G.baseclass = class('baseclass')

function baseclass:init()

end

function baseclass:trace(nType,...)
    if g_option.DEBUG >= 1 then 
        local sType = "[Log] ";
        if nType == 1 then 
            sType = "[Log] " 
        elseif nType == 2 then 
            sType = "[Warn] " 
        elseif nType == 3 then 
            sType = "[Error] " 
        else 
            sType = "[Log] "
        end  
        
        local args = {...};
        if type(args[1]) == "table" then 
            print("[~~~~~~~~~~~~~~~~"..self.class.name.."~~~~~~~~~~~~~~~~] start >> ",sType);
            print_lua_table(args[1]);
            print("[~~~~~~~~~~~~~~~~"..self.class.name.."~~~~~~~~~~~~~~~~] end << ",sType);
            return 
        end  
        local str = "["..self.class.name.." "..os.date("%c").."] "..sType;
        for i,v in ipairs(args) do 
            str = str..tostring(v).." ";
        end
    
        print(str.."");
    
        if g_option.LOG >= 1 then 
            local file = io.open('gc.log', 'a')
            if file ~= nil then 
                file:write(str.."\n");
                file:close();
            end
        end
    end
end