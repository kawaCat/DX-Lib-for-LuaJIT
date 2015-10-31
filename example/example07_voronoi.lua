--====================================================================
-- this voronoi algolism is 
-- https://github.com/camconn/voronoi
-- thanks camconn.
-- and this algolism's license GNU Public License.
--====================================================================

--====================================================================
math.randomseed(os.clock());
--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
--====================================================================
package.path = package.path ..";".."example/?.lua;"
--====================================================================
local App = require("App");
require("LoadFont")
require("fpsLimit");
require("Voronoi")
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

-- for save software Image. call at onExit()
local outFile = "test.png" --save image file path
local voronoiW =400;
local voronoiH =200;
local voronoiImage = nil -- create in App.prepare().

--====================================================================
function createVoronoiImage(w,h)
    --================================================================
    local width_ = w;
    local height_ =h
    local softWareImage = DxLib.dx_MakeSoftImage( width_,height_ );
    local voronoi = createVoronoi(width_,height_);
    --================================================================
    voronoi:setNumPoints(1000); --slow
    --voronoi:setNumPoints(100); --fast
    --================================================================
    voronoi:setColorTable(createHsvColor(0.9));
    --================================================================
    local piexlTable = voronoi:getPixelTable();
    --================================================================
     -- direct draw pixel 
    local pos = 1;
    for y=0 ,height_-1
    do 
        for x =0,width_-1
        do
            local r =  piexlTable[pos].r   
            local g =  piexlTable[pos].g   
            local b =  piexlTable[pos].b   
            local a =  255
            --========================================================
            -- draw pixel to softWareImageHandle
            DxLib.dx_DrawPixelSoftImage(  softWareImage
                                        , x
                                        , y
                                        , r
                                        , g
                                        , b
                                        , a
                                        )
            pos = pos +1;
            --========================================================
        end
    end 
    --================================================================
    return softWareImage;
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
    --DxLib.dx_SetFullSceneAntiAliasingMode(4,2)  --anti Alias
    --================================================================
    DxLib.dx_DxLib_Init();
    --================================================================
end
--====================================================================
function App.prepare()
    
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
    
    -- create Voronoi and store software image handle.
    voronoiImage = createVoronoiImage(voronoiW,voronoiH);
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
    --================================================================
    
    -- draw voronoi image frame line
    local frameWidth = 3
    DxLib.dx_DrawBox( screenW/2-voronoiW/2 -frameWidth --x1
                    , screenH/2-voronoiH/2 -frameWidth --y1
                    , screenW/2-voronoiW/2 + voronoiW +frameWidth --x2
                    , screenH/2-voronoiH/2 + voronoiH +frameWidth --y2
                    , DxLib.dx_GetColor( 0,60,0 )
                    , true --fillflag
                )
                
    -- draw voronoi software image
    DxLib.dx_DrawSoftImage( screenW/2-voronoiW/2, screenH/2-voronoiH/2, voronoiImage ) ;
    
    --================================================================
    --drawSineCurve(20,count);
    drawCicle(20,count,App.mouseX,App.mouseY,30)
    drawCicle(20,count,0,screenH,100,DxLib.dx_GetColor(100,100,180))
    drawCicle(20,count,screenW,0,100)
   
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    
    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. App.mouseX .. ":" .. App.mouseY;
    DxLib.dx_DrawString( 10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    
    --================================================================
    str ="voronoi graph test"
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
    -- save To png file
    DxLib.dx_SaveSoftImageToPng( outFile, voronoiImage,4) ;
    
    --================================================================
    -- delete software image
    DxLib.dx_DeleteSoftImage( voronoiImage ) ;
    
    --================================================================
    -- delete font resource
    loadedFont:destroy();
end
--====================================================================

--====================================================================
App.run();
--====================================================================
