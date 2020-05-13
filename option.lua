_G.g_option = 
{
    DEBUG = 2;
    LOG = 0;
    SPLASH = 1;
    SPLASH_SPEED = 1;
    LOADED_RES = 0;
    GAME_STATE = 0;
}

_G.g_tbLayer = 
{
    SKY = 101;
    HUMAN = 201;
    HUMAN_DOWN = 202;
    GROUND_UP = 203;
    GROUND = 301;
}

_G.g_project = 
{
    CUR_PROJECT_NAME = "demo1",
    CUR_PROJECT_TYPE = "roguelike", -- roguelike,
    CUR_PROJECT_MAINSCENE = "mainscene",
    CUR_PROJECT_SCENE_TRANSITION_TIME = 1, 
}

_G.g_color = 
{
    WHITE = {1,1,1,1};
    RED = {1,0,0,1};
    GREEN = {0,1,0,1};
    BLUE = {0,0,1,1};
    PURPLE = {1,0,1,1};
    SECURITY = {1,1,1,0.15}; -- 防伪Logo
}

_G.g_gamestate = 
{
    LOAD_RES = 1;
    PLAY_SPLASH = 2;
    MAIN_SCENE = 3;
    GAME_SCENE = 4;
    OVER_SCENE = 5;
    PAUSE_SCENE = 6;
}