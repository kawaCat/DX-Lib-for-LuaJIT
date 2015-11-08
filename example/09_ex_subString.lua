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
local dxFontHandle = nil -- create App.preapre()
local loadedFont = nil   -- load and font Resource
local fontSize = 20

-- for animation 
local count = 0;

-- fps
local fpsLimit = createFpsLimit();

-- multibyte string substring
--====================================================================
local strPos = 1;
local makuranosoushi = 
[[
春はあけぼの。
やうやう白くなり行く、山ぎは少しあかりて、
紫だちたる雲の細くたなびきたる。 

夏は夜。
月のころはさらなり。やみもなほ、ほたるの多く飛びちがひたる。
また、ただ一つ二つなど、ほのかにうち光りて行くもをかし。
雨など降るもをかし。
]]
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
    -- after dx_init()'s  setting.
    
    dxFontHandle = DxLib.dx_LoadFontDataToHandle( "resources/sample.dft", 0 ); --prepared font
    loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
    DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
    fontSize = 20
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) --draw font type.

    -- set CharCode to fontHandle
    DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,dxFontHandle)
    --================================================================
end
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)
    strPos =1;
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
    drawBackGround(screenW,screenH)
    --================================================================
    drawCicle(20,count,0,screenH,100,DxLib.dx_GetColor(100,100,180))
    drawCicle(20,count,screenW,0,100)
    drawCicle(20,count,App.mouseX,App.mouseY,30)
    --================================================================
    DxLib.dx_SetFontSize(fontSize);
    
    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. App.mouseX .. ":" .. App.mouseY;
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,10, 10);
    
    --================================================================
    str ="substring test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, screenH-20);
    
    --fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, 10 );
    --================================================================
    
    -- draw Substring text
    local mbStrLengh = getMbLengh(makuranosoushi)
    local lineNum = 0
    local colum = 0
    for i=1,strPos
    do
        local onestr = mbStrSub(makuranosoushi,i, i );
        if (    string.byte(onestr) ~= 0x0D   -- "\r" string byte
            and string.byte(onestr) ~= 0x0A ) -- "\n" string byte
        then
            drawStringToHandle(onestr,10 +15*colum,80 + 23*lineNum,dxFontHandle)
            colum = colum+1;
        else
            lineNum = lineNum+1
            colum =0;
        end 
    end 
    
    -- increment string pos
    --================================================================
    if (strPos <mbStrLengh)
    then 
        strPos = strPos + 0.45;
    end 
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