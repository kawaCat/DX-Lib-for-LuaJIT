--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
--====================================================================
package.path = package.path ..";".."example/?.lua;"
--====================================================================
local App = require("App");
require("fpsLimit");
--====================================================================

local screenW = 550;
local screenH = 350;

-- font
local fontSize = 20

-- for animation 
local count = 0;

-- fps
local fpsLimit = createFpsLimit();

--====================================================================
function App.init ()
    -- default init
    DxLib.dx_ChangeWindowMode(true)
    DxLib.dx_SetGraphMode( screenW, screenH, 32,-1) ; -- window size
    DxLib.dx_SetOutApplicationLogValidFlag(false)
    DxLib.dx_SetAlwaysRunFlag(true)
    DxLib.dx_SetBackgroundColor(255,255,255)
    --================================================================
    -- DxLib.dx_SetFullSceneAntiAliasingMode(4,2)  -- enable anti Alias
    --================================================================
    DxLib.dx_DxLib_Init();
    --================================================================
end
--====================================================================

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
function App.prepare()
    -- after dx_init()'s  setting.
    DxLib.dx_ChangeFont( "Arial" ,-1) ;
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING)
end
--====================================================================

--====================================================================
function App.onKeyboardPress(KeyEvent)
    --================================================================
    -- print ("key press")
    -- if ( KeyEvent[DxLib.KEY_INPUT_Z]==1 ) 
    -- then
    --      print ("press Z key")
    -- end 
end
--====================================================================

--====================================================================
function App.onUpdate(dt)
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
function App.onDraw(dt)
    
    drawBackGround(screenW,screenH)
    drawSineCurve(20,count);
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    
    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. App.mouseX .. ":" .. App.mouseY;
    DxLib.dx_DrawString( 10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    
    -- Mouse press 
    if ( App.isMouseLeftPress == true )
    then 
        str ="Mouse Left Press "
        DxLib.dx_DrawString( 10, 10 + fontSize, str, DxLib.dx_GetColor(0,0,0), -1 );
    end
   
    if ( App.isMouseRightPress == true )
    then 
        str ="Mouse Right Press "
        DxLib.dx_DrawString( 10, 10 + fontSize*2, str, DxLib.dx_GetColor(0,0,0), -1 );
    end
    
    if ( App.isMouseMiddlePress == true )
    then 
        str ="Mouse Middle Press "
        DxLib.dx_DrawString( 10, 10 + fontSize*3, str, DxLib.dx_GetColor(0,0,0), -1 );
    end
    
    if ( App.mouseWheelValue ~= 0 )
    then
        str ="Mouse Wheel"
        DxLib.dx_DrawString( 10, 10 + fontSize*4, str, DxLib.dx_GetColor(0,0,0), -1 );
    end 
    --================================================================
    
    -- keyBoard
    if( App.isKeyPress ==true)
    then
        str ="keyBoard press "
        DxLib.dx_DrawString( 10, 10 + fontSize*5, str, DxLib.dx_GetColor(0,0,0), -1 );
    end 
    --================================================================
    
    -- caption
    DxLib.dx_SetFontSize(15);
    str ="Click and Wheel, KeyBoard test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( screenW-strWidth-10, screenH-20, str, DxLib.dx_GetColor(0,0,0), -1 );
   
    -- fps 
    fpsLimit:limitFps(60);
    
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( screenW-strWidth-10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
end
--====================================================================

--====================================================================
App.run();
--====================================================================

