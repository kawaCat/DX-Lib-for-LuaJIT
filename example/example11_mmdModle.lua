--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
--====================================================================
package.path = package.path ..";".."example/?.lua;"
--====================================================================
local App = require("App");
require("fpsLimit")
require("LoadFont")
--====================================================================
local screenW = 550;
local screenH = 350;
--====================================================================

-- font
local jpFontSize = 23
local dxFontHandle = nil -- create App.preapre()
local loadedFont = nil   -- load and font Resource
local fontSize = 20

-- for animation 
local count = 0;

-- fps
local fpsLimit = createFpsLimit();
--====================================================================

-- mmd model
local modelHandle = nil -- create in prepare()
local attachAnimIndex = nil
local animationTime =0;
local totalAnimTime = nil
local animSpeed = 0.28
local isAnimationStart =false;

-- BGM
local soundHandle = nil;

-- idel text Image
local idleTextImage = nil;

--cameraPos
local cameraAnimCount = 0;

-- in mmd Model scaling OutLine DotWidth fix.
--====================================================================
function setMMDModelScale(pmdModel,newScale)
    --================================================================
    DxLib.dx_MV1SetScale(  pmdModel
                         , DxLib.dx_VGet( newScale,
                                          newScale,
                                          newScale))
    --================================================================
    local MaterialNum = DxLib.dx_MV1GetMaterialNum( pmdModel ) ; 
    for i=0 , MaterialNum 
    do
        -- get Material OutLine DotWidth (thickness)
        local dotwidth = DxLib.dx_MV1GetMaterialOutLineDotWidth(pmdModel, i ) ;  
        -- normalize OutLine DotWidth (thickness)
        local newDotWidth = dotwidth/newScale;
        if ( newDotWidth < 0)then newDotWidth =0 ;end
        if ( newDotWidth > 1)then newDotWidth =1 ;end
        --============================================================
        DxLib.dx_MV1SetMaterialOutLineDotWidth( pmdModel, i, newDotWidth) ;  
    end
end 
--====================================================================

-- create idle text image;
--====================================================================
function createTextImage(str,width_,fontSize_)
    DxLib.dx_SetFontSize(fontSize_);
    --================================================================
    local playMusicTextScreen = DxLib.dx_MakeScreen( width_
                                                   , fontSize_
                                                   , true ) ;    
    --================================================================
    DxLib.dx_SetDrawScreen( playMusicTextScreen )
    DxLib.dx_DrawString( 0, 0 ,str,DxLib.dx_GetColor(0,0,0),-1);
    --================================================================
    DxLib.dx_SetDrawScreen( DxLib.DX_SCREEN_BACK );
    --================================================================
    return  playMusicTextScreen;
end 
--====================================================================

--====================================================================
function drawBackGround(width,height)
    --================================================================
    local num = 20;
    local rectWidth = width /num;
    local rectHeight = height;
    --================================================================
    for i=0,num-1
    do
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
--====================================================================
function drawSineCurve(num,dt)
    --================================================================
    for i=0,num
    do
        local phase = (360 *dt) -360 /15 *i
        local moveWidth = (screenH/4)
        local x1 = screenW/num * i
        local y1 = screenH /2 + moveWidth*(math.sin(math.rad(phase)) )
        local r = 4
        local c = DxLib.dx_GetColor(150,0,255), true -- color,fillflag
        DxLib.dx_DrawCircle(  x1,y1,r,c,1,1);
        
        phase = phase -180
        local x2 = screenW/num * i
        local y2 = screenH /2 + moveWidth*(math.sin(math.rad(phase)) )
        DxLib.dx_DrawCircle(  x2,y2,r,c,1,1);
        
        --DxLib.dx_DrawLine  (  x1,y1,x2,y2,c,1);
    end 
end
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
function drawString(str,x,y,color)
    local color_ = color or DxLib.dx_GetColor(0,0,0)
    DxLib.dx_DrawString( x, y, str, color_ , -1 );
end 
--====================================================================
function drawStringToHandle(str,x,y,fontHandle,color)
    local color_ = color or DxLib.dx_GetColor(0,0,0)
    DxLib.dx_DrawStringToHandle( x, y, str, color_ ,fontHandle, -1 ,false);
end 
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
function getBGMTimeStr(soundHandle)
    -- 1sec sample num
    local sampleingRate = DxLib.dx_GetFrequencySoundMem(soundHandle);
    -- current sample position (playing position)
    local currentSample = DxLib.dx_GetCurrentPositionSoundMem(soundHandle);
    --================================================================
    local allsec = math.floor(currentSample/sampleingRate);
    local min = math.floor(allsec/60); -- .. hour?
    local sec = math.mod(allsec,60);
    local msec = math.mod(currentSample,sampleingRate)/sampleingRate *100
    --================================================================
    local timeText =string.format("%i:%i:%i", min ,sec,msec)
    --================================================================
    return timeText;
end
--====================================================================

--====================================================================
function App.init ()
    -- init
    DxLib.dx_ChangeWindowMode(true)
    DxLib.dx_SetGraphMode( screenW, screenH, 32,-1) ;
    DxLib.dx_SetOutApplicationLogValidFlag(false)
    DxLib.dx_SetAlwaysRunFlag(true)
    DxLib.dx_SetBackgroundColor(255,255,255)
    --================================================================
    DxLib.dx_SetFullSceneAntiAliasingMode(4,2)  --anti Alias
    --================================================================
    DxLib.dx_DxLib_Init();
    --================================================================
