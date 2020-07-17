_G.g_option = 
{
    DEBUG = 2;          -- 调试模式
    LOG = 0;            -- 生成文件日志
    SPLASH = 1;         -- 是否播放闪屏
    SPLASH_SPEED = 1;   -- 闪屏速度
    LOADED_RES = 0;     -- 加载资源
    GAME_STATE = 0;     -- 游戏状态 
}

_G.g_tbLayer = 
{
    SKY = 101;          -- 最上层（天空等）
    HUMAN = 201;        -- 各类实体
    HUMAN_DOWN = 301;   -- 道具等
    GROUND_UP = 401;    -- 地面植物
    DOOR = 501;         -- 门
    GROUND = 599;       -- 最下层
}

_G.g_project = 
{
    CUR_PROJECT_NAME = "deadlock",        -- 当前项目工程名称
    CUR_PROJECT_TYPE = "roguelike",             -- 当前项目工程游戏类型，用来区别摄像机类型和渲染层级类型 (roguelike,platform,...)
    CUR_PROJECT_MAINSCENE = "mainscene",        -- 当前项目工程主场景名称
    CUR_PROJECT_SCENE_TRANSITION_TIME = 1,      -- 当前项目工程场景过渡时长
    CUR_PROJECT_RES_CONFIG_PATH = 'resconfig',  -- 当前项目工程资源配置表名称
    CUR_PROJECT_CAMERA_FOLLOWLERP = 0.03,       -- 当前项目工程摄像机跟随插值
    CUR_PROJECT_CAMERA_FOLLOWSTYLE = 'LOCKON',  -- 当前项目工程摄像机跟随类型
    CUR_PROJECT_CAMERA_SCALE = 0.3,               -- 当前项目工程摄像机缩放倍数
    CUR_PROJECT_FINDPATHTYPE = 'ASTAR',         -- 当前项目工程寻路算法 'ASTAR','DIJKSTRA''THETASTAR''BFS''DFS''JPS'
}

_G.g_gameCfg = 
{
    nBumpWorldCellSize = 32; -- 碰撞世界单块尺寸
}

_G.g_CommonScript = 
{
    compos = 
    {
        'position',      -- 位移
        'animaterender', -- 动画渲染
        'shaperender',   -- 图形渲染
        'size',          -- 尺寸
        'sortorder',     -- 渲染顺序
        'title',         -- 标题
        'speed',         -- 速度
        'direction',     -- 方向
        'bumprect',      -- 阻碍
        'awaken',        -- 激活
        'wasdmove',      -- WASD方向键移动
        'moveselect',    -- 移动物体选择
    };
    
    systems = 
    {
        'animationsystem', -- 动画渲染系统
        'drawshapesystem', -- 图形渲染系统
        'welcomesystem',   -- 欢迎界面系统
        'bumprectsystem',  -- 矩形碰撞系统
        'awakensystem',    -- 范围激活系统
        'wasdmovesystem',  -- WASD移动系统
        'moveselectsystem',-- 物体选择系统
    };
}

_G.g_color = 
{
    WHITE = {1,1,1,1};  -- 白色
    BLACK = {0,0,0,1};  -- 黑色
    RED = {1,0,0,1};    -- 红色
    GREEN = {0,1,0,1};  -- 绿色
    BLUE = {0,0,1,1};   -- 蓝色
    PURPLE = {1,0,1,1}; -- 紫色
    ALPHA = {0,0,0,0};  -- 透明
    SECURITY = {1,1,1,0.1}; -- 防伪Logo
    NORMAL_AWAKEN = {0.5,1,0.5,0.2}; -- 正常激活
    WARN_AWAKEN = {1,1,0,0.5}; -- 警告激活
    HERO = {128/255,128/255,0,1}; -- 主角颜色
}

_G.g_gamestate = 
{
    LOAD_RES = 1;    -- 加载资源
    PLAY_SPLASH = 2; -- 播放闪屏
    MAIN_SCENE = 3;  -- 主场景
    GAME_SCENE = 4;  -- 游戏场景
    OVER_SCENE = 5;  -- 结束场景
    PAUSE_SCENE = 6; -- 暂停场景
}