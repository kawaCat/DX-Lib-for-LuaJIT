
--====================================================================
-- this voronoi algolism is 
-- https://github.com/camconn/voronoi
-- 
-- and this algolism's license
-- 
-- This project is licensed under the GNU Public License,
-- Verion 3 or Later. A copy of this license may be found in the file LICENSE.
--
-- thanks camconn.
--====================================================================

----------------------------------------------------------------------
-- @module Voronoi
----------------------------------------------------------------------

--====================================================================
math.randomseed(os.clock())
--====================================================================

--====================================================================
local abs  = math.abs;
local sqrt = math.sqrt;
local pow  = math.pow;
local rand = math.random;
--====================================================================

----------------------------------------------------------------------
-- @table point
-- @field x
-- @field y
--====================================================================

----------------------------------------------------------------------
-- @table ColorTable
-- @field i1
-- @usage
-- color ={}
-- color[0] ={r=255,g=0,b=0,a=255}; --start index from 0
-- color[1] ={r=255,g=0,b=255,a=255}; 
--====================================================================

----------------------------------------------------------------------
--@factory Voronoi

----------------------------------------------------------------------
-- @param width
-- @param height
-- @constructor
-- @within Constructor
----------------------------------------------------------------------
function createVoronoi(width,height)
    --================================================================
    local Voronoi ={}
    Voronoi.numPoints = 300 -- default
    Voronoi.points ={}
    Voronoi._numColor = 60; -- default color num
    Voronoi.colorTable ={}
    Voronoi.width = width or 300;
    Voronoi.height = height or 300;
    --================================================================
    
    ------------------------------------------------------------------
    -- @param newNum voronoi point num 
    ------------------------------------------------------------------
    function Voronoi:setNumPoints(newNum)
        self.numPoints =newNum;
        self:_genNumPoint();
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- @tparam ColorTable colorTable_
    ------------------------------------------------------------------
    function Voronoi:setColorTable(colorTable_)
        self.colorTable  = colorTable_;
    end
    --================================================================
    
    ------------------------------------------------------------------
    -- @return pixelTable 
    ------------------------------------------------------------------
    function Voronoi:getPixelTable()
        --============================================================
        local numPoints = self.numPoints;
        --============================================================
        local  width  =  self.width ;
        local  height =  self.height ;
        --============================================================
        local points =self.points;
        --============================================================
        local distanceFunc = self._euclideanDist;
        --local distanceFunc = self._manhattanDist;
        --local distanceFunc = self._chebyshevDist;
        --============================================================
        local pixelTable ={}
        --============================================================
        local pixelPos = 1;
        for y = 0, height-1
        do
            for x = 0,width-1
            do
                local closest;
                local closestDist = width * height; 
                --====================================================
                for p = 0,numPoints-1
                do
                    -- distanceFunc は関数ポインタなので、対象をselfで示す。
                    local dist = distanceFunc( self
                                             , x
                                             , y
                                             , self.points[p].x
                                             , self.points[p].y
                                             )
                    --================================================
                    if (dist < closestDist)
                    then 
                        closest = p;
                        closestDist = dist;
                    end 
                    --================================================
                end 
                pixelTable[pixelPos] = self.colorTable [math.mod(closest, #self.colorTable+1)];
                pixelPos=pixelPos+1;
            end 
        end 
        --============================================================
        return pixelTable;
    end 
    --================================================================
    
    --================================================================
    --// Calculate the distance between two points (x,y) and (a, b)
    --// uses the standard euclidean distance formula
    function Voronoi:_euclideanDist( x,  y,  a,  b) 
        --============================================================
        local horizDistance = abs(x - a);
        local vertDistance  = abs(y - b);
        --============================================================
        local dist =  sqrt(pow(horizDistance, 2) 
                    + pow(vertDistance, 2));
        --============================================================
        return dist;
    end 
    --================================================================
    
    --================================================================
    --// Calculate the distance between two points (x,y) and (a,b)
    --// using the Manhattan distance
    --// We return a double type to keep compatibility with
    --// euclideanDist
    function Voronoi:_manhattanDist( x,  y,  a,  b)
        return abs(x - a) + abs(y - b);
    end
    --================================================================
    
    --================================================================
    --// Calculate the distance between two points (x, y) and (a, b)
    --// using the Chebyshev distance.
    --// Returns a double to keep compatibility with euclidean dist
    function  Voronoi:_chebyshevDist( x,  y,  a,  b) 
        local distHoriz = abs(x - a);
        local distVert  = abs(y - b);
        --============================================================
        if ( distHoriz > distVert) 
        then 
            return distHoriz;
        else 
            return distVert;
        end
    end
    --================================================================
    
    --================================================================
    function Voronoi:_randXCoord(width)
        return rand()*width;
    end
    --================================================================
    function Voronoi:_randYCoord( height)
        return rand()*height;
    end 
    --================================================================
    function Voronoi:_genNumPoint()
        --============================================================
        self.points ={};
        --============================================================
        for i = 0, self.numPoints
        do
            self.points[i] ={};
            self.points[i].x = self:_randXCoord(self.width);
            self.points[i].y = self:_randYCoord(self.height);
        end
    end 
    --================================================================
    function Voronoi:_genColorTable()
        --============================================================
        self.colorTable ={};
        --============================================================
        for i=0,self._numColor
        do
            self.colorTable[i] ={}
            self.colorTable[i].r = math.floor(math.random() *255)
            self.colorTable[i].g = math.floor(math.random() *255)
            self.colorTable[i].b = math.floor(math.random() *255)
            self.colorTable[i].a = 255;
        end     
        --============================================================
    end 
    --================================================================
    
    --================================================================
    Voronoi:_genNumPoint();
    Voronoi:_genColorTable();
    --================================================================
    return Voronoi;
end 
--====================================================================

----------------------------------------------------------------------
function createSimpleColor()
    local color ={}
    --================================================================
    color[0] ={r=255,g=0  ,b=0,a=255};
    color[1] ={r=0  ,g=255,b=0,a=255};
    color[2] ={r=0  ,g=0,b=255,a=255};
    return color;
end 

--====================================================================

----------------------------------------------------------------------
-- @param  hue_   0=red,-90=blue,90=green, --each 30 degree ??
-- @param  saturation_ (float 0.0~1.0)
-- @param  bright_ (float 0.0~1.0)
-- @return r,g,b
----------------------------------------------------------------------
function  HSVToRGB (hue_, saturation_ , bright_)
    --================================================================
    local r,g,b,h,f,v,p,q,t
    local hue = hue_
    local saturation =saturation_
    --================================================================
    if( hue > 360) then
        hue = hue - 360
    elseif(hue < 0) then
        hue = hue + 360
    end
    --================================================================
    if(saturation > 1) 
    then
        saturation = 1.0
    elseif ( saturation < 0) 
    then
        saturation = 0.0
    end
    --================================================================
    v = math.floor( 255 * bright_)
    --================================================================
    if( v > 255)  
    then
        v = 255
    elseif(v < 0) 
    then
        v = 0
    end
    --================================================================
    if(saturation == 0)
    then
        r = v
        g = v
        b = v
    else
        --============================================================
        h = math.floor( hue / 60)
        f = hue / 60-h
        p = math.floor( v * (1-saturation))
        --============================================================
        if( p < 0) 
        then
            p = 0
        elseif( p > 255 )
        then
            p = 255
        end
        --============================================================
        q = math.floor( v * (1-f * saturation))
        --============================================================
        if( q < 0 )
        then
            q = 0
        elseif( q > 255 )
        then
            q = 255
        end
        --============================================================
        t=math.floor( v * (1-(1-f) * saturation))
        --============================================================
        if( t < 0 )
        then
            t = 0
        elseif( t > 255 )
        then
            t = 55
        end
        --============================================================
        if ( h==0 )then
            r=v
            g=t
            b=p
        elseif (h==1)then
            r=q
            g=v
            b=p
        elseif (h==2)then
            r=p
            g=v
            b=t
        elseif (h==3)then
            r=p
            g=q
            b=v
        elseif (h==4)then
            r=t
            g=p
            b=v
        elseif (h==5)then
            r=v
            g=p
            b=q
        else
            r=v
            g=t
            b=p
        end
    end
    --================================================================
    return r,g,b
end
--====================================================================

----------------------------------------------------------------------
-- @param saturation(float)
----------------------------------------------------------------------
function createHsvColor(saturation)
    --================================================================
    local color ={}
    local num = 360/30 --12
    --================================================================
    for i = 0,num
    do 
        local r,g,b = HSVToRGB ( 30 * i, saturation,1)
        color[i] ={ r=r , g=g , b=b ,a=255};
    end 
    --================================================================
    return color;
end 
--====================================================================

----------------------------------------------------------------------
-- @within Colors
-- @return colorTable
----------------------------------------------------------------------
function createColor_Rainbow()
    --================================================================
    local color ={}
    --================================================================
    color[0]={r = 0x1B ,g = 0x00,b = 0xAF}
    color[1]={r = 0x1F ,g = 0xC3,b = 0xF7}
    color[2]={r = 0xCB ,g = 0xED,b = 0x09}
    color[3]={r = 0xFA ,g = 0x1C,b = 0x09}
    color[4]={r = 0xD8 ,g = 0x10,b = 0x14}
    --================================================================
    return color
end 
--====================================================================

----------------------------------------------------------------------
-- @within Colors
-- @return colorTable
----------------------------------------------------------------------
function createColor_Warm()
    --================================================================
    local color ={}
    --================================================================
    color[0]={r = 0x1F ,g = 0x1C,b = 0x0B}
    color[1]={r = 0x80 ,g = 0x36,b = 0x2F}
    color[2]={r = 0xF0 ,g = 0x8C,b = 0x86}
    color[3]={r = 0xDB ,g = 0xD0,b = 0xD2}
    color[4]={r = 0xF5 ,g = 0x87,b = 0x58}
    --================================================================
    return color
end 
--====================================================================

----------------------------------------------------------------------
-- @within Colors
-- @return colorTable
----------------------------------------------------------------------
function createColor_Blues()
    --================================================================
    local color ={}
    --================================================================
    color[0]={r = 0x20 ,g = 0xD9,b = 0xDB}
    color[1]={r = 0x23 ,g = 0xBD,b = 0xD4}
    color[2]={r = 0x1A ,g = 0x6F,b = 0xE0}
    color[3]={r = 0x23 ,g = 0x1E,b = 0x60}
    color[4]={r = 0x11 ,g = 0x34,b = 0x2F}
    --================================================================
    return color
end 
--====================================================================

----------------------------------------------------------------------
-- @within Colors
-- @return colorTable
----------------------------------------------------------------------
function createColor_Autumun()
    --================================================================
    local color ={}
    --================================================================
    color[0]={r = 0xF3 ,g = 0xB8,b = 0x05}
    color[1]={r = 0xF0 ,g = 0xA1,b = 0x03}
    color[2]={r = 0xD9 ,g = 0x68,b = 0x01}
    color[3]={r = 0x31 ,g = 0x1B,b = 0x00}
    color[4]={r = 0xBE ,g = 0x28,b = 0x02}
    --================================================================
    return color
end 
--====================================================================

----------------------------------------------------------------------
-- @within Colors
-- @return colorTable
----------------------------------------------------------------------
function createColor_Cafe()
    --================================================================
    local color ={}
    --================================================================
    color[0]={r = 0x3E ,g = 0x41,b = 0x47}
    color[1]={r = 0xFF ,g = 0xFE,b = 0xDF}
    color[2]={r = 0xDF ,g = 0xBA,b = 0x69}
    color[3]={r = 0x5A ,g = 0x2E,b = 0x2E}
    color[4]={r = 0x2A ,g = 0x2C,b = 0x31}
    --================================================================
    return color
end 
--====================================================================

----------------------------------------------------------------------
-- @within Colors
-- @return colorTable
----------------------------------------------------------------------
function createColor_Patriot()
    --================================================================
    local color ={}
    --================================================================
    color[0]={r = 0xFF ,g = 0xFF,b = 0xFF}
    color[1]={r = 0xFF ,g = 0x00,b = 0x00}
    color[2]={r = 0x00 ,g = 0x00,b = 0xFF}
    --================================================================
    return color
end 
--====================================================================

----------------------------------------------------------------------
-- @within Colors
-- @return colorTable
----------------------------------------------------------------------
function createColor_Toxic()
    --================================================================
    local color ={}
    --================================================================
    color[0]={r = 0xAE ,g = 0xFF,b = 0x00}
    color[1]={r = 0xA6 ,g = 0xD4,b = 0x44}
    color[2]={r = 0xAB ,g = 0xA9,b = 0xA9}
    color[3]={r = 0x80 ,g = 0x80,b = 0x80}
    color[4]={r = 0x62 ,g = 0x66,b = 0x54}
    --================================================================
    return color
end 
--====================================================================

----------------------------------------------------------------------
-- @within Colors
-- @return colorTable
----------------------------------------------------------------------
function createColor_Thief()
    --================================================================
    local color ={}
    --================================================================
    color[0]={r = 0x1A ,g = 0x08,b = 0x04}
    color[1]={r = 0x1A ,g = 0x30,b = 0x19}
    color[2]={r = 0x09 ,g = 0x6A,b = 0x47}
    color[3]={r = 0x10 ,g = 0x3F,b = 0x27}
    color[4]={r = 0x21 ,g = 0x0F,b = 0x0B}
    --================================================================
    return color
end 
--====================================================================
