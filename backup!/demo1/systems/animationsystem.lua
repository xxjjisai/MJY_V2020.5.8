animationsystem = class("animationsystem", system);

function animationsystem:getRequestComponents()
    return {'position','size','animaterender'};
end

function animationsystem:onEnterScene()
    for i,iTargetEnt in ipairs(self:getTargets()) do 
        local c_animaterender = iTargetEnt:getComponent("animaterender");
        self:SetFrame(c_animaterender);
        if c_animaterender:getAttribute("bStartPlay") then 
            self:Play(iTargetEnt,c_animaterender:getAttribute("nStartFrame"),c_animaterender:getAttribute("nEndFrame"));
        end
    end
end

function animationsystem:SetFrame(c_animaterender)
	local c_animaterender = c_animaterender or {};
	local sImg = c_animaterender:getAttribute("sImg");
	local iImage = resmgr:getInstance():GetTexture(sImg);
	c_animaterender:addAttribute("iImage",iImage);
	local nQuadW = c_animaterender:getAttribute("nQuadW") or 0;
	local nQuadH = c_animaterender:getAttribute("nQuadH") or 0;
	local nOffset = c_animaterender:getAttribute("nOffset") or 0;
	local nStartFrame = 1;
	local nImgW,nImgH = iImage:getWidth(), iImage:getHeight();
	local nCol = math.floor(nImgW/nQuadW);
	local nRow = math.floor(nImgH/nQuadH);
	c_animaterender:addAttribute("tbQuad",{});
	local nFrame = 1;
	c_animaterender:addAttribute("nCurFrame",nFrame);
	local tbQuad = c_animaterender:getAttribute("tbQuad");
	for i = 0, nRow-1 do
		for j = 0, nCol-1 do
			tbQuad[nFrame] = love.graphics.newQuad(j*nQuadW, i*nQuadH, nQuadW, nQuadH, nImgW, nImgH);
			nFrame = nFrame + 1;
		end
    end
	c_animaterender:addAttribute("nLastTime",0);
	c_animaterender:addAttribute("nCurPlayCount",0);
	c_animaterender:addAttribute("nTotalPlayCount",c_animaterender:getAttribute("nTotalPlayCount") - nOffset);
    c_animaterender:addAttribute("iCurQuad",tbQuad[nStartFrame or c_animaterender:getAttribute("nCurFrame")]);
end

function animationsystem:onUpdate(dt)
    for i,iTargetEnt in ipairs(self:getTargets()) do
        local c_animaterender = iTargetEnt:getComponent("animaterender").tbData;
        if not c_animaterender.bRunning then 
            break;
        end
        local nTimeAfterPlay = c_animaterender.nTimeAfterPlay;
        local nLastTime = c_animaterender.nLastTime or 0;
        local nTotalFrame = c_animaterender.nTotalFrame;
        local nEndFrame = c_animaterender.nEndFrame;--self.nEndFrame or nTotalFrame;
        local nStartFrame = c_animaterender.nStartFrame--self.nStartFrame or 1;
        local nCurPlayCount = c_animaterender.nCurPlayCount;
        local nTotalPlayCount = c_animaterender.nTotalPlayCount;
        local fComplete = c_animaterender.fComplete or nil;
        local nLoop = c_animaterender.nLoop;
        local nNowTime = GetTime();
        nTotalFrame = nEndFrame;
        if nNowTime - nLastTime > nTimeAfterPlay then 
            c_animaterender.nLastTime = nNowTime;
            c_animaterender.nCurFrame = c_animaterender.nCurFrame + 1;
            if c_animaterender.nCurFrame > nTotalFrame then 
                if nLoop == 0 then 
                    c_animaterender.nCurPlayCount = c_animaterender.nCurPlayCount + 1;
                    if c_animaterender.nCurPlayCount >= nTotalPlayCount then 
                        c_animaterender.iCurQuad = nil;
                        c_animaterender.bRunning = false;
                        if fComplete then 
                            fComplete();
                        end 
                        break;
                    else 
                        c_animaterender.nCurFrame = nStartFrame;
                        c_animaterender.iCurQuad = c_animaterender.tbQuad[c_animaterender.nCurFrame];
                        break;
                    end
                elseif nLoop == 1 then  
                    c_animaterender.nCurFrame = nStartFrame;
                    c_animaterender.iCurQuad = c_animaterender.tbQuad[c_animaterender.nCurFrame];
                end
            else 
                c_animaterender.iCurQuad = c_animaterender.tbQuad[c_animaterender.nCurFrame];
            end
        end 
    end
end 

function animationsystem:onDraw()
    for i,iTargetEnt in ipairs(self:getTargets()) do
        local c_animaterender = iTargetEnt:getComponent("animaterender");
        local c_animaterender = iTargetEnt:getComponent("animaterender").tbData;
        local c_position = iTargetEnt:getComponent("position").tbData;
        local c_size = iTargetEnt:getComponent("size").tbData;
        if not c_animaterender.bRunning then 
            break;
        end 
        local x = c_position.x;
        local y = c_position.y;
        local iImage = c_animaterender.iImage;
        if iImage == nil then 
            self:trace(1,"there is no image")
            break;
        end 
        local iCurQuad = c_animaterender.iCurQuad;
        if iCurQuad == nil then 
            self:trace(1,"there is no quad")
            break;
        end 
        local nQuadW = c_animaterender.nQuadW;
        local nQuadH = c_animaterender.nQuadH;
        local w = c_size.w;
        local h = c_size.h;
        local sx = c_animaterender.sx or 1;
        local sy = c_animaterender.sy or 1;
        local ox = c_animaterender.ox or 0;
        local oy = c_animaterender.oy or 0;
        local r = c_animaterender.r or 0;
        local nImageX = x - (nQuadW * 0.5 - w * 0.5);
        local nImageY = y - (nQuadH - h);
        love.graphics.setColor(c_animaterender.color); 
        love.graphics.draw(iImage, iCurQuad, nImageX, nImageY,math.rad(r),sx, sy, ox, oy);
        if g_option.DEBUG >= 3 then 
            love.graphics.setFont(resmgr:getInstance():GetFont(12));
            -- 贴图轮廓
            love.graphics.setColor(100,100,250,100);
            love.graphics.rectangle("line", nImageX, nImageY, nQuadW, nQuadH);
            -- 底部点
            love.graphics.setColor(250,0,0,250); 
            love.graphics.circle( "fill",nImageX + nQuadW / 2, nImageY + nQuadH, 7 ) 
            -- 帧序号
            love.graphics.setColor(255,0,0,250); 
            local nCurFrame = c_animaterender.nCurFrame;
            love.graphics.print(string.format("Frame:%d",nCurFrame or 0),nImageX + nQuadW / 2, nImageY + nQuadH + 10);
        end
    end
end

function animationsystem:Play(iTargetEnt,nStartFrame,nEndFrame,fComplete)
	local c_animaterender = iTargetEnt:getComponent("animaterender");
	c_animaterender:addAttribute("bRunning", true);
	c_animaterender:addAttribute("nCurFrame",nStartFrame);
	c_animaterender:addAttribute("nStartFrame",nStartFrame);
	c_animaterender:addAttribute("nEndFrame",nEndFrame);
	c_animaterender:addAttribute("fComplete",fComplete);
end