
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
    DxLib.dx_DxLib_Init();
    --================================================================
end
--====================================================================
-- init ,setup Dx Library
init ();
--====================================================================

-- for store mouse point
local mouseX = ffi.new("int[1]");
local mouseY = ffi.new("int[1]");
local lastMouseInput = 0;

-- font
DxLib.dx_ChangeFont( "Arial" ,-1) ;
local fontSize = 12

-- for animation
local count =0;

-- image
local graphicHandle = DxLib.dx_LoadGraph( "resources/hatsuneMiku.png", false );

-- sound
local soundHandle = DxLib.dx_LoadSoundMem( "resources/button.ogg" ,3,-1)
local playingSoundTable = {}
local lastPlayTime = 0;

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
                         ,DxLib.dx_GetColor(255,255/num *(i+1),255)
                         ,true
                        )
    end
end
--====================================================================

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
    if (    lastMouseInput ~= DxLib.dx_GetMouseInput()
        and bit.band(DxLib.dx_GetMouseInput(),DxLib.MOUSE_INPUT_LEFT) ~= 0
        )
    then
        str ="Mouse Input "
        DxLib.dx_DrawString( 10, 10 + fontSize, str, DxLib.dx_GetColor(0,0,0), -1 );
        playSound(soundHandle)
    end
    --================================================================

    -- imageDraw
    DxLib.dx_DrawRotaGraph( 350
                          , 180
                          , 0.3+ 0.2 * math.abs ( math.sin ( math.rad( count) ) ) --zoom
                          , math.rad( count ) --angle rotation
                          , graphicHandle
                          , true
                          , false );

    -- angle and sound text
    str = string.format("angle:%.2f",count);
    DxLib.dx_DrawString( screenW -100, screenH - 20, str, DxLib.dx_GetColor(0,0,0), -1 );
    --================================================================
    str = string.format("playing sound num %i",#playingSoundTable);
    DxLib.dx_DrawString( screenW -150, 0, str, DxLib.dx_GetColor(0,0,0), -1 );

    -- animation count
    count = count+0.7
    if ( count >= 360)
    then
        count =0;
    end

    --================================================================
    -- store last mouse point
    lastMouseInput = DxLib.dx_GetMouseInput();
    -- check sound ,how playing now ?
    checkSound();
    --================================================================
    DxLib.dx_ScreenFlip()
end
--====================================================================
DxLib.dx_DxLib_End()
--====================================================================
