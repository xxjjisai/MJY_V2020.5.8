
_G.baseevent = class('baseevent',baseclass)

function baseevent:getInstance()
    if self.instance == nil then 
        self.instance = self:new();
    end
    return self.instance;
end

function baseevent:addEvent(tbDistributor,tbListener)
    tbDistributor.tbListenerList[tbListener.id] = tbListener;
end 

function baseevent:removeEvent(tbListener,tbDistributor)
    tbDistributor.tbListenerList = tbDistributor.tbListenerList or {};
    tbDistributor.tbListenerList[tbListener.id] = tbDistributor.tbListenerList[tbListener.id] or nil;
    if tbDistributor.tbListenerList then 
        tbDistributor.tbListenerList[tbListener.id] = nil;
    end 
end  

function baseevent:doEvent(tbDistributor,sFuncName,...)
    local args = {...}; 
    for _,tbListener in pairs(tbDistributor.tbListenerList) do 
        local funcEvent = tbListener[sFuncName];
        if funcEvent ~= nil then 
            local r,x = pcall(funcEvent,tbListener,unpack(args));
            if r == false then
                return self:trace(3,string.format("%s DoEvent Failed %s",r,x));
            end
        end 
    end 
end 

function baseevent:queryEvent(tbDistributor,id) 
    return tbDistributor.tbListenerList[id] ~= nil ;
end 