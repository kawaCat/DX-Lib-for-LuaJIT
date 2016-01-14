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
local loadedFont = nil  
local fontSize = 20

-- for animation 
local count = 0;

-- fps
local fpsLimit = createFpsLimit();
--====================================================================

-- store dropfile path
local dropFilePath_Table ={};
local captionText = nil;
local captionTextWidth = nil;
local fontHandle = nil;

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
    DxLib.dx_DragFileInfoClear();  
    DxLib.dx_SetDragFileValidFlag(true)
end
--====================================================================
function App.prepare()
    
    loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
    DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
    fontSize = 20
    fontHandle = DxLib.dx_CreateFontToHandle( "DS Siena Black" -- japanese font
                                              , fontSize
                                              , 0
                                              , DxLib.DX_FONTTYPE_ANTIALIASING
                                              , -1
                                              , 0
                                              , false
                                              , false
                                              )
    
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) --draw font type.
    local str ="file Drop test";
    
    captionText =  createTextImage(str,25)
end
--====================================================================
function App.onMouseDrag(MouseEvent,mouseX,mouseY)end 
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)end
--====================================================================
function App.onUpdate(dt)
    --================================================================
    count = count + (dt/2)
    --================================================================
    if ( count >1.0)
    then
        count =0;
    end 
    --================================================================
    
    --================================================================
    if ( DxLib.dx_GetDragFileNum( ) >=1 ) 
    then
        dropFilePath_Table ={}
        while ( DxLib.dx_GetDragFileNum() >0)
        do 
            local filepath = ffi.new ("TCHAR[256]");
            DxLib.dx_GetDragFilePath( filepath );
            table.insert (dropFilePath_Table,ffi.string(filepath));
        end
        DxLib.dx_DragFileInfoClear();   -- ドロップファイル情報の初期化
    end 
end 
--====================================================================
function App.onDraw(dt)
    --================================================================
    drawBackGround(screenW,screenH,1)
    --================================================================
    -- circle
    --================================================================
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ADD , 255 ) ;
    drawSineCurve(15,count,screenW,screenH)
    drawCicle(20,count,0,screenH,100,DxLib.dx_GetColor(100,100,180))
    drawCicle(20,count,screenW,0,100)
   
    --================================================================
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    
    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. App.mouseX .. ":" .. App.mouseY;
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,10, 10);
    
    --================================================================
    str ="file drop test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, screenH-20);
    
    --fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, 10 );
    --================================================================
  
    drawImage(captionText,screenW/2,screenH/2-fontSize/2,1+0.2*math.sin(math.pi*2*count),0)
    
    -- mouse point circle
    --================================================================
    drawCicle(20,count,App.mouseX,App.mouseY,30)
    
    for i=1 ,#dropFilePath_Table
    do
        drawStringToHandle( tostring(i)..":".. dropFilePath_Table[i]
                          , 10
                          , 20 *i+15
                          , fontHandle );
    end 
    
    --================================================================
    fpsLimit:limitFps(60)
end
--====================================================================
function App.onExit()
    loadedFont:destroy();
end
--====================================================================

--====================================================================
App.run();
--====================================================================




