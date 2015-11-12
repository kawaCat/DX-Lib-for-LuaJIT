
--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
local App = require("exampleLib")
--====================================================================
math.randomseed(os.time())
--====================================================================
local screenW = 550;
local screenH = 350;
--====================================================================

-- font
local loadedFont = nil   -- load and font Resource
local fontSize = 20

-- for animation 
local count = 0;

-- fps
local fpsLimit = createFpsLimit();
--====================================================================

--====================================================================
function createHexTile(centerX,centerY,size)
    local HexTile ={}
    HexTile.size = size;
    HexTile.pos ={} -- 1 ~ 6 ,x,y
    HexTile.centerPos = {x =centerX,y =centerY } 
    HexTile.color = DxLib.dx_GetColor(255,255,0);
    HexTile.height = size*2
    HexTile.width  = math.sqrt(3)/2 *HexTile.height
    HexTile.colum =0
    HexTile.row = 0
    HexTile.isBlock =false
    HexTile.offsetX =0
    HexTile.offsetY =0
    --================================================================
    function HexTile:changeSize(newSize)
        self.size = newSize;
        self:_calcHeightWidth();
        self:_createPoint()
    end
    --================================================================
    function HexTile:draw()
        local color = self.color
        local lineColor = DxLib.dx_GetColor(0,0,0)
        --============================================================
        self:_drawTrianlge(self.centerPos,self.pos[1],self.pos[2],color,true);
        self:_drawTrianlge(self.centerPos,self.pos[2],self.pos[3],color,true);
        self:_drawTrianlge(self.centerPos,self.pos[3],self.pos[4],color,true);
        self:_drawTrianlge(self.centerPos,self.pos[4],self.pos[5],color,true);
        self:_drawTrianlge(self.centerPos,self.pos[5],self.pos[6],color,true);
        self:_drawTrianlge(self.centerPos,self.pos[6],self.pos[1],color,true);
        --============================================================
        self:_drawOutLine();
    end 
    --================================================================
    function HexTile:checkColisionPoint(x,y)
        --============================================================
        local cnt = 0
        --============================================================
        for i=1,6,1
        do
            local next =i+1
            --========================================================
            if ( i+1 >6 ) then next =1 end 
            local x1 = self.pos[next].x - self.pos[i].x;
            local y1 = self.pos[next].y - self.pos[i].y;
            local x2 = x - self.pos[i].x;
            local y2 = y - self.pos[i].y;
            --========================================================
            if (x1 * y2 - x2 * y1 < 0) 
            then
                cnt = cnt+1
            else 
                cnt = cnt-1
            end
            --========================================================
        end
        --============================================================
        if (cnt <=-6 or cnt >= 6)
        then 
            return true
        end
        --============================================================
        return false 
    end
    --================================================================
    function HexTile:checkColisionHex(targetHex)
        --============================================================
        for i=1,6,1
        do
            local point = targetRect.pos[i]
            local isContact = self:checkColisionPoint(point.x,point.y)
            if ( isContact == true )
            then
                return true
            end
        end
        --============================================================
        return false 
    end
    --================================================================  
   
    --================================================================
    function HexTile:_drawTrianlge(pos1,pos2,pos3,color,fill)
        DxLib.dx_DrawTriangle( pos1.x+self.offsetX, pos1.y+self.offsetY
                             , pos2.x+self.offsetX, pos2.y+self.offsetY
                             , pos3.x+self.offsetX, pos3.y+self.offsetY
                             , color
                             , fill ) ;   
    end
    --================================================================
    function HexTile:_drawOutLine()
        --============================================================
        local function _drawLine(p1,p2,offsetX,offsetY,color,thick)
            local color_ = color or DxLib.dx_GetColor(0,0,0)
            local thick_ = thick or 1
            DxLib.dx_DrawLine( p1.x+offsetX
                             , p1.y+offsetY
                             , p2.x+offsetX
                             , p2.y+offsetY
                             , color_
                             , thick_ ); -- thickness
        end
        --============================================================
        _drawLine(self.pos[1],self.pos[2],self.offsetX,self.offsetY)
        _drawLine(self.pos[2],self.pos[3],self.offsetX,self.offsetY)
        _drawLine(self.pos[3],self.pos[4],self.offsetX,self.offsetY)
        _drawLine(self.pos[4],self.pos[5],self.offsetX,self.offsetY)
        _drawLine(self.pos[5],self.pos[6],self.offsetX,self.offsetY)
        _drawLine(self.pos[6],self.pos[1],self.offsetX,self.offsetY)
    end
    --================================================================
    function HexTile:_calcPoint()
        for i=1,6
        do
            local angle = math.rad(60*(i));
            self.pos[i] = {}
            self.pos[i].x = self.centerPos.x + self.size * math.sin(angle)
            self.pos[i].y = self.centerPos.y + self.size * math.cos(angle)
        end 
    end 
    --================================================================
    function HexTile:_calcHeightWidth()
        self.height = self.size*2
        self.width = math.sqrt(3)/2 *self.height
    end
    --================================================================
    function HexTile:_printPos()
        print ( self.centerPos.x,self.centerPos.y
              , self.pos[1].x,self.pos[1].y
              , self.pos[3].x,self.pos[3].y
              , self.pos[4].x,self.pos[4].y
              , self.pos[6].x,self.pos[6].y
              )
    end 
    --================================================================
    
    --================================================================
    HexTile:_calcHeightWidth()
    HexTile:_calcPoint()
    return HexTile;
