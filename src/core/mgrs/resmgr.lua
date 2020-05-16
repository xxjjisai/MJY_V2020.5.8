_G.resmgr = class('resmgr',manager)

resmgr.static.tbMedia = {images = {}, sounds = {}, fonts = {}};

function resmgr:create()

end

function resmgr:start(callback)

    resmgr.tbMedia = resmgr.tbMedia or {images = {}, sounds = {}, fonts = {}};

    local pfn = function ()
        self:trace(1,"[End loading]");
        callback();
    end  

    local curResImageCfg = _G[g_project.CUR_PROJECT_RES_CONFIG_PATH].resimagecfg;
    local curResFontsCfg = _G[g_project.CUR_PROJECT_RES_CONFIG_PATH].resfontcfg;
    local curResSoundCfg = _G[g_project.CUR_PROJECT_RES_CONFIG_PATH].ressoundcfg;

    -- 字体资源
    local tbFont = curResFontsCfg or {};
    if not next(tbFont) then 
        self:trace(1,"Not Find Font");
    else
        local iFont = {};
        local tbFontSize = { 12,14,16,18,20,22,24,26,28,32,36,48,72,92 };
        if tbFont ~= nil then 
            for a = 1, #tbFont do 
                for i = 1, #tbFontSize do 
                    iFont.sName = tbFontSize[i];
                    iFont.sPath = tbFont[a].sPath;
                    iFont.nSize = tbFontSize[i];
                    self:trace(1,"Font:",iFont.sName)
                    resmgr.tbMedia.fonts[tonumber(iFont.sName)] = love.graphics.newFont(iFont.sPath,iFont.nSize);
                end
            end
        end 
    end
    -- 声音资源
    local tbSound = curResSoundCfg or {};
    if not next(tbSound) then 
        self:trace(1,"Not Find Sound");
    else
        if tbSound ~= nil then 
            for _,iSound in pairs(tbSound) do 
                if iSound ~= nil then 
                    self:trace(1,i,"Loading Sound ",iSound.sName);
                    resmgr.tbMedia.sounds[iSound.sName] = love.audio.newSource(iSound.sPath, "stream" );
                end    
            end
        end  
    end

    -- 贴图资源
    local tbImage = curResImageCfg or {};
    tbImage = tbImage or {};
    if not next(tbImage) then 
        self:trace(1,"Not Find Image");
        pfn();
        return;
    else
        if tbImage ~= nil then 
            for i,iTexture in pairs(tbImage) do 
                self:trace(1,i,"Loading Image ",iTexture.sName);
                loader.newImage(resmgr.tbMedia.images,iTexture.sName,iTexture.sPath);
            end
        end 
    end
    -- 开始加载
    loader.start(pfn, nil);
end


function resmgr:update(dt)
    loader.update();
end 

function resmgr:draw() 
	self:DrawLoadingBar();
end

function resmgr:DrawLoadingBar()
	local separation =160;
	local w = W - 2 * separation;
	local h = 20;
	local x,y = separation, H - 70 - h;

	x, y = x + 3, y + 3;
	w, h = w - 6, h - 7;

    local rang = 0;
	love.graphics.setColor(0.23,0.23,0.23,1);
	love.graphics.rectangle("fill", x, y, w, h,rang,rang);
	if loader.loadedCount > 0 then
		w = w * (loader.loadedCount / loader.resourceCount);
        love.graphics.setColor(1,1,1,0.7);
		love.graphics.rectangle("fill", x, y, w, h,rang,rang);
		love.graphics.setColor(1,1,1,0.19);
		love.graphics.rectangle("fill", x, y, W - 2 * separation - 6, h,rang,rang);
		love.graphics.setColor(1,1,1,1);
	end
end 

function resmgr:GetTexture(sImage)
    return resmgr.tbMedia.images[sImage];
end 

function resmgr:GetFont(nFont)
    return resmgr.tbMedia.fonts[nFont];
end 

function resmgr:GetSound(sSound)
    return resmgr.tbMedia.sounds[sSound];
end 
