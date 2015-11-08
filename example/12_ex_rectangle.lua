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
local loadedFont = nil   -- load and font Resource
local fontSize = 20

-- for animation 
local count = 0;

-- fps
local fpsLimit = createFpsLimit();
--====================================================================

--rectangle
local imageNum = 10; --  5 ~ 20 performance slow
local rectTable = {}
local targetImage = nil
--====================================================================
local penImage = nil -- create in prepare()
local hitTestRect = nil 

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
    loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
    DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
    fontSize = 20
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) --draw font type.
    --================================================================
    --create rectangle
    for i=1,imageNum
    do
        rectTable[i]= createRectangle( screenW/imageNum*(i-1)
                                     , screenH/2-screenW/imageNum/2+60
                                     , screenW/imageNum
                                     , screenW/imageNum):reduced(5,5);
        if ( i~= 1)                        
        then
            rectTable[i]:setParentRect(rectTable[i-1])
        end 
    end 
    --================================================================
    penImage = DxLib.dx_LoadGraph( "resources/pen.png", false );
    hitTestRect = createRectangle( 50,80,70,70);
end
--====================================================================
function App.onMouseMove(mouseX,mouseY)end 
--====================================================================
function App.onMouseDrag(MouseEvent,mouseX,mouseY)
    if (  App.isMousePress == true and targetImage ~= nil )
    then 
        -- local r = targetImage:getMatrixedRect()
        -- local tv,sv,av = targetImage:getOffsetVector()
        -- -- ??? angle ?
        -- --=========================================================
        -- targetImage:setTranslate( rotMouseX -tv.x -r.width/2  -r.lastPos[1].x 
        --                         , rotMouseY -tv.y -r.height/2 -r.lastPos[1].y  
        --                         , 0)
        --============================================================
        local addX = mouseX -App.lastMouseX;
        local addY = mouseY -App.lastMouseY;
        local addVec = DxLib.dx_VGet(addX,addY,0);
        --============================================================
        if ( targetImage.parentRect ~=nil)
        then 
            addVec = DxLib.dx_VTransform(addVec,targetImage.parentRect:getInverseAngleMat());
            -- local xr,yr,zr = targetImage:getAngle()
            -- print ( math.deg(xr),math.deg(yr),math.deg(zr))
            -- --=====================================================
            -- ?? 
        end 
        --============================================================
        targetImage:setTranslate( targetImage.translateVector.x + addVec.x 
                                , targetImage.translateVector.y + addVec.y 
                                , 0 )
        -- or
        -- targetImage:setPosition(  targetImage.x + addVec.x 
        --                         , targetImage.y + addVec.y 
        --                         , 0 )
    end 
end 
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)
    
    -- from top
    -- for i,v in ipairs(rectTable)
    -- do   
    --     local r = v:getMatrixedRect();
    --     if ( r:checkColisionPoint (mouseX,mouseY))
    --     then 
    --         targetImage = v
    --         return;
    --     end
    -- end 
    -- targetImage =nil
    
    -- from back
    local i = #rectTable
    while ( i > 0)
    do
        local r = rectTable[i]:getMatrixedRect();
        if ( r:checkColisionPoint (mouseX,mouseY))
        then 
            targetImage = rectTable[i]
            return;
        end
        i = i-1;
    end 
    targetImage =nil
end
--====================================================================
function App.onMouseRelease(MouseEvent,mouseX,mouseY)
     targetImage = nil
end
--====================================================================
function App.onUpdate(dt)
    --================================================================
    count = count + (dt/8)
    --================================================================
    if ( count >1.0)
    then
        count =0;
    end 
    --================================================================
