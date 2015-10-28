----------------------------------------------------------------------
-- @module Draw
----------------------------------------------------------------------

-- more function see DX ライブラリ reference page.
-- this is jp language web page. but　exist most example.
-- 
-- # reference page
-- http://homepage2.nifty.com/natupaji/DxLib/dxfunc.html
--
-- # drawGraph
-- http://homepage2.nifty.com/natupaji/DxLib/function/dxfunc_graph0.html#R2N1
-- # drawText and Image
-- http://homepage2.nifty.com/natupaji/DxLib/function/dxfunc_graph1.html#R3N1
-- http://homepage2.nifty.com/natupaji/DxLib/function/dxfunc_graph2.html#R17N1
--====================================================================

local ffi = require("ffi")
local bit = require("bit")
local DxLib = require("DxLib_ffi");

--====================================================================
function drawBackGround(width,height,style,num_)
    --================================================================
    local num = num_ or 20;
    local rectWidth = width /num;
    local rectHeight = height;
    local style_ =style or 1
    --================================================================
    for i=0,num-1
    do
        if ( style_ == 1 )
        then 
            DxLib.dx_DrawBox( rectWidth *i
                            , 0
                            , rectWidth *(i+1)
                            , rectHeight
                            , DxLib.dx_GetColor( 255
                                               , 255/num *(i+1)
                                               , 255/num )
                            , true
            )
        elseif (style_==2)
        then 
             DxLib.dx_DrawBox( rectWidth *i
                            , 0
                            , rectWidth *(i+1)
                            , rectHeight
                            , DxLib.dx_GetColor( 255/num 
                                               , 200/num *(i+1)+55
                                               , 255)
                            , true
                            )
        else
            DxLib.dx_DrawBox( rectWidth *i
                            , 0
                            , rectWidth *(i+1)
                            , rectHeight
                            , DxLib.dx_GetColor( 255
                                               , 255/num *(i+1)
                                               , 255/num )
                            , true
                            )
        end 
    end
end
--====================================================================

--====================================================================
function drawSineCurve(num,dt,width,height)
    --================================================================
    for i=0,num
    do
        local phase = (360 *dt) -360 /15 *i
        local moveWidth = (height/4)
        local x1 = width/num * i
        local y1 = height /2 + moveWidth*(math.sin(math.rad(phase)) )
        local r = 4
        local c = DxLib.dx_GetColor(150,0,255), true -- color,fillflag
        DxLib.dx_DrawCircle(  x1,y1,r,c,1,1);
        
        phase = phase -180
        local x2 = width/num * i
        local y2 = height /2 + moveWidth*(math.sin(math.rad(phase)) )
        DxLib.dx_DrawCircle(  x2,y2,r,c,1,1);
        
        --DxLib.dx_DrawLine  (  x1,y1,x2,y2,c,1);
    end 
end
--====================================================================

--====================================================================
function drawCicle(num,dt,centerX,centerY,width,color)
    local sineMod = math.abs( math.sin( math.rad(360*dt) ) )
    local circleWidth = width*sineMod;
    local circleAngle = 360*dt ;
    local color_ = color or  DxLib.dx_GetColor(150,0,255)
    --================================================================
    for i=0,num
    do
        local x1 =  circleWidth * math.sin( math.rad(360/num*i + circleAngle )) +centerX
        local y1 =  circleWidth * math.cos( math.rad(360/num*i + circleAngle )) +centerY
        local r = 3*sineMod
        local c = color_
        DxLib.dx_DrawCircle(  x1,y1,r,c,1,1);
    end 
end
--====================================================================

--====================================================================
function drawImage(imageHandle,x,y,zoom,angle)
    local zoom_ = zoom or 1
    local angle_ = angle  or 0
    DxLib.dx_DrawRotaGraph( x --x 
                          , y --y
                          , zoom_
                          , angle_
                          , imageHandle 
                          , true     -- TransFlag,  
                          , false ); -- invert flag (  TurnFlag)
end 
--====================================================================

--====================================================================
function drawString(str,x,y,color)
    local color_ = color or DxLib.dx_GetColor(0,0,0)
    DxLib.dx_DrawString( x, y, str, color_ , -1 );
end 
--====================================================================

--====================================================================
function drawStringToHandle(str,x,y,fontHandle,color)
    local color_ = color or DxLib.dx_GetColor(0,0,0)
    DxLib.dx_DrawStringToHandle( x, y, str, color_ ,fontHandle, -1 ,false);
end 
--====================================================================

--====================================================================
function getDrawBlendMode()
    --================================================================
    local nowBlendMode  = ffi.new("int[1]")
    local nowBlendModeParam  = ffi.new("int[1]")
    DxLib.dx_GetDrawBlendMode(nowBlendMode,nowBlendModeParam);
    --================================================================
    return nowBlendMode[0],nowBlendModeParam[0]
end
--====================================================================

--====================================================================
function getBGMTimeStr(soundHandle)
    -- 1sec sample num
    local sampleingRate = DxLib.dx_GetFrequencySoundMem(soundHandle);
    -- current sample position (playing position)
    local currentSample = DxLib.dx_GetCurrentPositionSoundMem(soundHandle);
    --================================================================
    local hour = 0;
    local min  = 0;
    local sec  = 0;
    local msec = 0;
    --================================================================
    if (  currentSample ~= -1) -- if -1 , none loading sound handle.
    then 
        allsec = math.floor(currentSample/sampleingRate);
        hour = math.floor(allsec/360); 
        min  = math.floor(allsec/60); 
        sec  = math.mod(allsec,60);
        msec = math.mod(currentSample,sampleingRate)/sampleingRate *100
    end 
    --================================================================
    local timeText =string.format("%i:%i:%i", min ,sec,msec)
    --================================================================
    return timeText;
end
--====================================================================