end 
--====================================================================

local hexTable ={}
--====================================================================
local hexNumX =20;
local hexNumY =20;
local hexSize =8
--====================================================================
local _hexHeight= 2*hexSize
local _hexWidth = _hexHeight*math.sqrt(3)/2
local hexStartX = _hexWidth
local hexStartY = _hexHeight
--====================================================================
local offsetX =0 -- mouse move
local offsetY =0
--====================================================================
local imageScreen = nil
--====================================================================
local count_ =1
--====================================================================
for iy =1,hexNumY
do
    local y = hexStartY + _hexHeight *(iy-1) -_hexHeight*1/4 *(iy-1)
    for ix =1,hexNumX
    do
        local x = hexStartX + _hexWidth *(ix-1)
        if ( math.mod(iy,2) ==0)
        then
            hexTable[count_] = createHexTile( x +_hexWidth/2
                                            , y 
                                            , hexSize
                                            )
            hexTable[count_].colum = ix-1
            hexTable[count_].row = iy-1
        else
            hexTable[count_] = createHexTile( x 
                                            , y
                                            , hexSize
                                            )
            hexTable[count_].colum = ix-1
            hexTable[count_].row = iy-1
        end 
        hexTable[count_].color = DxLib.dx_GetColor(math.random()*255,math.random()*255,math.random()*255)
        --============================================================
        if ( math.random() *100 >70 )
        then
            hexTable[count_].isBlock =true
        end
        --============================================================
        count_ = count_ +1
    end
end 
--====================================================================

-- hexMap用の関数
--====================================================================
function _accessHexTable(colum,row)
    
    --================================================================
    if ( colum == -1 or row== -1)then return nil end 
    --================================================================
    
    local target = (hexNumX * row) + (colum)
    
    if (target+1 >  #hexTable ) --テーブルは１から始まってるから
    then 
        target = target 
    else
        target = target+1
    end 
    --
    local out = hexTable[target];
    if (out == nil )
    then 
        out = hexTable[1]
    end 
    --================================================================
    return out
end
--====================================================================
function _getColumNum(i,maxColumNum)
    return math.mod(i,maxColumNum);
end 
--====================================================================
function _getRowNum(i,maxColumNum)
    return math.floor(i/hexNumX)
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
    
    loadedFont = createFontResource("resources/DS Siena Black.ttf"); --font path
    DxLib.dx_ChangeFont( "DS Siena Black" ,-1) ; -- font Name
    
    fontHandle = DxLib.dx_CreateFontToHandle( "DS Siena Black"
                                            , fontSize
                                            , 0
                                            , DxLib.DX_FONTTYPE_ANTIALIASING
                                            , -1
                                            , 0
                                            , false
                                            , false
                                            )
    DxLib.dx_ChangeFontType( DxLib.DX_FONTTYPE_ANTIALIASING) --draw font type.

    -- set CharCode to fontHandle
    DxLib.dx_SetFontCharCodeFormatToHandle(DxLib.DX_CHARCODEFORMAT_UTF8,fontHandle)
    --================================================================
    
    -- prepare draw Image
    imageScreen = DxLib.dx_MakeScreen( _hexWidth*(hexNumX) +_hexWidth
                                     , _hexHeight*(hexNumY)+_hexHeight+1 ,true)
    DxLib.dx_SetDrawScreen( imageScreen )
    --================================================================
    for i,v in ipairs(hexTable)
    do
        v.color = DxLib.dx_GetColor(255,120,120)
        if ( v.isBlock )
        then
            v.color = DxLib.dx_GetColor(255,255,255)
            v:draw();
        else
            v:draw()
        end
    end
    --================================================================
    DxLib.dx_SetDrawScreen( DxLib.DX_SCREEN_BACK )
end
--====================================================================
function App.onMouseDrag(MouseEvent,mouseX,mouseY)
    offsetX =offsetX + App.mouseDistanceX
    offsetY =offsetY + App.mouseDistanceY
end 
--====================================================================
function App.onUpdate(dt)
    --================================================================
    count = count + (dt/3.5)
    --================================================================
    if ( count >1.0)
    then
        count =0;
    end 
    --================================================================
end 
--====================================================================

--====================================================================
local function _drawAnimationSin()
    
    local blendMode ,blendParam = getDrawBlendMode();
    --================================================================
--++
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ADD , 255 ) ;
    drawSineCurve(15,count,screenW,screenH)
    drawCicle(20,count,0,screenH,100,DxLib.dx_GetColor(100,100,180))
    drawCicle(20,count,screenW,0,100)
