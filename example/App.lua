
--====================================================================
local ffi = require("ffi")
local bit = require("bit")
local DxLib = require("DxLib_ffi");
--====================================================================
ffi.cdef(
[[
    //int strcmp (const char *string1, const char *string2);
    char * strcpy ( char * destination, const char * source ) ; 
    //int printf(const char *fmt, ...);
    int memcmp(const void *buf1, const void *buf2,size_t n);
]] )
--====================================================================

--====================================================================
local App ={}
--====================================================================

-- for store mouse point
local mouseX = ffi.new("int[1]");
local mouseY = ffi.new("int[1]");
DxLib.dx_GetMousePoint(mouseX,mouseY);
local lastMouseX = mouseX[0];
local lastMouseY = mouseY[0];
local newMouseInput = 0;
local lastMouseInput = 0;
local newMouseWheel = 0;
local lastMouseWheel = 0;
local isMousePress = false
local isMouseDrag = false

-- keyboard
local newKeyState = ffi.new("char[256]");
local lastKeyState = ffi.new("char[256]");
DxLib.dx_GetHitKeyStateAll( newKeyState );
DxLib.dx_GetHitKeyStateAll( lastKeyState );

-- flag
local isMouseLeftPress = false;
local isMouseRightPress = false;
local isMouseMiddlePress = false;
local isKeyPress = false;

-- time
local newTime = DxLib.dx_GetNowCount(false);
local lastTime = newTime;

-- screen size as default
local screenW = 550;
local screenH = 350;

--====================================================================
function App.init ()
    -- default init
    DxLib.dx_ChangeWindowMode(true)
    DxLib.dx_SetGraphMode( App.screenW, App.screenH, 32,-1) ; -- window size
    DxLib.dx_SetOutApplicationLogValidFlag(false)
    DxLib.dx_SetAlwaysRunFlag(true)
    DxLib.dx_SetBackgroundColor(255,255,255)
    --================================================================
    DxLib.dx_SetFullSceneAntiAliasingMode(4,2)  -- enable anti Alias
    --================================================================
    DxLib.dx_DxLib_Init();
    --================================================================
end
--====================================================================

--====================================================================
function App.prepare()end
--====================================================================
function App.onMouseMove(mouseX,mouseY)end 
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)end
--====================================================================
function App.onMouseDrag(MouseEvent,mouseX,mouseY) end 
--====================================================================
function App.onMouseRelease(MouseEvent,mouseX,mouseY)end
--====================================================================
function App.onMouseWheel(rotValue)end
--====================================================================
function App.onKeyboardPress(KeyEvent)end
--====================================================================
function App.onKeyboardRelease(KeyEvent)end 
--====================================================================
function App.onUpdate(dt) end 
--====================================================================
function App.onDraw(dt) end
--====================================================================
function App.onExit()end 
--====================================================================

--====================================================================
-- @todo refactoring.
function _storeAppInfo()
    --export variable
    App.mouseX = mouseX[0];
    App.mouseY = mouseY[0];
    App.lastMouseX = lastMouseX;
    App.lastMouseY = lastMouseY;
    App.mouseInput = newMouseInput;
    App.isMousePress = isMousePress;
    App.isMouseDrag = isMouseDrag;
    App.isMouseLeftPress = isMouseLeftPress;
    App.isMouseRightPress = isMouseRightPress;
    App.isMouseMiddlePress = isMouseMiddlePress;
    App.mouseWheelValue = newMouseWheel;
    App.keyState = newKeyState;
    App.isKeyPress = isKeyPress;
    App.time = newTime;
end
--====================================================================

--====================================================================
 _storeAppInfo();
--==================================================================== 
 
--====================================================================
function _checkMousePress(mEv)
    if ( bit.band(mEv,DxLib.MOUSE_INPUT_LEFT) ~= 0 )
    then 
        isMouseLeftPress =true;
    end
    
    if ( bit.band(mEv,DxLib.MOUSE_INPUT_RIGHT) ~= 0 )
    then 
        isMouseRightPress =true;
    end
    
    if ( bit.band(mEv,DxLib.MOUSE_INPUT_MIDDLE) ~= 0 )
    then 
        isMouseMiddlePress =true;
    end
