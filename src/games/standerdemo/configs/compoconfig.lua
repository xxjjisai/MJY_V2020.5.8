local tbCompoList = 
{
    'position',
    'sortorder',
    'size',
    'direction',
    'bumprect',
    'animaterender',
    'shaperender',
    'awaken',
    'moveselect',
    'speed',
    'title',
    'wasdmove',
    'heroopr',
}

for _,sCompoName in ipairs(tbCompoList) do 
    _G[sCompoName] = class(sCompoName,component);
end