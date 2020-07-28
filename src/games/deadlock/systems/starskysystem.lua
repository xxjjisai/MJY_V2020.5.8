_G.starskysystem = class("starskysystem", system);

function starskysystem:getRequestComponents()
    return {};
end

function starskysystem:onEnterScene()
    self.nShineSpeed = math.random(0.01,0.05);
    self.tbStarrySky = {};

    for i = 1,2000 do 
        local star = {};
        star.color = {1,1,1,math.random( 0,1 )};
        star.x = math.random( -100000,100000 );
        star.y = math.random( -100000,100000 );
        star.bUp = false;
        star.r = math.random( 10,30 );
        star.c = math.random( 10,60 );
        table.insert(self.tbStarrySky,star);
    end 
end

function starskysystem:onExitScene()
    self.nShineSpeed = nil;
    self.tbStarrySky = nil;
end

function starskysystem:onUpdate(dt)
    if self.tbStarrySky == nil or not next(self.tbStarrySky) then return end;
    for i,star in ipairs(self.tbStarrySky) do 
        if star.bUp then 
            star.color[4] = star.color[4] + self.nShineSpeed;
            if star.color[4] >= 1 then 
                star.color[4] = 1;
                star.bUp = false;
            end  
        else 
            star.color[4] = star.color[4] - self.nShineSpeed;
            if star.color[4] <= 0 then 
                star.color[4] = 0;
                star.x = math.random( -10000,10000 );
                star.y = math.random( -10000,10000 );
                star.r = math.random( 3,7 );
                star.c = math.random( 1,70 );
                star.bUp = true;
            end   
        end  
    end
end

function starskysystem:onDraw()
    if self.tbStarrySky == nil or not next(self.tbStarrySky) then return end;
    for i,star in ipairs(self.tbStarrySky) do 
        love.graphics.setColor(star.color)
        love.graphics.circle("fill", star.x, star.y, star.r, star.c)--math.random(3,8));
    end
    for i,star in ipairs(self.tbStarrySky) do 
        love.graphics.setColor(star.color)
        love.graphics.circle("fill", star.x, star.y, star.r, star.c)--math.random(3,8));
    end
end