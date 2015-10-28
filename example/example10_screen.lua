--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
--====================================================================
package.path = package.path ..";".."example/?.lua;"
--====================================================================
local App = require("App");
require("fpsLimit")
require("LoadFont")
require("Draw")
--====================================================================
local screenW = 550;
local screenH = 350;
--====================================================================
-- font
local jpFontSize = 23
local dxFontHandle = nil -- create App.preapre()
local loadedFont = nil   -- load and font Resource
local fontSize = 20

-- for animation 
local count = 0;

-- fps
local fpsLimit = createFpsLimit();

--image Effect
local makeScreenW = screenW/2
local makeScreenH = screenH/2
local screenHandle = nil --create in prepare()
local penImage = nil   

-- draw To screen that was created by dx_MakeScreen() function
--====================================================================
function _drawImageToScreen()
    -- change drawTarget 
    DxLib.dx_SetDrawScreen( screenHandle )
    
    -- clear fill 
    DxLib.dx_ClearDrawScreen(nil) 
    --================================================================
    
    --draw image to screenHandle 
    local num = 20;
    for i=1,num
    do
        DxLib.dx_DrawRotaGraph( makeScreenW*math.random()
                              , makeScreenH*math.random()
                              , math.random()*0.2 +0.2
                              , math.rad(360*math.random())
                              , penImage 
                              , true     -- TransFlag,  
                              , false ); -- invert flag (  TurnFlag)
    end 
    
    -- restore drawTarget screen
    DxLib.dx_SetDrawScreen( DxLib.DX_SCREEN_BACK );
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
    DxLib.dx_SetFullSceneAntiAliasingMode(4,2)  --anti Alias
    --================================================================
    DxLib.dx_DxLib_Init();
    --================================================================
end
--====================================================================
function App.prepare()
    
    -- prepared font. ".dft" was created font by DX Lib tools.
    dxFontHandle = DxLib.dx_LoadFontDataToHandle( "resources/sample.dft", 0 );
    
    -- load and font Resource
    -- need call  loadedFont:destory()  at app exit .
    loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
    DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
    fontSize = 20
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) --draw font type.

    -- set CharCode to fontHandle
    DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,dxFontHandle)
    --================================================================
    
    screenHandle = DxLib.dx_MakeScreen( makeScreenW -- width
                                      , makeScreenH -- height
                                      , true ) ;    -- UseAlphaChannel
    penImage = DxLib.dx_LoadGraph( "resources/pen.png", false );  
    
    -- prepare draw before main loop
    _drawImageToScreen();

    --================================================================
    -- menu test -- menu select check at onUpdate.
    DxLib.dx_SetUseMenuFlag(true); 
    DxLib.dx_AddMenuItem( DxLib.MENUITEM_ADD_INSERT
                        , ""         -- parent ItemNameID
                        , -1         -- parent ItemID 
                        , false      -- SeparatorFlag
                        , "Menu"     -- add menuName
                        , 12345 ) ;  -- add menuID
         
    DxLib.dx_AddMenuItem( DxLib.MENUITEM_ADD_CHILD  
                        , "Menu"     -- parent ItemNameID
                        , 12345      -- parent ItemID 
                        , false      -- SeparatorFlag
                        , "Child"    -- add menuName
                        , 12346 ) ;  -- add menuID
    --================================================================
end
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)
    -- redraw
    _drawImageToScreen();
end
--====================================================================
function App.onUpdate(dt)
    --================================================================
    count = count+dt/3.5
    --================================================================
    if ( count >1.0)
    then
        count =0;
    end 
    --================================================================
    -- check menu select
    --================================================================
    if (DxLib.dx_CheckMenuItemSelect( "Child", 12346 ) == 1)
    then
        print ( "Child menu clicked")
    end 
end 
--====================================================================
function App.onDraw(dt)
    --================================================================
    drawBackGround(screenW,screenH)
    --================================================================
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ADD , 255 ) ;
    --================================================================
    drawSineCurve(15,count,screenW,screenH)
    drawCicle(20,count,0,screenH,100,DxLib.dx_GetColor(100,100,180))
    drawCicle(20,count,screenW,0,100)
    drawCicle(20,count,App.mouseX,App.mouseY,30)
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
    str ="make Screen test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, screenH-20);
    
    --fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, 10 );
    --================================================================
    
    local sineMod = math.sin(math.pi*2*count)
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255*math.abs(sineMod)) ;
    
    --draw screen
    drawImage( screenHandle
             , makeScreenW/2
             , makeScreenH
             , 1 +0.5 * sineMod
             , (math.pi*2) * count  ) -- math.rad(360*count)
    
    drawImage( screenHandle
             , makeScreenW +makeScreenW/2
             , makeScreenH
             , 1 -0.5 * sineMod
             , (math.pi*2) * count  ) 
        
    
    --================================================================
    fpsLimit:limitFps(60)
end
--====================================================================
function App.onExit()
    loadedFont:destroy();
end
--====================================================================

--====================================================================
App.run()
--====================================================================