--++
    --================================================================
    DxLib.dx_SetDrawBlendMode(blendMode , blendParam ) ;
end
--====================================================================
local function _drawInfoText()
    
    local blendMode ,blendParam = getDrawBlendMode();--from "draw.lua"
    --================================================================
--++
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
    --================================================================
    DxLib.dx_SetFontSize(fontSize);

    -- Mouse point
    --================================================================
    local str ="Mouse Point :" .. App.mouseX .. ":" .. App.mouseY;
    local strWidth = DxLib.dx_GetDrawStringWidthToHandle(str,#str,fontHandle,false);
    drawStringToHandle( str,10, 10,fontHandle);

    --================================================================
    str ="ode test"
    strWidth = DxLib.dx_GetDrawStringWidthToHandle(str,#str,fontHandle,false);
    drawStringToHandle( str,screenW-strWidth-10, screenH-fontSize,fontHandle);

    --fps 
    str =string.format("FPS:%.2f",fpsLimit:getFps());
    strWidth = DxLib.dx_GetDrawStringWidthToHandle(str,#str,fontHandle,false);
    drawStringToHandle( str,screenW-strWidth-10, 10,fontHandle);
    --================================================================    
--++   
    --================================================================
    DxLib.dx_SetDrawBlendMode(blendMode , blendParam ) ;
end 
--====================================================================
local function drawHexgon(cx,cy,size,color)
    --================================================================
    function _drawTrianlge(pos1,pos2,pos3,color,fill)
        DxLib.dx_DrawTriangle( pos1.x, pos1.y
                             , pos2.x, pos2.y
                             , pos3.x, pos3.y
                             , color
                             , fill ) ;   
    end
    --================================================================
    function _calcPoint()
        local posTable ={}
        for i=1,6
        do
            local angle = math.rad(60*(i));
            posTable[i] = {}
            posTable[i].x = cx + size * math.sin(angle)
            posTable[i].y = cy + size * math.cos(angle)
        end 
        return posTable;
    end
    --================================================================
    local pTable =  _calcPoint()
    --================================================================
    _drawTrianlge({x=cx,y=cy},pTable[1],pTable[2],color,true);
    _drawTrianlge({x=cx,y=cy},pTable[2],pTable[3],color,true);
    _drawTrianlge({x=cx,y=cy},pTable[3],pTable[4],color,true);
    _drawTrianlge({x=cx,y=cy},pTable[4],pTable[5],color,true);
    _drawTrianlge({x=cx,y=cy},pTable[5],pTable[6],color,true);
    _drawTrianlge({x=cx,y=cy},pTable[6],pTable[1],color,true);
    --================================================================
end
--====================================================================

-- http://www.redblobgames.com/grids/hexagons/
-- hexマップ 情報取得用 クラスにするときはprivateになる
--====================================================================
function math.round(num, idp)
    -- 四捨五入。実数numを、小数idp桁で丸める。 lua は切捨てのfloorしかないので
    if idp and idp>0 then
        local mult = 10^idp
        return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end
--====================================================================
function hex_to_cube(h)
    local x = h.row
    local z = h.colum
    local y = -x-z
    
    -- 縦タイプ plus
    x = h.colum - (h.row - ((bit.band(h.row,1)) ))/2
    z = h.row
    y = -x-z
    
    -- 縦タイプ minus
    -- x = h.colum - (h.row + (math.mod(h.row,2)) )/2
    -- z = h.row
    -- y = -x-z
    
    --横タイプ plus
    -- x = h.colum
    -- z = h.row - (h.colum  + (math.mod(h.row,2))) / 2
    -- y = -x-z
    
    --横タイプ minus
    -- x = h.colum
    -- z = h.row - (h.colum  - (math.mod(h.row,2))) / 2
    -- y = -x-z
    
    local cube = {x=x,y=y,z=z}
    return cube
end
--====================================================================
function cube_to_hex(cube_)
    
    -- 縦タイプ plus
    local col = cube_.x + (cube_.z - math.mod(cube_.z,2)) / 2
    local row = cube_.z
    
    -- 縦タイプ minus
    -- local col = cube_.x + (cube_.z + math.mod(cube_.z,2)) / 2
    -- local row = cube_.z
    
    --横タイプ plus
    -- local col = cube_.x
    -- local row = cube_.z + (cube_.x + math.mod(cube_.x,2)) / 2
    
    --横タイプ minus
    -- local col = cube_.x
    -- local row = cube_.z + (cube_.x - math.mod(cube_.x,2)) / 2
    
    return col, row
end
--====================================================================
function cube_distance(a, b)
    return (math.abs(a.x - b.x) + math.abs(a.y - b.y) + math.abs(a.z - b.z)) / 2
    --return math.max(math.abs(a.x - b.x), math.abs(a.y - b.y), math.abs(a.z - b.z))
end
--====================================================================
function cube_lerp(a, b, t)
    return { x = a.x + (b.x - a.x) * t
            ,y = a.y + (b.y - a.y) * t
            ,z = a.z + (b.z - a.z) * t }
end
--====================================================================
function cube_round(c)
    --================================================================
    local rx = math.round(c.x)
    local ry = math.round(c.y)
    local rz = math.round(c.z)
    --================================================================
    local x_diff = math.abs(rx - c.x)
    local y_diff = math.abs(ry - c.y)
    local z_diff = math.abs(rz - c.z)
    --================================================================
    if (    x_diff > y_diff 
        and x_diff > z_diff )
    then
        rx = -ry-rz
    else
        if( y_diff > z_diff)
        then
            ry = -rx-rz
        else
            rz = -rx-ry
        end
    end
    --================================================================
    local cube = {x=rx,y=ry,z=rz}
    --================================================================
    return cube
end
--====================================================================
function hex_round(h)
    return cube_to_hex(cube_round(hex_to_cube(h)))
end
--====================================================================
function hex_distance(a,b)
    local acube = hex_to_cube(a)
    local bcube = hex_to_cube(b)
    return (cube_distance(acube,bcube))
    --================================================================
end
--====================================================================
function pixel_to_hex(x, y,size)
    -- offset coordinates,
    local q = (x * math.sqrt(3)/3 - y / 3) / size
    local r =  y * 2/3 / size
    return cube_to_hex(cube_round({x=q,y= -q-r,z= r}))
    
    --for “pointy top” axial hexes:
    --local q = (x * math.sqrt(3)/3 - y / 3) / size
    --local r =  y * 2/3 / size
    --return hex_round({colum =q, raw=r})
     
    --for “flat top” axial hexes: 
    --q = x * 2/3 / size
    --r = (-x / 3 + math.sqrt(3)/3 * y) / size
    --return hex_round({colum =q, raw=r})
end
--====================================================================
function offset_to_pixel(hex,size)
    local x = size * math.sqrt(3) * (hex.colum + 0.5 * math.mod(hex.row,2))
    local y = size * 3/2 * hex.row
    return x, y
end    
--====================================================================
function offset_neighbor(hex, direction)
    local directions ={}
    directions[1]={
                     {col= 1,row= 0}
                    ,{col= 0,row=-1}
                    ,{col=-1,row=-1}
                    ,{col=-1,row= 0}
                    ,{col=-1,row= 1}
                    ,{col= 0,row= 1}};
    directions[2]={
                     {col = 1,row = 0}
                    ,{col = 1,row =-1}
                    ,{col = 0,row =-1}
                    ,{col =-1,row = 0}
                    ,{col = 0,row = 1}
                    ,{col = 1,row = 1}};            
    
    local  parity = math.mod(hex.row,2);
    local dir = directions[parity+1][direction]
    --================================================================
    local outColum = hex.colum + dir.col
    local outRow = hex.row + dir.row
    --================================================================
    if (   outColum >= hexNumX 
        or outRow >= hexNumY )
    then
        return -1,-1
    end
    --================================================================
    return outColum, outRow
end
--====================================================================
function pathFind(startHex,targetHex)
    --================================================================
    local frontier_FIFO = {} -- use as fifo
    local came_from = {}     -- non fifo 
    --================================================================
    -- fifo pop
    function _pop()
        local out = frontier_FIFO[1];
        table.remove(frontier_FIFO,1)
        return out
    end
    --================================================================
    -- fifo and sort
    function _push(hex)
        table.insert(frontier_FIFO,hex)
        table.sort( frontier_FIFO
                  , function (a,b) return a.priority < b.priority end )
    end
    --================================================================
    -- Manhattan distance on a square grid
    function _heuristic(a, b)
        return math.abs(a.colum - b.colum) + math.abs(a.row - b.row)
    end
    --================================================================
    -- setup(first push)
    function _init()
        -- hex Info
        local temp = {}
        temp.count = 0;
        temp.priority = 0;
        temp.hex = startHex;
        temp.prev = nil;
        temp.next = startHex;
        _push(temp)
        --============================================================
    end
    --================================================================
    
    _init();
    
    --================================================================
    local count = 1;
    local hexInfo = nil
    local isGoal = false
    --================================================================
    while #frontier_FIFO >0 
    do
        hexInfo = _pop()
        --============================================================
        local currentHex = hexInfo.next
        --============================================================
        if (currentHex == targetHex)
        then  
            isGoal =true;
            break ;
        end
        --============================================================
        for i =1,6
        do
            local nextHex =_accessHexTable( offset_neighbor(currentHex, i))  
            --========================================================
            if (    nextHex ~= nil 
                and nextHex.isBlock == false)
            then
                --====================================================
                local check = false 
                --====================================================
                for ii,vv in ipairs(came_from)
                do
                    if (   vv.hex  == nextHex 
                        or vv.prev == nextHex 
                        or vv.next == nextHex )
                    then
                        check = true   
                        break ;
                    end
                end 
                --====================================================
                if ( check == false)
                then
                    local temp = {}
                    temp.priority = _heuristic(targetHex,nextHex)
                    temp.count = count;
                    temp.hex  = currentHex;
                    temp.prevInfo = hexInfo
                    temp.next = nextHex;
                    --================================================
                    _push(temp)
                    table.insert(came_from,temp);
                end
            --========================================================
            end
        end
        --============================================================
        count = count+1;
    end
    --================================================================
    
    --================================================================
    local outHexPath ={}
    local hex_ = startHex
    table.insert ( outHexPath,hex_)
    --================================================================
    if (isGoal )
    then 
        --============================================================
        hex_ = hexInfo
        --============================================================
        local cc  =0
        while (hex_ ~= nil)
        do
            table.insert ( outHexPath,hex_.hex)
            hex_ = hex_.prevInfo
            --========================================================
        end 
        --============================================================
    end
    --================================================================
    return outHexPath;
end 
--====================================================================

--====================================================================
function _drawHexLine(startHex,targetHex)
    --================================================================
    local a = hex_to_cube( startHex)
    local b = hex_to_cube(targetHex)
    local distanse_ = cube_distance(a,b)
    --================================================================
    if (   distanse_ < 3
        or targetHex.isBlock == true 
        or startHex.isBlock  == true ) 
    then 
        return 
    end 
    --================================================================
    local lastHex=nil
    --================================================================
    local tempHex = startHex
    for i=0,distanse_-1
    do
        local resCube = cube_round(cube_lerp(a, b, 1.0/distanse_ * i))
        if ( resCube == nil )then return end 
        local resHexCol,resHexRaw = cube_to_hex(resCube);
        local resHex = _accessHexTable (resHexCol,resHexRaw);
        --============================================================
        DxLib.dx_DrawCircle( resHex.centerPos.x + offsetX -_hexWidth/2
                           , resHex.centerPos.y + offsetY -_hexHeight/2
                           , 3
                           , DxLib.dx_GetColor(50,50,50),1,1);
    end
end
--====================================================================

local lastMouseColisionHex =nil
local camfrom_HexPath = {};
--====================================================================
function App.onDraw(dt)
    
    --================================================================
    drawBackGround(screenW,screenH,2)
    --================================================================
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
    --================================================================
    
    --draw Animation sin
    _drawAnimationSin()
    --================================================================
    
    local distance= 0
    local mouseColisionHex = nil
    local mouseColisionHexCube = nil
    local centerHex  = _accessHexTable(10,10)
    centerHex.isBlock = false
    local colisionColumn = -1
    local colisionRow = -1
    --================================================================
    DxLib.dx_DrawRotaGraph( _hexWidth *hexNumX /2 +offsetX --x 
                          , _hexHeight*hexNumY /2 +offsetY --y
                          , 1
                          , 0
                          , imageScreen 
                          , true     -- TransFlag,  
                          , false ); -- invert flag (  TurnFlag)
    --================================================================
    
    -- screen(0,0) pixel to hex colum,row
    --================================================================
    --local showColumStart,showRawStart   =  pixel_to_hex( math.abs((offsetX +_hexWidth/2))
    --                                                   , math.abs((offsetY +_hexHeight/2))
    --                                                   , hexSize )
    
    local screenOffsetX = offsetX -_hexWidth/2
    local screenOffsetY = offsetY -_hexHeight/2
    local screenOffsetXInv = -screenOffsetX
    local screenOffsetYInv = -screenOffsetY
    --================================================================
    for i,v in ipairs(hexTable)
    do
        if ( v:checkColisionPoint( App.mouseX+screenOffsetXInv
                                 , App.mouseY+screenOffsetYInv ) ==true)
        then
            colisionColumn = _getColumNum(i-1,hexNumX)
            colisionRow    = _getRowNum(i-1,hexNumX)
            --========================================================
            distance = hex_distance(centerHex,v)
            --========================================================
            v.color = DxLib.dx_GetColor(255,255,255)
            --========================================================
            mouseColisionHex = v;
            mouseColisionHexCube = hex_to_cube(v)
            --========================================================
            
            local screenOffsetX = offsetX -_hexWidth/2
            local screenOffsetY = offsetY -_hexHeight/2
            
            drawHexgon(v.centerPos.x +screenOffsetX
                      ,v.centerPos.y +screenOffsetY
                      ,v.size
                      ,DxLib.dx_GetColor(255,255,255))
            
            --========================================================
            drawLine( centerHex.centerPos.x +screenOffsetX
                    , centerHex.centerPos.y +screenOffsetY
                    , mouseColisionHex.centerPos.x+screenOffsetX
                    , mouseColisionHex.centerPos.y+screenOffsetY
                    )  
            --========================================================
            -- _drawHexLine(centerHex,mouseColisionHex)
            
            if (lastMouseColisionHex ~= v
                and v.isBlock == false)
            then
                camfrom_HexPath = pathFind(mouseColisionHex,centerHex);
            end
            lastMouseColisionHex =v;
            --========================================================
            for i,v in ipairs(camfrom_HexPath)
            do
                DxLib.dx_DrawCircle( v.centerPos.x + offsetX -_hexWidth/2
                                   , v.centerPos.y + offsetY -_hexHeight/2
                                   , 3
                                   , DxLib.dx_GetColor(50,50,50),1,1);
            end
            --========================================================
            break;
        end 
        --============================================================
    end 
    --================================================================
    
    -- draw Info    
    _drawInfoText()
    
    local str ="hexTile :" .. colisionColumn .. ":" .. colisionRow;
    local strWidth = DxLib.dx_GetDrawStringWidthToHandle(str,#str,fontHandle,false);
    drawStringToHandle( str,screenW-strWidth-10, fontSize*1+8,fontHandle);
    
    str ="distance :" .. distance
    strWidth = DxLib.dx_GetDrawStringWidthToHandle(str,#str,fontHandle,false);
    drawStringToHandle( str,screenW-strWidth-10, fontSize*2+8,fontHandle);
    
    if (mouseColisionHexCube ~= nil)
    then 
    str =string.format("hexCube:x%i,y%i,z%i",mouseColisionHexCube.x,mouseColisionHexCube.y,mouseColisionHexCube.z)
    strWidth = DxLib.dx_GetDrawStringWidthToHandle(str,#str,fontHandle,false);
    drawStringToHandle( str,screenW-strWidth-10, fontSize*3+8,fontHandle);
    end
    
    --================================================================
    -- fps
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
