# MJY_V2020.5.8    

```
_G.testscene = class('testscene',basescene)

function testscene:onEnterScene()
    -- 场景过渡：淡入淡出
    scenemgr:getInstance():transitionScene( function ()
        if g_option.DEBUG > 0 then 
            local c_title = title:new({ nTitleNameFontSize = 72, nVersionFontSize = 22, sTitleName = "TEST", 
                                                            sVersion = "V2020.5.8", color = g_color.SECURITY});
            local e_gametitle = gametitle:new({c_title});
            local s_welceomsystem = welceomsystem:new();
        end
        -- 摄像机配置（跟随类型，缩放等）
        -------------------------------------------------------------------------------------------------
        cameramgr:getInstance():SetCameraStyle(g_project.CUR_PROJECT_CAMERA_FOLLOWLERP,
                g_project.CUR_PROJECT_CAMERA_FOLLOWSTYLE,g_project.CUR_PROJECT_CAMERA_SCALE);
        -------------------------------------------------------------------------------------------------
        -- 创建位置、尺寸、形状渲染组件
        local c__hero_position = position:new({ x = 300, y = 300 });
        local c__hero_size = size:new({ w = 32, h = 32 });
        local c__hero_shaperender = shaperender:new({ color = g_color.GREEN, drawType="shape",shapeType = "rectangle", 
                                                            fillType = "line" });
        -------------------------------------------------------------------------------------------------
        -- 创建实体对象并挂载需要的组件 
        local e_hero = hero:new({ c__hero_position,c__hero_size,c__hero_shaperender });
        -------------------------------------------------------------------------------------------------
        -- 设置实体对象摄像机跟随
        cameramgr:getInstance():SetFollowPlayer(e_hero);
        -------------------------------------------------------------------------------------------------
        -- 创建形状渲染系统（渲染挂载了位置、尺寸和形状渲染组件的实体对象）
        local s_drawshapesystem = drawshapesystem:new();
        -------------------------------------------------------------------------------------------------
        -- 0.1秒后启动形状渲染系统
        scenemgr:getInstance():startupSystem(0.1,function () 
            s_drawshapesystem:startup();
        end)
        -------------------------------------------------------------------------------------------------
    end)
end
```
