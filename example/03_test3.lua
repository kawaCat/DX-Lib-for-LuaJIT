
--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
local bit = require("bit")
--====================================================================

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
    DxLib.dx_SetUseZBuffer3D( true ) ;
    DxLib.dx_SetWriteZBuffer3D( true ) ;
end
--====================================================================
init ();
--====================================================================

-- for store mouse point
local mouseX = ffi.new("int[1]");
local mouseY = ffi.new("int[1]");
local lastMouseInput = 0;

-- font
DxLib.dx_ChangeFont( "Arial" ,-1) ;
DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING)
local fontSize = 20

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
                         ,DxLib.dx_GetColor(255/num *(i+1),255/num *(i+1),255)
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
    DxLib.dx_SetDrawBlendMode(DxLib.DX_BLENDMODE_ALPHA,255)
    --================================================================
    drawBackGround(screenW,screenH)
    --================================================================

    --================================================================
    --3D
    --================================================================

    -- camera
    DxLib.dx_SetCameraNearFar( 1.0, 30.0 ) ;
    DxLib.dx_SetCameraPositionAndTarget_UpVecY( DxLib.dx_VGet( 0, 0, 0 ) --position
                                              , DxLib.dx_VGet( 0, 0, 1)  --target
                                              ) ;

    -- light
    -- DxLib.dx_SetUseLighting( false) ;
    DxLib.dx_SetLightDirection( DxLib.dx_VGet( 0.0, 0.0, 1.0 ) ) ;
    DxLib.dx_SetLightPosition( DxLib.dx_VGet( 0, 0, 0.0 ) ) ;

    --draw sphire
    DxLib.dx_DrawSphere3D( DxLib.dx_VGet( 0, -0.5, 5 )  -- position
                         , 2 + 1 * ( mouseX[0]/screenW )-- radius
                         , 20 --divnum
                         , DxLib.dx_GetColor( 255,255,255 )
                         , DxLib.dx_GetColor( 0, 0, 0 )
                         , true) ;
    --================================================================

    -- Mouse Point
    DxLib.dx_GetMousePoint(mouseX,mouseY);
    DxLib.dx_SetFontSize(fontSize);
    local str ="MousePoint :" .. mouseX[0] .. ":" .. mouseY[0];
    DxLib.dx_DrawString( 10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    --================================================================

    -- Mouse Input
    if (    lastMouseInput ~= DxLib.dx_GetMouseInput()
        and bit.band(DxLib.dx_GetMouseInput(),DxLib.MOUSE_INPUT_LEFT) ~= 0
        )
    then
        DxLib.dx_SetFontSize(fontSize);
        str ="Mouse Input "
        DxLib.dx_DrawString( 10, 10 + fontSize, str, DxLib.dx_GetColor(0,0,0), -1 );
    end
    --================================================================

    --================================================================
    lastMouseInput = DxLib.dx_GetMouseInput();
    --================================================================
    DxLib.dx_ScreenFlip()
end
--====================================================================
DxLib.dx_DxLib_End()
--====================================================================
