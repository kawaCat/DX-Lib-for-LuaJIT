
--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
local bit = require("bit")
--====================================================================
package.path = package.path ..";".."example/?.lua;"
--====================================================================
require("fpsLimit")
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
    --xLib.dx_SetFullSceneAntiAliasingMode(4,2)  --anti Alias
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
local isMousePress = false
local isMouseDrag =false

-- font
DxLib.dx_ChangeFont( "Arial" ,-1) ;
DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING)
local fontSize = 20

-- keyboard
local newKeyState =ffi.new("char[256]");
local lastKeyState =ffi.new("char[256]");
DxLib.dx_GetHitKeyStateAll( newKeyState );
DxLib.dx_GetHitKeyStateAll( lastKeyState );

-- draw flag
local isMouseLeftPress =false;
local isMouseRightPress =false;
local isMouseMiddlePress =false;
local isKeyPress =false;
local mouseWheelValue = 0;

-- for animation 
local count = 0;
local newTime =DxLib.dx_GetNowCount(false);
local lastTime =newTime;

-- fps
local fpsLimit = createFpsLimit();

--====================================================================
function drawBackGround(width,height)
    --================================================================
    local num = 20;
    local rectWidth =width /num;
    local rectHeight = height;
    --================================================================
    for i=0,num-1
    do
        DxLib.dx_DrawBox( rectWidth *i
            ,0
            ,rectWidth *(i+1)
            ,rectHeight
            ,DxLib.dx_GetColor(255/num *(i+1),255/num *(i+1),255)
            ,true
        )
    end
end
--====================================================================

--====================================================================
function drawSineCurve(num,dt)
    --================================================================
    for i=0,num
    do
        local phase = (360 *dt) -360 /15 *i
        local moveWidth = (screenH/4)
        local x1 = screenW/num * i
        local y1 = screenH /2 + moveWidth*(math.sin(math.rad(phase)) )
        local r = 5
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

--====================================================================
function onMouseDrag(MouseEvent,mouseX,mouseY)
    --print ("mouseDrag");
end 
--====================================================================

--====================================================================
function onMouseMove(mouseX,mouseY)
    --print ("mouse Move")
end 
--====================================================================

--====================================================================
function onMousePress(MouseEvent,mouseX,mouseY)
    --print ("press",MouseEvent) 
    if ( bit.band(newMouseInput,DxLib.MOUSE_INPUT_LEFT) ~= 0 )
    then 
        isMouseLeftPress =true;
    end
    
    if ( bit.band(newMouseInput,DxLib.MOUSE_INPUT_RIGHT) ~= 0 )
    then 
        isMouseRightPress =true;
    end
    
    if ( bit.band(newMouseInput,DxLib.MOUSE_INPUT_MIDDLE) ~= 0 )
    then 
        isMouseMiddlePress =true;
    end
end
--====================================================================

--====================================================================
function onMouseRelease(MouseEvent,mouseX,mouseY)
    --print ("release",MouseEvent) 
    if ( bit.band(newMouseInput,DxLib.MOUSE_INPUT_LEFT) == 0 )
    then 
        isMouseLeftPress =false;
    end
    
    if ( bit.band(newMouseInput,DxLib.MOUSE_INPUT_RIGHT) == 0 )
    then 
        isMouseRightPress =false;
    end
    
    if ( bit.band(newMouseInput,DxLib.MOUSE_INPUT_MIDDLE) == 0 )
    then 
        isMouseMiddlePress =false;
    end
end
--====================================================================

--====================================================================
function onMouseWheel(rotValue)
    mouseWheelValue = rotValue;
end
--====================================================================

--====================================================================
function onKeyboardPress(KeyEvent)
    --================================================================
    -- print ("key press")
    -- if ( KeyEvent[DxLib.KEY_INPUT_Z]==1 ) 
    -- then
    --      print ("press Z key")
    -- end 
    isKeyPress =true;
end
--====================================================================

--====================================================================
function onKeyBoardRelease(KeyEvent)
    --print ("key Release")
    isKeyPress =false;
end 
--====================================================================

--====================================================================
function onUpdate(dt)
    --================================================================
    count = count+dt/3
    --================================================================
    if ( count >1.0)
    then
        count =0;
    end 
end 
--====================================================================

--====================================================================
function onDraw(dt)
    
    drawBackGround(screenW,screenH)
    drawSineCurve(20,count);
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    
    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. mouseX[0] .. ":" .. mouseY[0];
    DxLib.dx_DrawString( 10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    
    -- Mouse press 
    --================================================================
    if ( isMouseLeftPress == true )
    then 
        str ="Mouse Left Press "
        DxLib.dx_DrawString( 10, 10 + fontSize, str, DxLib.dx_GetColor(0,0,0), -1 );
    end
   
    if ( isMouseRightPress == true )
    then 
        str ="Mouse Right Press "
        DxLib.dx_DrawString( 10, 10 + fontSize*2, str, DxLib.dx_GetColor(0,0,0), -1 );
    end
    
    if ( isMouseMiddlePress == true )
    then 
        str ="Mouse Middle Press "
        DxLib.dx_DrawString( 10, 10 + fontSize*3, str, DxLib.dx_GetColor(0,0,0), -1 );
    end
    
    if ( mouseWheelValue ~= 0 )
    then
        str ="Mouse Wheel"
        DxLib.dx_DrawString( 10, 10 + fontSize*4, str, DxLib.dx_GetColor(0,0,0), -1 );
    end 
    
    -- keyBoard
    --================================================================
    if( isKeyPress ==true)
    then
        str ="keyBoard press "
        DxLib.dx_DrawString( 10, 10 + fontSize*5, str, DxLib.dx_GetColor(0,0,0), -1 );
    end 
    
    -- 
    --================================================================
    DxLib.dx_SetFontSize(15);
    str ="Click and Wheel, KeyBoard test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( screenW-strWidth-10, screenH-20, str, DxLib.dx_GetColor(0,0,0), -1 );
   
    -- fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( screenW-strWidth-10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
end
--====================================================================

--====================================================================
function onExit()end 
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
        if (isMousePress == true )
        then 
            onMouseDrag(lastMouseInput,mouseX[0], mouseY[0])
        end 
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
            onMousePress ( newMouseInput,mouseX[0],mouseY [0])
            isMousePress = true
        else
            onMouseRelease ( newMouseInput,mouseX[0],mouseY[0] )
            isMousePress = false
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
    fpsLimit:limitFps(58)
end
--====================================================================
onExit()
--====================================================================
DxLib.dx_DxLib_End()
--====================================================================