end 
--====================================================================
function App.onDraw(dt)
    --================================================================
    drawBackGround(screenW,screenH)
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
    str ="matrix Rect test"
    local strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, screenH-20);
    
    --fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidth(str,#str,false);
    drawString( str,screenW-strWidth-10, 10 );
    --================================================================
    
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 150 ) ;
    local isHitMouse =false
    
    -- set angle test 
    rectTable[5]:setAngle( math.pi*2* count, 0, math.pi*2* count )
    rectTable[6]:setAngle( 0, math.pi*2* count, math.pi*2* count )
    rectTable[7]:setAngle( 0,                0, math.pi*2* count )
    rectTable[3]:setScale( 0.6 + 0.4* math.sin( math.pi*2* count )
                         , 0.6 + 0.4* math.sin( math.pi*2* count )
                         , 0 )
    -- draw rect
    for i,v in ipairs(rectTable)
    do
        local r = v:getMatrixedRect() --get applied matrix rect
        -- -- inverse test
        -- local invMat =DxLib.dx_MInverse( r:getMatrix());
        -- r.optionalMatrix = invMat;
        -- r = r :getMatrixedRect() -- redo and store 
        DxLib.dx_DrawModiGraphF( r.pos[1].x , r.pos[1].y
                               , r.pos[2].x , r.pos[2].y
                               , r.pos[3].x , r.pos[3].y
                               , r.pos[4].x , r.pos[4].y
                               , penImage , false );
               
        if ( r:checkColisionPoint(App.mouseX,App.mouseY)==true)
        then
            isHitMouse =true
        end 
    end 
    
    --================================================================
    hitTestRect:setAngle( 0, 0, math.pi*2* count )
    hitTestRect:setScale( 0.5 + 0.5* math.sin(math.pi*2* count)
                        , 0.5 + 0.5* math.sin(math.pi*2* count)
                        , 0 )
                
    local r = hitTestRect:getMatrixedRect()
    --================================================================
    DxLib.dx_DrawModiGraphF( r.pos[1].x , r.pos[1].y
                           , r.pos[2].x , r.pos[2].y
                           , r.pos[3].x , r.pos[3].y
                           , r.pos[4].x , r.pos[4].y
                           , penImage , false );
    
    if ( r:checkColisionPoint(App.mouseX,App.mouseY) == true)
    then
        isHitMouse =true ;
    end 
    
    --================================================================
    if (isHitMouse==true )
    then 
        DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
        str ="hit mouse"
        drawString( str,10, screenH -30 );
    end 
    
    -- mouse point circle
    --================================================================
    drawCicle(20,count,App.mouseX,App.mouseY,30)
    
    
    -- mouseDrag line
    --================================================================
    if (    targetImage ~=nil
        and targetImage.parentRect ~=nil )
    then 
        local r1 = targetImage.parentRect:getMatrixedRect()
        local r2 = targetImage:getMatrixedRect()
        local x1,y1 = r1:getCenterPosition();
        local x2,y2 = r2:getCenterPosition();
        DxLib.dx_DrawLine  (  x1,y1,x2,y2, DxLib.dx_GetColor(0,0,0), 1 ); 
        if ( #targetImage.childRect ~= 0)
        then 
            local r3 = targetImage.childRect[1]:getMatrixedRect()
            local x3,y3 = r3:getCenterPosition();
            DxLib.dx_DrawLine  (  x2,y2,x3,y3, DxLib.dx_GetColor(0,0,0), 1 ); 
        end 
    end 
    --================================================================
    
    -- onMouse line
    --================================================================
    local i = #rectTable
    while ( i > 0)
    do
        local r2 = rectTable[i]:getMatrixedRect();
        if ( r2:checkColisionPoint (App.mouseX,App.mouseY) )
        then 
            local x2,y2 = r2:getCenterPosition();  
            if ( rectTable[i].parentRect ~= nil )
            then 
                local r1 = rectTable[i].parentRect:getMatrixedRect()
                local x1,y1 = r1:getCenterPosition();
                DxLib.dx_DrawLine  (  x1,y1,x2,y2, DxLib.dx_GetColor(0,0,0), 1 ); 
            end 
            --========================================================
            if ( #rectTable[i].childRect >=1)
            then 
                local r3 = rectTable[i].childRect[1]:getMatrixedRect()
                local x3,y3 = r3:getCenterPosition();
                DxLib.dx_DrawLine  (  x2,y2,x3,y3, DxLib.dx_GetColor(0,0,0), 1 ); 
            end 
        end
        i = i-1;
    end 
    --================================================================
    
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
