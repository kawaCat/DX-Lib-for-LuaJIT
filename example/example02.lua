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
local fontSize=23;

-- for animation
local count =0;

-- image
-- create in prepare()
local graphicHandle =nil

-- sound
local soundHandle = nil
local playingSoundTable = {} -- store plaing sound.
local lastPlayTime = nil

--====================================================================
-- for multi play (rewind play ? )
function playSound(soundHandle)
    --================================================================
    if ( os.clock() - lastPlayTime > 0.003 ) --30ms
    then
        local duplicateSound = DxLib.dx_DuplicateSoundMem(soundHandle,3);
        table.insert (playingSoundTable, duplicateSound);

        DxLib.dx_PlaySoundMem(duplicateSound,DxLib.DX_PLAYTYPE_BACK,true);
        --============================================================
        lastPlayTime =os.clock();
    end
end
--====================================================================

-- check playing sound
--====================================================================
function checkSound()
    --================================================================
    for i,v in ipairs(playingSoundTable)
    do
        -- is playing sound handle ?
        if (DxLib.dx_CheckSoundMem( v ) ==0 )
        then
            -- if sound stop, delete soundHandle
            DxLib.dx_DeleteSoundMem(v,false);
            table.remove(playingSoundTable, i);
            break;
        end
    end
    --================================================================
end
--====================================================================

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
    
    -- image
    graphicHandle = DxLib.dx_LoadGraph( "resources/hatsuneMiku.png", false );

    -- sound
    soundHandle = DxLib.dx_LoadSoundMem( "resources/button.ogg" ,3,-1)
    playingSoundTable = {}
    lastPlayTime = 0;
end
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)
    playSound(soundHandle);
end
--====================================================================
function App.onUpdate(dt)
    -- animation count
    count = count + dt/5
    if ( count >= 1)
    then
        count =0;
    end 
    --================================================================
    -- check sound ,how playing now ?
    checkSound();
end 
--====================================================================
function App.onDraw(dt)
    
    --background
    drawBackGround(screenW,screenH)
    --================================================================

    -- Mouse Point
    local str ="MousePoint :" .. App.mouseX .. ":" .. App.mouseY;
    DxLib.dx_DrawString( 10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );
    --================================================================

    -- Mouse Input
    if ( App.isMousePress == true  )
    then
        str ="Mouse Input "
        DxLib.dx_DrawString( 10, 10 + fontSize, str, DxLib.dx_GetColor(0,0,0), -1 );
    end
    --================================================================

    -- imageDraw
    DxLib.dx_DrawRotaGraph( 350
                          , 180
                          , 0.3+ 0.2 * math.abs ( math.sin ( math.rad( 360*count) ) ) --zoom
                          , math.rad( 360 *count ) --angle rotation
                          , graphicHandle
                          , true
                          , false );

    -- angle and sound text
    str = string.format("angle:%.2f",count);
    local strWidth = DxLib.dx_GetDrawStringWidth ( str,#str,false)
    DxLib.dx_DrawString( screenW -strWidth-10, screenH - fontSize, str, DxLib.dx_GetColor(0,0,0), -1 );
    --================================================================
    str = string.format("playing sound num %i",#playingSoundTable);
    strWidth = DxLib.dx_GetDrawStringWidth ( str,#str,false)
    DxLib.dx_DrawString( screenW -strWidth-10, 10, str, DxLib.dx_GetColor(0,0,0), -1 );

end
--====================================================================
function App.onExit()end
--====================================================================

--====================================================================
App.run()
--====================================================================