end
--====================================================================
function _checkMouseRelease(mEv)
    if ( bit.band(mEv,DxLib.MOUSE_INPUT_LEFT) == 0 )
    then 
        isMouseLeftPress =false;
    end
    
    if ( bit.band(mEv,DxLib.MOUSE_INPUT_RIGHT) == 0 )
    then 
        isMouseRightPress =false;
    end
    
    if ( bit.band(mEv,DxLib.MOUSE_INPUT_MIDDLE) == 0 )
    then 
        isMouseMiddlePress =false;
    end
end
--====================================================================

--====================================================================
-- main loop
--====================================================================
function App.run()
    --================================================================
    App.init ();
    --================================================================
    App.prepare();
    
    local dt = 0;
    --================================================================
    while ( DxLib.dx_ProcessMessage() == 0  and
            DxLib.dx_CheckHitKey( DxLib.KEY_INPUT_ESCAPE ) == 0 )
    do
        -- update process Time;
        newTime =DxLib.dx_GetNowCount(false);
        
        
        -- prepare for draw. clear fill
        --============================================================
        DxLib.dx_SetDrawScreen( DxLib.DX_SCREEN_BACK )
        DxLib.dx_ClearDrawScreen(nil)
        --============================================================
        DxLib.dx_SetDrawBlendMode(DxLib.DX_BLENDMODE_ALPHA,255)
        --============================================================
        
        -- draw
        App.onDraw(dt)
        
        -- Mouse Point
        DxLib.dx_GetMousePoint(mouseX,mouseY);
        if (lastMouseX ~=mouseX[0] or lastMouseY ~= mouseY[0] )
        then
            App.onMouseMove(mouseX[0], mouseY[0]);
            if (isMousePress == true )
            then 
                App.onMouseDrag(lastMouseInput,mouseX[0], mouseY[0])
                isMouseDrag =true
            else 
                isMouseDrag =false
            end 
        end
        lastMouseX = mouseX[0];
        lastMouseY = mouseY[0];
        --============================================================
        
        -- mouse wheel
        newMouseWheel = DxLib.dx_GetMouseWheelRotVol(true)
        if ( lastMouseWheel ~= newMouseWheel )
        then 
            App.onMouseWheel ( newMouseWheel );
        end
        lastMouseWheel = newMouseWheel;
        --============================================================
        
        -- Mouse Input
        newMouseInput = DxLib.dx_GetMouseInput();
        if ( lastMouseInput ~= newMouseInput )
        then
            if ( lastMouseInput < newMouseInput )
            then 
                App.onMousePress ( newMouseInput,mouseX[0],mouseY [0])
                isMousePress = true
                _checkMousePress(newMouseInput);
            else
                App.onMouseRelease ( newMouseInput,mouseX[0],mouseY[0] )
                isMousePress = false
                _checkMouseRelease(newMouseInput)
            end
        end
        lastMouseInput = DxLib.dx_GetMouseInput();
        --============================================================

        -- keyboard
        DxLib.dx_GetHitKeyStateAll( newKeyState ) ;
        --============================================================
        --if ( ffi.C.strcmp (lastKeyState,newKeyState) ~= 0)
        if ( ffi.C.memcmp (lastKeyState,newKeyState,256) ~= 0)
        then 
            --========================================================
            local lastSum = 0;
            local newSum =0;
            for i=0,256-1
            do
                lastSum = lastSum + lastKeyState[i]
                newSum  = newSum + newKeyState[i]
                --====================================================
                -- check max keyboard press num.
                if (lastSum > 4 )
                then 
                    break;
                end
            end
            --========================================================
            -- newSum is keyPressed num.
            if (lastSum  < newSum )
            then
                App.onKeyboardPress(newKeyState);
                isKeyPress =true;
            else
                App.onKeyboardRelease(newKeyState)
                isKeyPress =false;
            end
            --========================================================
            ffi.copy(lastKeyState, newKeyState,256 )
        end 
        --============================================================
        
        -- update
        dt = (newTime - lastTime)/1000 ; -- sec
        App.onUpdate(dt);
        --============================================================

        --============================================================
        lastTime = newTime;
        --============================================================
        DxLib.dx_ScreenFlip(); -- draw screen to forward.
        --============================================================
        _storeAppInfo();
    end
    --================================================================
    App.onExit();
    --================================================================
    DxLib.dx_DxLib_End();
    --================================================================
end
--====================================================================

--====================================================================
return App;
--====================================================================
