--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
local bit = require("bit")
--====================================================================
package.path = package.path ..";".."example/?.lua;"
--====================================================================
require("fpsLimit")
require("LoadFont")
require("MultiByteString")
--====================================================================
ffi.cdef(
[[
    int strcmp (const char *string1, const char *string2);
    char * strcpy ( char * destination, const char * source ) ; 
    int printf(const char *fmt, ...);
    int memcmp(const void *buf1, const void *buf2,size_t n);
]] )
--====================================================================
local screenW = 550;
local screenH = 350;
--====================================================================
function init ()
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
-- init ,setup Dx Library
init ();
--====================================================================

-- for store mouse point
local mouseX = ffi.new("int[1]");
local mouseY = ffi.new("int[1]");
DxLib.dx_GetMousePoint(mouseX,mouseY);
local lastMouseX = mouseX[0];
local lastMouseY = mouseY[0];
local newMouseInput = 0;
local lastMouseInput = 0;
local newMouseWheel = 0;
local lastMouseWheel = 0;

-- keyboard
local newKeyState =ffi.new("char[256]");
local lastKeyState =ffi.new("char[256]");
DxLib.dx_GetHitKeyStateAll( newKeyState );
DxLib.dx_GetHitKeyStateAll( lastKeyState );

-- font
local jpFontSize = 23
local dxFontHandle = DxLib.dx_LoadFontDataToHandle( "resources/sample.dft", 0 ); --prepared font
local loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
local fontSize = 20
DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING)

-- set CharCode to fontHandle
DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,dxFontHandle)

-- for animation 
local count = 0;
local newTime =DxLib.dx_GetNowCount(false);
local lastTime =newTime;

-- fps
local fpsLimit = createFpsLimit();

--====================================================================
local makeScreenW = screenW/2
local makeScreenH = screenH/2
-- this screen can draw target.
local screenHandle = DxLib.dx_MakeScreen( makeScreenW -- width
                                        , makeScreenH -- height
                                        , true ) ;    -- UseAlphaChannel
local penImage = DxLib.dx_LoadGraph( "resources/pen.png", false );                                  
--====================================================================
function drawImageToScreen()
    -- change drawTarget 
    DxLib.dx_SetDrawScreen( screenHandle )
    
    -- clear fill 
    DxLib.dx_ClearDrawScreen(nil) 
    --================================================================
    
    --draw image to screenHandle 
    local num = 20;
    for i=1,num
    do
        DxLib.dx_DrawRotaGraph( makeScreenW*math.random()
                              , makeScreenH*math.random()
                              , math.random()*0.2 +0.2
                              , math.rad(360*math.random())
                              , penImage 
                              , true     -- TransFlag,  
                              , false ); -- invert flag (  TurnFlag)
    end 
    
    -- restore drawTarget screen
    DxLib.dx_SetDrawScreen( DxLib.DX_SCREEN_BACK );
end 
--====================================================================

--prepare draw before main loop
drawImageToScreen();

--menu test
DxLib.dx_SetUseMenuFlag(true); 
--====================================================================
DxLib.dx_AddMenuItem( DxLib.MENUITEM_ADD_INSERT
                    , ""         -- parrent ItemNameID
                    , -1         -- parrent ItemID 
                    , false      -- SeparatorFlag
                    , "Menu"     -- add menuName
                    , 12345 ) ;  -- add menuID
--====================================================================       
DxLib.dx_AddMenuItem( DxLib.MENUITEM_ADD_CHILD  
                    , "Menu"     -- parrent ItemNameID
                    , 12345      -- parrent ItemID 
                    , false      -- SeparatorFlag
                    , "Child"    -- add menuName
                    , 12346 ) ;  -- add menuID
--====================================================================
-- menu select check at onUpdate.

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
    return nowBlendMode,nowBlendModeParam
end
--====================================================================

--====================================================================
function onMouseMove(mouseX,mouseY)end 
--====================================================================
function onMousePress(MouseEvent,mouseX,mouseY)
    -- redraw
    drawImageToScreen();
end
--====================================================================
function onMouseRelease(MouseEvent,mouseX,mouseY)end
--====================================================================
function onMouseWheel(rotValue)end
--====================================================================
function onKeyboardPress(KeyEvent)end
--====================================================================
function onKeyBoardRelease(KeyEvent)end 
--====================================================================
function onUpdate(dt)
    --================================================================
    count = count+dt/3.5
    --================================================================
    if ( count >1.0)
    then
        count =0;
    end 
    --================================================================
    -- check menu select
    --================================================================
    if (DxLib.dx_CheckMenuItemSelect( "Child", 12346 ) == 1)
    then
        print ( "Child menu clicked")
    end 
