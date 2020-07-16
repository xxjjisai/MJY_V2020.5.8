local tbEntityList = 
{
    'actor',
}

for _,sEntityName in ipairs(tbEntityList) do 
    _G[sEntityName] = class(sEntityName,entity);
end