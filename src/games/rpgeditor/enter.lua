-- _G.g_project = 
-- {
--     CUR_PROJECT_NAME = "standerdemo", -- 当前项目工程名称
--     CUR_PROJECT_TYPE = "roguelike", -- 当前项目工程游戏类型，用来区别摄像机类型和渲染层级类型 (roguelike,platform,...)
--     CUR_PROJECT_MAINSCENE = "mainscene", -- 当前项目工程主场景名称
--     CUR_PROJECT_SCENE_TRANSITION_TIME = 1, -- 当前项目工程场景过渡时长
--     CUR_PROJECT_RES_CONFIG_PATH = 'resconfig', -- 当前项目工程资源配置表名称
--     CUR_PROJECT_CAMERA_FOLLOWLERP = 0.03, -- 当前项目工程摄像机跟随插值
--     CUR_PROJECT_CAMERA_FOLLOWSTYLE = 'LOCKON', -- 当前项目工程摄像机跟随类型
--     CUR_PROJECT_CAMERA_SCALE = 1, -- 当前项目工程摄像机缩放倍数
-- }
_G.enter = 
{
    compos = 
    {
        'moveselect',
        'wasdmove',
    };
    
    configs = 
    {
        "resconfig",
    };

    entities = 
    {
        "gametitle",
        "hero",
        "tile",
    };

    scenes = 
    {
        "mainscene",
        "welcomescene",
        "gamescene",
    };

    systems = 
    {
        'moveselectsystem',
        'makebumpsystem',
        'wasdmovesystem',
        'editorsystem',
    };
}
