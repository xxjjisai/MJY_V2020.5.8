_G.splashmgr = class('splashmgr',manager)

function splashmgr:create()
    self.speed = g_option.SPLASH_SPEED;
end

function splashmgr:start(pfn)
    local splashCfg = 
    {
        {		
        	image = resmgr:getInstance():GetTexture("trees"),footer = "Look, some trees!",speed = self.speed,duration = 2,
        },
        {		
        	image = resmgr:getInstance():GetTexture("rabbit"), footer = "There is a rabbit nearby...", speed = self.speed, duration = 2,
        },
        {		
        	image = resmgr:getInstance():GetTexture("mushroom"), footer = "Who likes eating mushrooms!", speed = self.speed, duration = 2,
        },
        {		
            image = resmgr:getInstance():GetTexture("love-app-icon"), footer = "由LÖVE框架提供支持", speed = self.speed, duration = 2,
        },
    }

    splash.populate(splashCfg)
    splash.callback = pfn;
end

function splashmgr:update(dt)
    splash.update(dt)
end

function splashmgr:draw()
    splash.draw()
end
