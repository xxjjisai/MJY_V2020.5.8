_G.gamemgr = class('gamemgr',manager)

function gamemgr:create()
	love.graphics.setBackgroundColor(0.05,0.05,0.05);
	love.graphics.clear();
    love.graphics.present();
    love.graphics.setDefaultFilter('nearest', 'nearest', 1);
    love.graphics.setLineStyle('smooth');
	_G.W, _G.H, _G.flags = love.window.getMode( )
	_G.windows = { w = W, h = H };
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
	g_option.GAME_STATE = g_gamestate.LOAD_RES;
	resmgr:getInstance():create();
	resmgr:getInstance():start(function ()
		timer:after(0.3,function ()
			if g_option.SPLASH < 1 then 
				g_option.GAME_STATE = g_gamestate.PLAY_SPLASH;
				splashmgr:getInstance():create();
				splashmgr:getInstance():start(function ()
					self:start();
				end);
			else 
				self:start();
			end
		end)
	end)
end

function gamemgr:start()
	g_option.GAME_STATE = g_gamestate.MAIN_SCENE;
	scenemgr:getInstance():create();
end

function gamemgr:update(dt)

	timer:update(dt)
	camera:update(dt)

	if g_option.GAME_STATE == g_gamestate.LOAD_RES then 
		resmgr:getInstance():update(dt);
	end

	if g_option.GAME_STATE == g_gamestate.PLAY_SPLASH then 
		splashmgr:getInstance():update(dt);
	end

	if g_option.GAME_STATE == g_gamestate.MAIN_SCENE then 
		scenemgr:getInstance():update(dt);
		uimgr:getInstance():update(dt);
	end
end

function gamemgr:draw()

	if g_option.GAME_STATE == g_gamestate.LOAD_RES then 
		resmgr:getInstance():draw();
	end

	if g_option.GAME_STATE == g_gamestate.PLAY_SPLASH then 
		splashmgr:getInstance():draw();
	end

	if g_option.GAME_STATE == g_gamestate.MAIN_SCENE then 
		scenemgr:getInstance():draw();
		uimgr:getInstance():draw();
	end
	
	if g_option.DEBUG >= 2 then 
		local font = resmgr:getInstance():GetFont(18);
		love.graphics.setFont(font);
		love.graphics.setColor(g_color.GREEN);
		local stats = love.graphics.getStats();
		love.graphics.print("GPU Memory: "..(math.floor(stats.texturememory/1.024)/1000)..
		" Kb\nLua Memory: "..(math.floor(collectgarbage("count")/1.024)/1000).." Kb\nFonts: "..
		stats.fonts.."\nCanvas Switches: "..stats.canvasswitches.."\nCanvases: "..stats.canvases..
		"\nFPS: "..love.timer.getFPS(), 10, 10);
		love.graphics.setColor(g_color.WHITE);
	end

end
