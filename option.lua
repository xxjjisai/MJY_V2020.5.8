_G.g_option = 
{
    DEBUG = 2; -- 调试模式
    LOG = 0; -- 生成文件日志
    SPLASH = 1; -- 是否播放闪屏
    SPLASH_SPEED = 1; -- 闪屏速度
    LOADED_RES = 0; -- 加载资源
    GAME_STATE = 0; -- 游戏状态 
}

_G.g_tbLayer = 
{
    SKY = 101; -- 最上层（天空等）
    HUMAN = 201; -- 各类实体
    HUMAN_DOWN = 301; -- 道具等
    GROUND_UP = 401; -- 地面植物
    GROUND = 501; -- 最下层
}

_G.g_project = 
{
    CUR_PROJECT_NAME = "standerdemo", -- 当前项目工程名称
    CUR_PROJECT_TYPE = "roguelike", -- 当前项目工程游戏类型，用来区别摄像机类型和渲染层级类型 (roguelike,platform,...)
    CUR_PROJECT_MAINSCENE = "mainscene", -- 当前项目工程主场景名称
    CUR_PROJECT_SCENE_TRANSITION_TIME = 1, -- 当前项目工程场景过渡时长
    CUR_PROJECT_RES_CONFIG_PATH = 'resconfig', -- 当前项目工程资源配置表名称
    CUR_PROJECT_CAMERA_FOLLOWLERP = 0.01, -- 当前项目工程摄像机跟随插值
    CUR_PROJECT_CAMERA_FOLLOWSTYLE = 'LOCKON', -- 当前项目工程摄像机跟随类型
    CUR_PROJECT_CAMERA_SCALE = 1, -- 当前项目工程摄像机缩放倍数
}

_G.g_color = 
{
    WHITE = {1,1,1,1}; -- 白色
    RED = {1,0,0,1}; -- 红色
    GREEN = {0,1,0,1}; -- 绿色
    BLUE = {0,0,1,1}; -- 蓝色
    PURPLE = {1,0,1,1}; -- 紫色
    SECURITY = {1,1,1,0.05}; -- 防伪Logo
}

_G.g_gamestate = 
{
    LOAD_RES = 1; -- 加载资源
    PLAY_SPLASH = 2; -- 播放闪屏
    MAIN_SCENE = 3; -- 主场景
    GAME_SCENE = 4; -- 游戏场景
    OVER_SCENE = 5; -- 结束场景
    PAUSE_SCENE = 6; -- 暂停场景
}