end
--====================================================================
function App.prepare()
    
    --prepared font. ".dft" was created font by DX Lib tools.
    dxFontHandle = DxLib.dx_LoadFontDataToHandle( "resources/sample.dft", 0 );
    
    -- load and font Resource
    -- need call  loadedFont:destory()  at app exit .
    loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
    DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
    fontSize = 20
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) --draw font type.

    -- set CharCode to fontHandle
    DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,dxFontHandle)
    --================================================================
    
    -- mmd model
    modelHandle = DxLib.dx_MV1LoadModel("resources/mmd_kinako/kinako.mv1" );
    attachAnimIndex = DxLib.dx_MV1AttachAnim( modelHandle, 11, -1, false ) 
    animationTime =0;
    totalAnimTime = DxLib.dx_MV1GetAttachAnimTotalTime( modelHandle, attachAnimIndex ) ;
    animSpeed = 0.28
    isAnimationStart =false;

    -- BGM
    -- streaming load
    DxLib.dx_SetCreateSoundDataType( DxLib.DX_SOUNDDATATYPE_FILE) 
    soundHandle = DxLib.dx_LoadSoundMem( "resources/underGround.ogg" ,3,-1)
    
    -- create idle text image 
    DxLib.dx_SetFontSize(fontSize);
    local str="Click Play Music"
    local textImageWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    idleTextImage = createTextImage(str,textImageWidth,fontSize);
end
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)
    if ( isAnimationStart ==true)
    then
        isAnimationStart =false
        DxLib.dx_ChangeVolumeSoundMem( 255*0.8, soundHandle);
        DxLib.dx_StopSoundMem(soundHandle);
    else
        isAnimationStart =true
        DxLib.dx_ChangeVolumeSoundMem( 255*0.8, soundHandle);
        DxLib.dx_PlaySoundMem(soundHandle,DxLib.DX_PLAYTYPE_LOOP,false);
    end 
end
--====================================================================
function App.onUpdate(dt)
    --================================================================
    count = count + (dt/3.5)
    --================================================================
    if ( count >1.0)
    then
        count =0;
    end 
    --================================================================
    cameraAnimCount = cameraAnimCount + (dt/5)
    if ( cameraAnimCount >1.0)
    then
        cameraAnimCount =0;
    end 
end 
--====================================================================
function App.onDraw(dt)
    --================================================================
    drawBackGround(screenW,screenH)
    --================================================================
    -- 3d
    -- position 
    local modelPosition  = DxLib.dx_VGet( 0, 0, 15)
    local cameraPosition = DxLib.dx_VGet( 0  + math.cos(math.pi*2*cameraAnimCount)*10
                                        , 5.5 
                                        , 0  + math.sin(math.pi*2*cameraAnimCount)*10)
    local cameraTargetPositon = DxLib.dx_VGet( 0, 5, 5)
   
    -- camera
    DxLib.dx_SetCameraNearFar( 1.0, 30.0 ) ;
    DxLib.dx_SetCameraPositionAndTarget_UpVecY( cameraPosition --position
                                              , cameraTargetPositon  --target
                                              ) ;
    -- light off
    DxLib.dx_SetUseLighting( false) ;
   
   
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 150 ) ;
    --================================================================
    setMMDModelScale( modelHandle,0.5)
    --set position
    DxLib.dx_MV1SetPosition(  modelHandle , modelPosition)
    --draw
    DxLib.dx_MV1DrawModel( modelHandle ) 
    --attach Animtime
    DxLib.dx_MV1SetAttachAnimTime( modelHandle,attachAnimIndex,animationTime )
    --================================================================
    if (isAnimationStart ==true)
    then 
        -- step animation Time
        animationTime = animationTime+animSpeed;
        if (animationTime > totalAnimTime)
        then 
            animationTime =0; -- loop
        end 
    end
    --================================================================
    
    -- circle
    --================================================================
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ADD , 255 ) ;
    --================================================================
    drawSineCurve(15,count)
    drawCicle(20,count,0,screenH,100,DxLib.dx_GetColor(100,100,180))
    drawCicle(20,count,screenW,0,100)
    drawCicle(20,count,App.mouseX,App.mouseY,30)
    --================================================================
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    
    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. App.mouseX .. ":" .. App.mouseY;
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,10, 10);
    
    --================================================================
    str ="MMD test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, screenH-20);
    
    --fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, 10 );
    --================================================================
    
    -- idel Text image
    if (isAnimationStart ==false) 
    then 
        local sinMod = math.abs(math.sin(math.pi*2*count))
        drawImage(idleTextImage,screenW/2 ,screenH/2 ,1+ 0.5*sinMod);
    end
    -- music time
    drawString( getBGMTimeStr(soundHandle),10, screenH-fontSize-10);
    --================================================================
    
    -- fps
    --================================================================
    fpsLimit:limitFps(60)
end
--====================================================================
function App.onExit()
    --================================================================
    DxLib.dx_MV1DeleteModel( modelHandle ) 
    --================================================================
    -- delete font resource
    loadedFont:destroy();
end
--====================================================================

--====================================================================
App.run()
--====================================================================
