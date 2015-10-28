
--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
--====================================================================
package.path = package.path ..";".."example/?.lua;"
--====================================================================
local App = require("App")
require("Draw")
--====================================================================
local screenW = 550;
local screenH = 350;
--====================================================================

-- font
local fontSize = 15

-- for animation
local count =0;

--====================================================================
function App.init ()
    -- init
    DxLib.dx_ChangeWindowMode(true)
    DxLib.dx_SetGraphMode( screenW, screenH, 32,-1) ;
    DxLib.dx_SetOutApplicationLogValidFlag(false)
    DxLib.dx_SetAlwaysRunFlag(true)
    DxLib.dx_SetBackgroundColor(255,255,255) --white 
    --================================================================
    DxLib.dx_DxLib_Init();
    --================================================================
end
--====================================================================
function App.prepare()
    DxLib.dx_ChangeFont( "Arial" ,-1) ;
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) 
end
--====================================================================
function App.onUpdate(dt)
    -- animation count
    count = count+dt/3
    if ( count >= 1)
    then
        count =0;
    end 
end 
--====================================================================
function App.onDraw(dt)
    -- background
    drawBackGround(screenW,screenH,2)
    
    -- Mouse Point
    local str ="MousePoint :" .. App.mouseX .. ":" .. App.mouseY;
    DxLib.dx_DrawString( 10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );    
    --================================================================
    
    -- Mouse Input
    if ( bit.band(DxLib.dx_GetMouseInput(),DxLib.MOUSE_INPUT_LEFT) ~= 0 )
    then 
        str ="Mouse Input "
        DxLib.dx_DrawString( 10, 10 + fontSize, str, DxLib.dx_GetColor(0,0,0), -1 );    
    end
    --================================================================
    
    -- draw Box
    DxLib.dx_DrawBox( 10     , 100 
                    , 10+300 , 100+100 
                    , DxLib.dx_GetColor(150,255,150),true)--color,fillflag
    DxLib.dx_SetDrawBlendMode(DxLib.DX_BLENDMODE_ALPHA,100)
    DxLib.dx_DrawBox( 60     , 160 
                    , 60+300 , 160+100 
                    , DxLib.dx_GetColor(255,0,0),true) --color,fillflag
    DxLib.dx_SetDrawBlendMode(DxLib.DX_BLENDMODE_ALPHA,255)
    
    -- drawCircle
    local move = math.abs(math.sin(math.rad(360 * count)) * 100 );
    local circleX = 200 + move
    local circleY = 200
    DxLib.dx_DrawCircle(  circleX, circleY
                        , 20 --radius
                        , DxLib.dx_GetColor(150,0,255), true -- color,fillflag
                        ,1);--linethickness
                    
    DxLib.dx_DrawLine  (  circleX
                        , circleY 
                        , screenW-160
                        , screenH -20
                        , DxLib.dx_GetColor(0,0,0)
                        , 1 ); -- thickness
    
    -- circle text
    str = string.format("circle:%.2f:%.2f",circleX,circleY);
    DxLib.dx_SetFontSize(12);
    DxLib.dx_DrawString(  screenW - 160
                        , screenH - 20
                        , str
                        , DxLib.dx_GetColor(0,0,0)
                        , -1 );  --edgeColor (-1 is none )
    --================================================================
end
--====================================================================
function App.onExit()end
--====================================================================

--====================================================================
App.run()
--====================================================================
