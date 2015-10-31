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
local fontSize = 20

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
    -- need call after dx_DxLib_Init()
    -- enable zBuffer
    DxLib.dx_SetUseZBuffer3D( true ) ;
    -- enable writing Zbuffer
    DxLib.dx_SetWriteZBuffer3D( true ) ;
end
--====================================================================
function App.prepare()
    DxLib.dx_ChangeFont( "Arial" ,-1) ;
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) 
end
--====================================================================
function App.onUpdate(dt)end 
--====================================================================
function App.onDraw(dt)
    
    -- background
    drawBackGround(screenW,screenH,2)
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
                         , 2 + 1 * ( App.mouseX/screenW )-- radius
                         , 20 --divnum
                         , DxLib.dx_GetColor( 255,255,255 )
                         , DxLib.dx_GetColor( 0, 0, 0 )
                         , true) ;
    --================================================================

    -- Mouse Point
    DxLib.dx_SetFontSize(fontSize);
    local str ="MousePoint :" .. App.mouseX .. ":" .. App.mouseY;
    DxLib.dx_DrawString( 10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    --================================================================

    -- Mouse Input
    if (App.isMousePress == true)
    then
        str ="Mouse Input "
        DxLib.dx_DrawString( 10, 10 + fontSize, str, DxLib.dx_GetColor(0,0,0), -1 );
    end
    --================================================================
end
--====================================================================
function App.onExit()end
--====================================================================

--====================================================================
App.run()
--====================================================================
