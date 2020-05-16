_G.API = 
{
    [1] = function ()
	-- local position 	= component:new({x = 100, y = 100});
	-- local size 		= component:new({w = 32, h = 32});
	-- local player 	= entity:new({["position"] = position,["size"] = size});
	-- local movesys   = system:new();
	-- local baseworld  = baseworld:new();
	-- baseworld:addEntity(player);
	-- baseworld:registerSystem(movesys);
-------------------------------------------------------------------------------------------------
	-- local position 	= component:new();
	-- position:addAttribute("x",100);
	-- position:addAttribute("y",100);
	-- local size 		= component:new();
	-- size:addAttribute("w",32);
	-- size:addAttribute("h",32);
	-- local player 	= entity:new();
	-- player:addComponent(position);
	-- player:addComponent(size);
	-- local movesys   = system:new();
	-- movesys:addMethod("moveHandler",function () print("Hello,world"); end);
	-- local baseworld  = baseworld:new();
	-- baseworld:addEntity(player);
	-- baseworld:registerSystem(movesys);
	end,
	
	[2] = function ()

		baseworld:getInstance():create();

		local c_position = position:new({ x = 200, y = 200});
		local c_size = size:new({ w = 40, h = 40});
		local c_speed = speed:new({speed=math.random(10, 30)});
		local c_shaperender = shaperender:new({ order = 1, color = g_color.GREEN, shapeType = "rectangle", fillType = "fill"});
		
		local e_hero1 = hero:new({c_position,c_size,c_shaperender});
		print(e_hero1.id)
	
		local c_position2 = position:new({ x = 300, y = 200});
		local c_size2 = size:new({ w = 40, h = 40});
		local c_speed2 = speed:new({speed=math.random(10, 30)});
		local c_shaperender2 = shaperender:new({ order = 1, color = g_color.RED, shapeType = "rectangle", fillType = "fill"});
	
		local e_hero2 = hero:new({c_position2,c_size2,c_shaperender2});
	
		print(e_hero1.id,e_hero2.id)
	
		-- print(table.show(e_hero1,"e_hero1"))
		-- print(table.show(e_hero2,"e_hero2"))
	
		-- baseworld:getInstance():removeEntity(e_hero1);
		-- baseworld:getInstance():removeEntity(e_hero2);
	
		-- for i = 1, 4500 do 
		-- 	local c_position = position:new({ x = math.random(1,50000), y = math.random(1,50000)});
		-- 	local c_size = size:new({ w = 10, h = 10});
		-- 	local c_speed = speed:new({speed=math.random(10, 30)});
		-- 	local c_shaperender = shaperender:new({ order = 1, color = g_color.RED, shapeType = "rectangle", fillType = "line"});
		-- 	local e_ent = entity:new();
		-- 	e_ent:addComponent(c_position);
		-- 	e_ent:addComponent(c_size);
		-- 	e_ent:addComponent(c_shaperender);
		-- 	e_ent:addComponent(c_speed);
		-- 	baseworld:getInstance():addEntity(e_ent);
		-- end 
	
		local s_printSystem = system:new({"position"});
		s_printSystem:addMethod("printHandler",function (...)
			print(...);
		end)
	
		s_printSystem:doMethod("printHandler",123);
	
		local s_drawshapesystem = drawshapesystem:new({"position","size","shaperender"});
		local s_moveshapesystem = moveshapesystem:new({"position","size","speed"});
	
		-- baseworld:getInstance():registerSystem(s_printSystem);
		-- baseworld:getInstance():registerSystem(s_drawshapesystem);
		-- baseworld:getInstance():registerSystem(s_moveshapesystem);
	
		-- local starttime = os.clock();
		-- local targets = baseworld:getInstance():getFilterTarget({"position","size","shaperender"});
		-- print(#targets)
		-- local endtime = os.clock();  
		-- print(string.format("cost time  : %.4f", endtime - starttime));
	end,

	["不加场景过渡效果"] = function ()
		_G.xinshouchunscene = class('xinshouchunscene',basescene)

		function xinshouchunscene:onEnterScene()
			local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "老手村", 
															sVersion = "V2020.5.8", color = g_color.SECURITY});

			local e_gametitle = gametitle:new({c_title});

			local s_welceomsystem = welceomsystem:new();

			local btn_help = uimgr:getInstance():create("shapebutton","btn_help");
			btn_help:SetPositionCenter(0,130);
			btn_help:SetText("欢迎");
			btn_help:SetData("Oper", "onClick", function ()
				scenemgr:getInstance():switchScene("welcomescene");
			end)
		end
	end, 

	["加场景过渡效果"] = function ()
		_G.welcomescene = class('welcomescene',basescene)

		function welcomescene:onEnterScene()
			scenemgr:getInstance():transitionScene( function ()
				local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "Demo1", 
																sVersion = "V2020.5.8", color = g_color.WHITE});
			
				local e_gametitle = gametitle:new({c_title});
			
				local s_welceomsystem = welceomsystem:new();
			
				local btn_enter = uimgr:getInstance():create("shapebutton","btn_enter");
				btn_enter:SetPositionCenter(0,130);
				btn_enter:SetText("a开始");
				btn_enter:SetData("Oper", "onClick", function ()
					scenemgr:getInstance():switchScene("gamescene");
				end)
			
				local btn_help = uimgr:getInstance():create("shapebutton","btn_help");
				btn_help:SetPositionCenter(0,130 + btn_help:GetData("Size", "h") + 5);
				btn_help:SetText("帮助");
				btn_help:SetData("Oper", "onClick", function ()
					scenemgr:getInstance():switchScene("helpscene");
				end)
			end)
		end
	end, 
}