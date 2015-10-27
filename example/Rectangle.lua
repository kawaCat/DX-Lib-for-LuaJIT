
----------------------------------------------------------------------
-- @module Rectangle
----------------------------------------------------------------------

--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
--====================================================================

----------------------------------------------------------------------
-- @factory Rectangle

----------------------------------------------------------------------
-- @param x -- left Top position. and this use as base position 
-- @param y -- left Top position. and this use as base position 
-- @param width -- this use as base size
-- @param height --this use as base size
-- @constructor
-- @within Constructor
----------------------------------------------------------------------
function createRectangle(x,y,width,height)
    --================================================================
    local Rectangle ={}
    Rectangle.x = x  or 0
    Rectangle.y = y  or 0
    Rectangle.width  = width or 100
    Rectangle.height = height or 100
    Rectangle.pos = {} -- x,y,z -- pos1[1],pos[2].. -- yet create
    Rectangle.lastPos = {} -- x,y,z -- pos1[1],pos[2].. -- yet create
    Rectangle.translateVector = DxLib.dx_VGet(0,0,0); -- x,y,z
    Rectangle.scaleVector     = DxLib.dx_VGet(1,1,1); -- x,y,z
    Rectangle.angleVector     = DxLib.dx_VGet(0,0,0); -- x,y,z
    Rectangle.matrix = nil; -- yet create Matrix
    Rectangle.parentRect = nil; -- if need 
    Rectangle.lastRect =nil
    --================================================================
    
    ------------------------------------------------------------------
    -- set base position.
    -- @param x1
    -- @param y1
    ------------------------------------------------------------------
    function Rectangle:setPosition(x,y)
        self.x = x;
        self.y = y or self.y;
        self:_updateToVector();
    end;
    --================================================================
    
    ------------------------------------------------------------------
    -- set base width and height.
    -- @param width
    -- @param height
    ------------------------------------------------------------------
    function Rectangle:setSize(width,height)
        self.width  = width;
        self.height = height  or self.height;
        self:_updateToVector();
    end;
    --================================================================
    
    ------------------------------------------------------------------
    -- set base position and size.
    -- @param x1
    -- @param y1
    -- @param width
    -- @param height
    ------------------------------------------------------------------
    function Rectangle:setArea(x,y,width,height)
        self.x = x;
        self.y = y;
        self.width  = width;
        self.height = height;
        self:_updateToVector();
    end;
    --================================================================
    
    ------------------------------------------------------------------
    -- set matrix translate
    -- @param moveX
    -- @param moveY
    -- @param moveZ
    ------------------------------------------------------------------
    function Rectangle:setTranslate(moveX,moveY,moveZ)
        self.translateVector = DxLib.dx_VGet(moveX,moveY,moveY);
    end ;
    --================================================================
    
    ------------------------------------------------------------------
    -- set matrix scale
    -- @param xScale
    -- @param yScale
    -- @param zScale
    ------------------------------------------------------------------
    function Rectangle:setScale(xScale,yScale,zScale)
        self.scaleVector  = DxLib.dx_VGet(xScale,yScale,zScale);
    end ;
    --================================================================
    
    ------------------------------------------------------------------
    -- set matrix rotation.
    -- @param xAngleRadian
    -- @param yAngleRadian
    -- @param zAngleRadian
    ------------------------------------------------------------------
    function Rectangle:setAngle(xRadian,yRadian,zRadian)
        self.angleVector = DxLib.dx_VGet(xRadian,yRadian,zRadian);
    end ;
    --================================================================
    
    ------------------------------------------------------------------
    -- @param Rectangle  if disable Rectangle , call as Rectangle(arg) is nil 
    ------------------------------------------------------------------
    function Rectangle:setParentRect(rectangle) self.parentRect = rectangle; end ;
    --================================================================
    
    ------------------------------------------------------------------
    -- get matrix
    ------------------------------------------------------------------
    function Rectangle:getMatrix() return self.matrix; end ;
    --================================================================
    
    ------------------------------------------------------------------
    -- reduced rectangle
    -- if already applied angle matrix rect , not working. 
    -- @param reduceX
    -- @param reduceY
    ------------------------------------------------------------------
    function Rectangle:reduced(reduceX,reduceY)
        local rect =  createRectangle() ;
        --============================================================
        -- overwrite 
        rect.pos[1].x = self.pos[1].x+reduceX;
        rect.pos[2].x = self.pos[2].x-reduceX;
        rect.pos[3].x = self.pos[3].x-reduceX;
        rect.pos[4].x = self.pos[4].x+reduceX;
        rect.pos[1].y = self.pos[1].y+reduceY;
        rect.pos[2].y = self.pos[2].y+reduceY;
        rect.pos[3].y = self.pos[3].y-reduceY;
        rect.pos[4].y = self.pos[4].y-reduceY;
        rect.pos[1].z = self.pos[1].z;
        rect.pos[2].z = self.pos[2].z;
        rect.pos[3].z = self.pos[3].z;
        rect.pos[4].z = self.pos[4].z;
        rect.lastPos = self.pos
        --============================================================
        rect.x = rect.pos[1].x
        rect.y = rect.pos[1].y
        rect.width  = rect.pos[2].x-rect.pos[4].x
        rect.height = rect.pos[3].y-rect.pos[1].y
        --============================================================
        return rect;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- get applied matrix rect.
    ------------------------------------------------------------------
    function Rectangle:getMatrixedRect()
        --============================================================
        -- error: NYI: cannot call this C function (yet) -- from luajit ffi?
        -- matrix = DxLib.dx_MMult( matrix, DxLib.dx_MGetScale( self.scaleVector  ) ) ;
        --============================================================
        -- set origin pos (base position) 
        local baseMat =  DxLib.dx_MGetTranslate( DxLib.dx_VGet( -self.x-self.width/2,-self.y-self.height/2 ,0));
        self.matrix = baseMat ;
        self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetScale( self.scaleVector   ));
        self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetRotX ( self.angleVector.x ));
        self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetRotY ( self.angleVector.y ));
        self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetRotZ ( self.angleVector.z ));
        -- revert origin pos
        self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MInverse( baseMat));
        --============================================================
        -- apply translate
        self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetTranslate( self.translateVector));
        --============================================================
        if (self.parentRect ~= nil )
        then 
            -- apply parent Rect matrix
            self.matrix = self:_MulMatrix( self.matrix, self.parentRect:getMatrix() ) ;
        end 
        --============================================================
        self.lastPos = self.pos
        local rect  = createRectangle() 
        -- overwrite 
        rect.pos[1]  = DxLib.dx_VTransform( self.pos[1], self.matrix ) ;
        rect.pos[2]  = DxLib.dx_VTransform( self.pos[2], self.matrix ) ;
        rect.pos[3]  = DxLib.dx_VTransform( self.pos[3], self.matrix ) ;
        rect.pos[4]  = DxLib.dx_VTransform( self.pos[4], self.matrix ) ;
        rect.lastPos = self.lastPos 
        rect.matrix = self.matrix 
        rect.x      = rect.pos[1].x
        rect.y      = rect.pos[2].y
        rect.width  = rect.pos[3].x-rect.pos[1].x
        rect.height = rect.pos[4].y-rect.pos[1].y
        --============================================================
        return rect;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- get allParent translate,angle,scale vector Sum
    ------------------------------------------------------------------
    function Rectangle:getOffsetVector()
        --============================================================
        local pr = self.parentRect;
        local translateVec = DxLib.dx_VGet(0,0,0);
        local scaleVec = DxLib.dx_VGet(0,0,0);
        local angleVec = DxLib.dx_VGet(0,0,0);
        while ( pr ~= nil )
        do
            -- vector add
            translateVec = DxLib.dx_VAdd( translateVec, pr.translateVector );
            scaleVec = DxLib.dx_VAdd( scaleVec, pr.scaleVector );
            angleVec = DxLib.dx_VAdd( angleVec, pr.angleVector );
            pr = pr.parentRect
        end 
        --============================================================
        return translateVec, scaleVec,angleVec;
    end 
    --================================================================
   
    ------------------------------------------------------------------
    -- check colision point
    -- @param point
    ------------------------------------------------------------------
    function Rectangle:checkColisionPoint(xPoint,yPoint)
        --============================================================
        local cnt = 0
        --============================================================
        for i=1,4,1
        do
            local next =i+1
            --========================================================
            if ( i+1 >4 ) then next =1 end 
            local x1 = self.pos[next].x - self.pos[i].x;
            local y1 = self.pos[next].y - self.pos[i].y;
            local x2 = xPoint - self.pos[i].x;
            local y2 = yPoint - self.pos[i].y;
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
        local out =false
        if (cnt <=-4 or cnt >= 4)
        then 
            out =true
        end
        --============================================================
        return out 
    end
    --================================================================
    
    ------------------------------------------------------------------
    -- check colision rectangle
    -- @param targetRect
    ------------------------------------------------------------------
    function Rectangle:checkColisionRect(targetRect)
        --============================================================
        for i=1,4
        do
            local point = targetRect.pos[i]
            local isContact = self:checkColisionPoint(point.x,point.y)
            if ( isContact ==true )
            then
                return true
            end
        end
        --============================================================
        return false 
    end
    --================================================================
    
    --================================================================
    -- from DX library refernce page.
    -- in MMult() function.
    -- http://homepage2.nifty.com/natupaji/DxLib/function/dxfunc_3d.html#R11N25
    --================================================================
    function Rectangle:_MulMatrix(In1,In2)
        --============================================================
        local mat = DxLib.dx_MGetIdent() ;
        --============================================================
        mat.m[0][0] = In1.m[0][0] * In2.m[0][0] + In1.m[0][1] * In2.m[1][0] 
                    + In1.m[0][2] * In2.m[2][0] + In1.m[0][3] * In2.m[3][0];
        mat.m[0][1] = In1.m[0][0] * In2.m[0][1] + In1.m[0][1] * In2.m[1][1] 
                    + In1.m[0][2] * In2.m[2][1] + In1.m[0][3] * In2.m[3][1];
        mat.m[0][2] = In1.m[0][0] * In2.m[0][2] + In1.m[0][1] * In2.m[1][2] 
                    + In1.m[0][2] * In2.m[2][2] + In1.m[0][3] * In2.m[3][2];
        mat.m[0][3] = In1.m[0][0] * In2.m[0][3] + In1.m[0][1] * In2.m[1][3] 
                    + In1.m[0][2] * In2.m[2][3] + In1.m[0][3] * In2.m[3][3];
        --============================================================
        mat.m[1][0] = In1.m[1][0] * In2.m[0][0] + In1.m[1][1] * In2.m[1][0] 
                    + In1.m[1][2] * In2.m[2][0] + In1.m[1][3] * In2.m[3][0];
        mat.m[1][1] = In1.m[1][0] * In2.m[0][1] + In1.m[1][1] * In2.m[1][1] 
                    + In1.m[1][2] * In2.m[2][1] + In1.m[1][3] * In2.m[3][1];
        mat.m[1][2] = In1.m[1][0] * In2.m[0][2] + In1.m[1][1] * In2.m[1][2] 
                    + In1.m[1][2] * In2.m[2][2] + In1.m[1][3] * In2.m[3][2];
        mat.m[1][3] = In1.m[1][0] * In2.m[0][3] + In1.m[1][1] * In2.m[1][3] 
                    + In1.m[1][2] * In2.m[2][3] + In1.m[1][3] * In2.m[3][3];
        --============================================================
        mat.m[2][0] = In1.m[2][0] * In2.m[0][0] + In1.m[2][1] * In2.m[1][0] 
                    + In1.m[2][2] * In2.m[2][0] + In1.m[2][3] * In2.m[3][0];
        mat.m[2][1] = In1.m[2][0] * In2.m[0][1] + In1.m[2][1] * In2.m[1][1] 
                    + In1.m[2][2] * In2.m[2][1] + In1.m[2][3] * In2.m[3][1];
        mat.m[2][2] = In1.m[2][0] * In2.m[0][2] + In1.m[2][1] * In2.m[1][2] 
                    + In1.m[2][2] * In2.m[2][2] + In1.m[2][3] * In2.m[3][2];
        mat.m[2][3] = In1.m[2][0] * In2.m[0][3] + In1.m[2][1] * In2.m[1][3] 
                    + In1.m[2][2] * In2.m[2][3] + In1.m[2][3] * In2.m[3][3];
        --============================================================
        mat.m[3][0] = In1.m[3][0] * In2.m[0][0] + In1.m[3][1] * In2.m[1][0] 
                    + In1.m[3][2] * In2.m[2][0] + In1.m[3][3] * In2.m[3][0];
        mat.m[3][1] = In1.m[3][0] * In2.m[0][1] + In1.m[3][1] * In2.m[1][1] 
                    + In1.m[3][2] * In2.m[2][1] + In1.m[3][3] * In2.m[3][1];
        mat.m[3][2] = In1.m[3][0] * In2.m[0][2] + In1.m[3][1] * In2.m[1][2] 
                    + In1.m[3][2] * In2.m[2][2] + In1.m[3][3] * In2.m[3][2];
        mat.m[3][3] = In1.m[3][0] * In2.m[0][3] + In1.m[3][1] * In2.m[1][3] 
                    + In1.m[3][2] * In2.m[2][3] + In1.m[3][3] * In2.m[3][3];  
        --============================================================
        return mat;
    end
    --================================================================
    function Rectangle:_updateToVector()
        self.lastPos = self.pos
        self.pos[1] = DxLib.dx_VGet(self.x           ,self.y            ,0);
        self.pos[2] = DxLib.dx_VGet(self.x+self.width,self.y            ,0);
        self.pos[3] = DxLib.dx_VGet(self.x+self.width,self.y+self.height,0);
        self.pos[4] = DxLib.dx_VGet(self.x           ,self.y+self.height,0);
    end;
    --================================================================
    
    --================================================================
    Rectangle:_updateToVector();
    --================================================================
    return Rectangle;
end
--====================================================================

