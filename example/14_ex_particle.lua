
--====================================================================
math.randomseed(os.clock())
--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
local App = require("exampleLib")
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

local isAnimationStart =false;

-- idel text Image
local idleTextImage = nil;

--particleImage 
local particleImage_Flare   = nil
local particleImage_Fire    = nil
local particleImage_Sakura  = nil
local particleImage_Sakura2 = nil
local particleManager = nil

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
    
    fontSize = 20
    dxFontHandle = DxLib.dx_LoadFontDataToHandle( "resources/sample.dft", 0 );
    loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
    DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) --draw font type.

    -- set CharCode to fontHandle
    DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,dxFontHandle)
    --================================================================

    -- create idle text image 
    DxLib.dx_SetFontSize(fontSize);
    local str="Left and Right"
    local textImageWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    idleTextImage = createTextImage(str,textImageWidth,fontSize);
    
    --particleImage 
    particleImage_Flare   = DxLib.dx_LoadGraph( "resources/Flare_White.png", false ); 
    particleImage_Fire    = DxLib.dx_LoadGraph( "resources/fire.png", false ); 
    particleImage_Sakura  = DxLib.dx_LoadGraph( "resources/sakura.png", false ); 
    particleImage_Sakura2 = DxLib.dx_LoadGraph( "resources/sakura02.png", false ); 
    
    particleManager = createParticleManager();
    --================================================================
end
--====================================================================
function App.onMouseDrag(MouseEvent,mouseX,mouseY)
    --================================================================
    if ( App.isMouseLeftPress==true)
    then
        local isAdd = particleManager:addPartcileType3(particleImage_Flare,App.mouseX,App.mouseY,5)
        if ( isAdd == true )
        then
            particleManager:addPartcileType1(particleImage_Sakura ,App.mouseX,App.mouseY,5,true)
            particleManager:addPartcileType1(particleImage_Sakura2,App.mouseX,App.mouseY,5,true)
        end  
    end
    --================================================================
    if ( App.isMouseRightPress ==true)
    then
        local isAdd = particleManager:addPartcileType2(particleImage_Fire,App.mouseX,App.mouseY,5)
        if ( isAdd == true )
        then
            particleManager:addPartcileType4(particleImage_Flare,App.mouseX,App.mouseY,5,true)
        end
    end 
    --================================================================
end 
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)
    App.onMouseDrag(MouseEvent,mouseX,mouseY)
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
end 
--====================================================================
function App.onDraw(dt)
    --================================================================
    drawBackGround(screenW,screenH,2)
    --================================================================
   
    -- circle
    --================================================================
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ADD , 255 ) ;
    --================================================================
    drawSineCurve(15,count,screenW,screenH)
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
    str ="particle"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, screenH-20);
    
    --fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, 10 );
    --================================================================
    
    --particle
    --================================================================
    if ( math.floor(math.random()*60*4) < 10)
    then 
        local x =  screenW/2 + (math.random()-0.5)*screenW/2 
        local y =  screenH/2 + (math.random()-0.5)*screenH/2 


        local num = 20 *math.random()
        local isAdd =particleManager:addPartcileType3(particleImage_Flare,x,y,num)
    end 
    --================================================================
    
    particleManager:updateAndDraw();
    
    --================================================================
    str = string.format ("num:%i",particleManager:getParticleNum())
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false)
    drawString( str ,screenW-strWidth-10, 33);
    
    --================================================================
    if (isAnimationStart ==false) 
    then 
        local sinMod = math.abs(math.sin(math.pi*2*count))
        drawImage(idleTextImage,screenW/2 ,screenH/2 ,1+ 0.5*sinMod);
    end
    --================================================================
    
    --================================================================
    -- fps
    --================================================================
    fpsLimit:limitFps(60)
end
--====================================================================
function App.onExit()
    loadedFont:destroy();
end
--====================================================================

--====================================================================
App.run()
--====================================================================
