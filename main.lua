
_G.class = require('libs/middleclass')

require('src/option')

require('libs/utils')
_G.loader     = require('libs/love-loader');
_G.splash     = require('libs/lovesplash');
_G.camera     = require('libs/Camera')();
_G.timer      = require('libs/Timer')();
_G.bump       = require('libs/bump');
_G.bump_debug = require('libs/bump_debug');

require('src/core/base/baseorigin');
require('src/core/base/baseclass');
require('src/core/base/baseevent');
require('src/core/base/manager');
require('src/core/base/basescene');
require('src/core/base/baseui');
require('src/core/base/baseworld');
require('src/core/base/component');
require('src/core/base/entity');
require('src/core/base/system');

require('src/core/mgrs/resmgr');
require('src/core/mgrs/splashmgr');
require('src/core/mgrs/gamemgr');
require('src/core/mgrs/scenemgr');
require('src/core/mgrs/uimgr');
require('src/core/mgrs/inputmgr');
require('src/core/mgrs/cameramgr');

require('src/core/uis/shapebutton');
require('src/core/uis/shapetextinput');

require('src/games/start');

function love.load()
	gamemgr:getInstance():create();
end

function love.update(dt)
	gamemgr:getInstance():update(dt);
end

function love.draw()
	gamemgr:getInstance():draw();
end

function love.mousepressed(x,y,button)
    inputmgr:getInstance():mousepressed(x,y,button);
end

function love.keypressed(key)
    inputmgr:getInstance():keypressed(key);
end

function love.run()

    local min = math.min
	if love.math then
		love.math.setRandomSeed(os.time())
		for i = 1, 3 do love.math.random() end
	end

	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
 
    local dt = 0
    local min = math.min
 
	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		-- Update dt, as we'll be passing it to update
        if love.timer then 
            love.timer.step() 
            dt = min(love.timer.getDelta(), 0.05)
        end
        -- if love.timer then dt = love.timer.step() end
 
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.origin()
			love.graphics.clear(love.graphics.getBackgroundColor())
 
			if love.draw then love.draw() end
 
			love.graphics.present()
		end
 
		if love.timer then love.timer.sleep(0.001) end
	end
end