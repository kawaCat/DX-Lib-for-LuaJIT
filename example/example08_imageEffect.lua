--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
--====================================================================
package.path = package.path ..";".."example/?.lua;"
--====================================================================
local App = require("App");
require("LoadFont");
require("fpsLimit");
require("Draw")
--====================================================================
local screenW = 550;
local screenH = 350;
--====================================================================
-- font
local jpFontSize = 23
local dxFontHandle = nil -- create App.preapre()
local jpFontHandle = nil --
local loadedFont = nil   -- load and font Resource
local fontSize = 20

-- for animation 
local count = 0;

-- fps
local fpsLimit = createFpsLimit();
--====================================================================

-- imageHandle Table
local imageHandleTable = {} 

-- load and apply effect.
local blurGraph = nil
local monoGraph = nil
local invertGraph = nil
local isBlendMode_Sub =false;

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
    -- after dx_init()'s  setting.
    
    -- prepared font. ".dft" was created font by DX Lib tools.
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
    -- load and font Resource
    -- need call  loadedFont:destory()  at app exit .
    loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
    DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
    fontSize = 20
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) --draw font type.

    -- set CharCode to fontHandle
    DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,dxFontHandle)
    DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,jpFontHandle)
    --================================================================
    
    -- load and apply effect.
    blurGraph = DxLib.dx_LoadGraph( "resources/pen.png", false );
    DxLib.dx_GraphFilterS(blurGraph, DxLib.DX_GRAPH_FILTER_GAUSS,16,100 * 14,0,0,0,0 ) 
    table.insert (imageHandleTable,blurGraph )

    monoGraph = DxLib.dx_LoadGraph( "resources/pen.png", false );
    DxLib.dx_GraphFilterS(monoGraph, DxLib.DX_GRAPH_FILTER_MONO,16,-60,7,0,0,0 ) 
    table.insert (imageHandleTable,monoGraph )

    invertGraph = DxLib.dx_LoadGraph( "resources/pen.png", false );
    DxLib.dx_GraphFilterS(invertGraph, DxLib.DX_GRAPH_FILTER_INVERT,0,0,0,0,0,0 ) 
    table.insert (imageHandleTable,invertGraph )
end
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)
    if ( isBlendMode_Sub ==true )
    then
        isBlendMode_Sub =false
    else
        isBlendMode_Sub =true;
    end
end
--====================================================================
function App.onUpdate(dt)
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
    --drawSineCurve(20,count,screenW,screenH);
    --================================================================
    
    -- change blendmode
    if ( isBlendMode_Sub == true )
    then 
        DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_SUB , 255 ) ;
    else
        DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
    end 
    --================================================================
    -- draw image
    local xx = screenW/#imageHandleTable;
    local yy = screenH/2;
    
    for i=1,#imageHandleTable
    do
        drawImage(imageHandleTable[i], (xx*i) -xx/2,yy)
    end 
    --================================================================
    -- circle
    drawCicle(20,count,0,screenH,100,DxLib.dx_GetColor(100,100,180))
    drawCicle(20,count,screenW,0,100)
    
    -- mouse pointer
    drawCicle(20,count,App.mouseX,App.mouseY,30)
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    
    -- restore blendmode
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. App.mouseX .. ":" .. App.mouseY;
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( 10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    
    --================================================================
    str ="image Effect test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( screenW-strWidth-10, screenH-20, str, DxLib.dx_GetColor(0,0,0), -1 );
    
    -- fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( screenW-strWidth-10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    
    --================================================================
    if (isBlendMode_Sub == true )
    then 
        str ="blend Mode sub";
    else
        str ="blend Mode alpha";
    end 
    --================================================================
    DxLib.dx_SetFontSize(fontSize/1.5);
    strWidth =  DxLib.dx_GetDrawStringWidth(str,#str,false);
    DxLib.dx_DrawString( screenW-strWidth-10 , fontSize+15, str, DxLib.dx_GetColor(0,0,0), -1 );
    DxLib.dx_SetFontSize(fontSize);
    
    str ="テスト"; 
    DxLib.dx_DrawStringToHandle( 10, 35, str, DxLib.dx_GetColor(0,0,0),jpFontHandle, -1,false );
    --use dx font
    DxLib.dx_DrawStringToHandle( 10 , screenH-jpFontSize-10 , "あいうえお" , DxLib.dx_GetColor(0,0,0), dxFontHandle,-1,false) ;
    --================================================================
    fpsLimit:limitFps(60);
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
