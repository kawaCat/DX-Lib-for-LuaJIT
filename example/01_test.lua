
--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
local bit = require("bit")
--====================================================================
local screenW = 550;
local screenH = 350;

-- init
--====================================================================
function init ()
    -- init
    DxLib.dx_ChangeWindowMode(true)
    DxLib.dx_SetGraphMode( screenW, screenH, 32,-1) ;
    DxLib.dx_SetOutApplicationLogValidFlag(true)
    DxLib.dx_SetAlwaysRunFlag(true)
    DxLib.dx_SetBackgroundColor(255,255,255) --white 
    --================================================================
    DxLib.dx_DxLib_Init();
    --================================================================
end 
--====================================================================

-- init ,setup Dx Library
init ()
--====================================================================

-- for store mouse point
local mouseX = ffi.new("int[1]");
local mouseY = ffi.new("int[1]");

-- font
DxLib.dx_ChangeFont( "Arial" ,-1) ;
DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) 
local fontSize = 15

-- for animation
local count =0;

--====================================================================
function drawBackGround(width,height)
    --================================================================
    local num = 10;
    local rectWidth =width /num;
    local rectHeight = height;
    --================================================================
    for i=0,num-1
    do
        DxLib.dx_DrawBox( rectWidth *i
                         ,0
                         ,rectWidth *(i+1)
                         ,rectHeight
                         ,DxLib.dx_GetColor(255/num *(i+1),255,255)
                         ,true
                        )
    end 
end 
--====================================================================

-- main loop
--====================================================================
while ( DxLib.dx_ProcessMessage() == 0  and
        DxLib.dx_CheckHitKey( DxLib.KEY_INPUT_ESCAPE ) == 0 )
do
    DxLib.dx_SetDrawScreen( DxLib.DX_SCREEN_BACK )
    DxLib.dx_ClearDrawScreen(nil)
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    DxLib.dx_SetDrawBlendMode(DxLib.DX_BLENDMODE_ALPHA,255)
    --================================================================
    drawBackGround(screenW,screenH)
    --================================================================
    
    -- Mouse Point
    DxLib.dx_GetMousePoint(mouseX,mouseY);
    local str ="MousePoint :" .. mouseX[0] .. ":" .. mouseY[0];
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
    local move = math.abs(math.sin(math.rad(count)) * 100 );
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
    -- animation count
    count = count+1.5
    if ( count >= 360)
    then
        count =0;
    end 
    
    --================================================================
    DxLib.dx_ScreenFlip()
end
--====================================================================
DxLib.dx_DxLib_End()
--====================================================================

