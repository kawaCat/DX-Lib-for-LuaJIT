--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
--====================================================================
local App = require("exampleLib")
--====================================================================
local screenW = 550;
local screenH = 350;
--====================================================================

-- font
local jpFontSize = 23
local dxFontHandle = nil 
local jpFontHandle = nil 
local loadedFont = nil   
local fontSize = 20

-- for animation 
local count = 0;

-- fps
local fpsLimit = createFpsLimit();

--====================================================================
function App.init ()
    -- init
    DxLib.dx_ChangeWindowMode(true)
    DxLib.dx_SetGraphMode( screenW, screenH, 32,-1) ;
    DxLib.dx_SetOutApplicationLogValidFlag(false)
    DxLib.dx_SetAlwaysRunFlag(true)
    DxLib.dx_SetBackgroundColor(255,255,255)
    --================================================================
    --DxLib.dx_SetFullSceneAntiAliasingMode(4,2)  --anti Alias
    --================================================================
    DxLib.dx_DxLib_Init();
    --================================================================
end
--====================================================================
function App.prepare()
    
    dxFontHandle = DxLib.dx_LoadFontDataToHandle( "resources/sample.dft", 0 ); --prepared font
    jpFontHandle = DxLib.dx_CreateFontToHandle( "Ricty" -- japanese font
                                              , jpFontSize
                                              , 0
                                              , DxLib.DX_FONTTYPE_ANTIALIASING
                                              , -1
                                              , 0
                                              , false
                                              , false
                                              )
    -- need call  loadedFont:destory()  at app exit .
    loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
    DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
    fontSize = 20
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) --draw font type.

    -- set CharCode to fontHandle
    DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,dxFontHandle)
    DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,jpFontHandle)
end
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
function App.onDraw(dt)
    --================================================================
    drawBackGround(screenW,screenH,2)
    drawSineCurve(20,count,screenW,screenH);
    drawCicle(20,count,App.mouseX,App.mouseY,30)
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    
    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. App.mouseX .. ":" .. App.mouseY;
    DxLib.dx_DrawString( 10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    
    --================================================================
    str ="load font test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( screenW-strWidth-10, screenH-20, str, DxLib.dx_GetColor(0,0,0), -1 );
   
    -- fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( screenW-strWidth-10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    
    str ="テスト"; 
    DxLib.dx_DrawStringToHandle( 10, 35, str, DxLib.dx_GetColor(0,0,0),jpFontHandle, -1,false );
    --use dx font
    DxLib.dx_DrawStringToHandle( 10 , screenH-jpFontSize-10 , "あいうえお" , DxLib.dx_GetColor(0,0,0), dxFontHandle,-1,false) ;
    --================================================================
    fpsLimit:limitFps(60)
end
--====================================================================
function App.onExit()
    --================================================================
    -- delete font resource
    loadedFont:destroy();
end
--====================================================================

--====================================================================
App.run();
--====================================================================