end 
--====================================================================
function onDraw(dt)
    --================================================================
    drawBackGround(screenW,screenH)
    --================================================================
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ADD , 255 ) ;
    --================================================================
    drawSineCurve(15,count)
    drawCicle(20,count,0,screenH,100,DxLib.dx_GetColor(100,100,180))
    drawCicle(20,count,screenW,0,100)
    drawCicle(20,count,mouseX[0],mouseY[0],30)
    --================================================================
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
    
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    
    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. mouseX[0] .. ":" .. mouseY[0];
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,10, 10);
    
    --================================================================
    str ="make Screen test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, screenH-20);
    
    --fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, 10 );
    --================================================================
    
    local sineMod = math.sin(math.pi*2*count)
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255*math.abs(sineMod)) ;
    
    --draw screen
    drawImage( screenHandle
             , makeScreenW/2
             , makeScreenH
             , 1 +0.5 * sineMod
             , (math.pi*2) * count  ) -- math.rad(360*count)
    
    drawImage( screenHandle
             , makeScreenW +makeScreenW/2
             , makeScreenH
             , 1 -0.5 * sineMod
             , (math.pi*2) * count  ) 
    
end
--====================================================================
function onExit()
    --================================================================
    -- delete font resource
    loadedFont:destroy();
end
--====================================================================

--====================================================================
-- main loop
--====================================================================
while ( DxLib.dx_ProcessMessage() == 0  and
        DxLib.dx_CheckHitKey( DxLib.KEY_INPUT_ESCAPE ) == 0 )
do
    -- update process Time;
    newTime =DxLib.dx_GetNowCount(false);
    
    -- prepare
    --================================================================
    DxLib.dx_SetDrawScreen( DxLib.DX_SCREEN_BACK )
    DxLib.dx_ClearDrawScreen(nil)
    --================================================================
    DxLib.dx_SetDrawBlendMode(DxLib.DX_BLENDMODE_ALPHA,255)
    --================================================================
    
    -- Mouse Point
    DxLib.dx_GetMousePoint(mouseX,mouseY);
    if (lastMouseX ~=mouseX[0] or lastMouseY ~= mouseY[0] )
    then
        onMouseMove(mouseX[0], mouseY[0]);
    end
    lastMouseX = mouseX[0];
    lastMouseY = mouseY[0];
    --================================================================
    
    -- mouse wheel
    newMouseWheel = DxLib.dx_GetMouseWheelRotVol(true)
    if ( lastMouseWheel ~= newMouseWheel )
    then 
        onMouseWheel ( newMouseWheel );
    end
    lastMouseWheel = newMouseWheel;
    --================================================================
    
    -- Mouse Input
    newMouseInput = DxLib.dx_GetMouseInput();
    if ( lastMouseInput ~= newMouseInput )
    then
        if ( lastMouseInput < newMouseInput )
        then 
            onMousePress ( newMouseInput,mouseX,mouseY )
        else
            onMouseRelease ( newMouseInput,mouseX,mouseY )
        end
    end
    lastMouseInput = DxLib.dx_GetMouseInput();
    --================================================================

    -- keyboard
    DxLib.dx_GetHitKeyStateAll( newKeyState ) ;
    --================================================================
    --if ( ffi.C.strcmp (lastKeyState,newKeyState) ~= 0)
    if ( ffi.C.memcmp (lastKeyState,newKeyState,256) ~= 0)
    then 
        --============================================================
        local lastSum = 0;
        local newSum =0;
        for i=0,256-1
        do
            lastSum = lastSum + lastKeyState[i]
            newSum  = newSum + newKeyState[i]
            --========================================================
            -- check max keyboard press num.
            if (lastSum > 4 )
            then 
                break;
            end
        end
        --============================================================
        -- newSum is keyPressed num.
        if (lastSum  < newSum )
        then
            onKeyboardPress(newKeyState);
        else
            onKeyBoardRelease(newKeyState)
        end
        --============================================================
        ffi.copy(lastKeyState, newKeyState,256 )
    end 
    --================================================================
    
    -- update
    local dt = (newTime - lastTime)/1000 ; -- sec
    onUpdate(dt);
    
    -- draw
    onDraw(dt)
    --================================================================

    --================================================================
    lastTime =newTime;
    --================================================================
    DxLib.dx_ScreenFlip()
    --================================================================
    fpsLimit:limitFps(58) --test
end
--====================================================================
onExit()
--====================================================================
DxLib.dx_DxLib_End();
--====================================================================
