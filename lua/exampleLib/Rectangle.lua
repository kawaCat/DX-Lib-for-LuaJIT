
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
    Rectangle.pos = {}     -- x,y,z -- pos1[1],pos[2].. -- yet create
    Rectangle.translateVector = DxLib.dx_VGet(0,0,0); -- x,y,z
    Rectangle.scaleVector     = DxLib.dx_VGet(1,1,1); -- xScale,yScale,zScale
    Rectangle.angleVector     = DxLib.dx_VGet(0,0,0); -- xAngle,yAngle,zAngle
    Rectangle.matrix = DxLib.dx_MGetIdent() ; 
    Rectangle.optionalMatrix = nil; -- if need
    Rectangle.childRect ={}; -- if need 
    Rectangle.parentRect = nil;
    Rectangle._b_NeedReMatrix =true;
    Rectangle._scaleMatrix = nil;
    Rectangle._angleMatrix = nil;
    Rectangle._transMatrix = nil;
    --================================================================
    
    ------------------------------------------------------------------
    -- set base position.top left position.
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
    -- @param x1 -- top left
    -- @param y1 -- top left
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
        self.translateVector = DxLib.dx_VGet(moveX,moveY,moveZ);
        self:_needReMatrix();
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
        self:_needReMatrix();
    end ;
    --================================================================
    
    ------------------------------------------------------------------
    -- set matrix rotation.
    -- @param xRadian
    -- @param yRadian
    -- @param zRadian
    ------------------------------------------------------------------
    function Rectangle:setAngle(xRadian,yRadian,zRadian)
        self.angleVector = DxLib.dx_VGet(xRadian,yRadian,zRadian);
        self:_needReMatrix();
    end ;
    --================================================================
    
    ------------------------------------------------------------------
    -- set parent rect . if need.
    -- @param rectangle  if disable parent Rectangle , call as Rectangle(in arg) is nil.
    ------------------------------------------------------------------
    function Rectangle:setParentRect(rectangle)
        self.parentRect = rectangle; 
        --rectangle:addChildRect(rectangle)
        table.insert (self.parentRect.childRect,self);
    end ;
    --================================================================
    
    ------------------------------------------------------------------
    -- add child rectangle. 
    -- @param rectangle 
    -- @see setParentRect
    ------------------------------------------------------------------
    function Rectangle:addChildRect(rectangle)
        rectangle.parentRect = self; 
        table.insert (self.childRect,rectangle);
    end
    --================================================================
    
    ------------------------------------------------------------------
    -- get Center position.
    ------------------------------------------------------------------
    function Rectangle:getCenterPosition()
        local cx = self.x + self.width  /2
        local cy = self.y + self.height /2
        return cx,cy
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- get matrix.
    ------------------------------------------------------------------
    function Rectangle:getMatrix() return self.matrix; end ;
    --================================================================
    
    ------------------------------------------------------------------
    -- get inverse matrix.
    ------------------------------------------------------------------
    function Rectangle:getInverseMatrix()
        return DxLib.dx_MInverse( self.matrix)
    end
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
        if ( self._b_NeedReMatrix == true)
        then 
            -- set origin pos (base position) 
            local baseMat =  DxLib.dx_MGetTranslate( DxLib.dx_VGet( -self.x-self.width/2,-self.y-self.height/2 ,0));
            self.matrix = baseMat;
            --========================================================
            if (self.scaleVector .x ~=1 or self.scaleVector .y ~=1 or self.scaleVector.z ~=1 )    
            then 
                self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetScale( self.scaleVector   ));
            end
            --========================================================
            if ( self.angleVector.x ~=0.0)
            then 
                self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetRotX ( self.angleVector.x ));
            end
            if ( self.angleVector.y ~=0.0)
            then 
                self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetRotY ( self.angleVector.y ));
            end
            if ( self.angleVector.z ~=0.0)  
            then
                self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetRotZ ( self.angleVector.z ));
            end
            --========================================================
            -- revert origin pos
            self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MInverse( baseMat));
            --========================================================
            -- apply translate
            self.matrix = self:_MulMatrix( self.matrix, DxLib.dx_MGetTranslate( self.translateVector));
            --========================================================
            if (self.parentRect ~= nil )
            then 
                -- apply parent Rect matrix
                self.matrix = self:_MulMatrix( self.matrix, self.parentRect:getMatrix() ) ;
            end 
            --========================================================
            if ( self.optionalMatrix ~= nil)
            then 
                -- apply optional matrix
                self.matrix = self:_MulMatrix( self.matrix, self.optionalMatrix ) ;
            end 
            --========================================================
            self._b_NeedReMatrix  =false    
        end 
        --============================================================
        local rect  = createRectangle() 
        -- overwrite 
        rect.pos[1]  = DxLib.dx_VTransform( self.pos[1], self.matrix ) ;
        rect.pos[2]  = DxLib.dx_VTransform( self.pos[2], self.matrix ) ;
        rect.pos[3]  = DxLib.dx_VTransform( self.pos[3], self.matrix ) ;
        rect.pos[4]  = DxLib.dx_VTransform( self.pos[4], self.matrix ) ;
        rect.matrix  = self.matrix 
        rect.x       = rect.pos[1].x
        rect.y       = rect.pos[1].y
        rect.width   = rect.pos[2].x-rect.pos[1].x
        rect.height  = rect.pos[3].y-rect.pos[1].y
        rect.parentRect = self.parentRect;
        --============================================================
        return rect;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- get angle.return radian value.  (deg -180.0 ~ 180.0)
    ------------------------------------------------------------------
    function Rectangle:getAngle()
        -- ????
        --============================================================
        --local mat = self.matrix;
        local mat = self:getAngleMat();
        --============================================================
        local zRad_ =  math.atan2( mat.m[1][0],mat.m[0][0])
        local yRad_ = -math.asin ( mat.m[0][2]);
        --local yRad_ =  math.atan2 ( mat.m[0][2],mat.m[0][0]);
        local xRad_ =  math.atan2 ( mat.m[2][1],mat.m[2][2]) 
        --============================================================
        return xRad_,yRad_,zRad_;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- get allParent "translate,angle,scale" Sum vector 
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
    -- get applied "angle,Scale" Matrix.  origin pos is 0.0 , now
    ------------------------------------------------------------------
    function Rectangle:getAngleMat()
        --============================================================
        local mt =  DxLib.dx_MGetTranslate( DxLib.dx_VGet( 0,0 ,0));
        --mt = self:_MulMatrix( mt, DxLib.dx_MGetScale( self.scaleVector   ));
        mt = self:_MulMatrix( mt, DxLib.dx_MGetRotX ( self.angleVector.x ));
        mt = self:_MulMatrix( mt, DxLib.dx_MGetRotY ( self.angleVector.y ));
        mt = self:_MulMatrix( mt, DxLib.dx_MGetRotZ ( self.angleVector.z ));
        --============================================================
        if (self.parentRect ~= nil )
        then 
            mt = self:_MulMatrix( mt, self.parentRect:getAngleMat() ) ;
        end 
        --============================================================
        if ( self.optionalMatrix ~= nil)
        then 
            mt = self:_MulMatrix( mt, self.optionalMatrix ) ;
        end 
        --============================================================
        return mt;
    end
    --================================================================
    
    ------------------------------------------------------------------
    -- get applied "angle,Scale" Inverse Matrix. 
    ------------------------------------------------------------------
    function Rectangle:getInverseAngleMat()
        return DxLib.dx_MInverse( self:getAngleMat())
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- check colision point
    -- @param point
    ------------------------------------------------------------------
    function Rectangle:checkColisionPoint(x,y)
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
        if (cnt <=-4 or cnt >= 4)
        then 
            return true
        end
        --============================================================
        return false 
    end
    --================================================================
    
    ------------------------------------------------------------------
    -- check colision rectangle
    -- @param targetRect
    ------------------------------------------------------------------
    function Rectangle:checkColisionRect(targetRect)
        --============================================================
        for i=1,4,1
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
    function Rectangle:_needReMatrix()
        self._b_NeedReMatrix =true;
        --============================================================
        for i,v in ipairs(self.childRect)
        do
            v:_needReMatrix();
        end 
    end 
    --================================================================
    -- from DX library refernce page.
    -- in MMult() function.
    -- http://homepage2.nifty.com/natupaji/DxLib/function/dxfunc_3d.html#R11N25
    --================================================================
    function Rectangle:_MulMatrix(In1,In2)
        --============================================================
        local mat = DxLib.dx_MGetIdent() ;
        --local mat =DxLib.dx_MGetTranslate( DxLib.dx_VGet(0,0,0))
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


-- ???
-- test 
-- local test  = createRectangle()
-- local x_deg = 10
-- local y_deg = 120
-- local z_deg = 30
-- test:setAngle(math.rad(x_deg),math.rad(y_deg),math.rad(z_deg));
 
-- local xrad ,yrad,zrad = test:getAngle()
-- xrad =math.deg(xrad -math.pi)
-- yrad =math.deg(yrad)
-- zrad =math.deg(zrad)
-- print ( xrad,yrad,zrad)

--====================================================================
function _MulMatrix(In1,In2)
    --================================================================
    --local mat = DxLib.dx_MGetIdent() ;
    local mat =DxLib.dx_MGetTranslate( DxLib.dx_VGet(0,0,0))
    --================================================================
    mat.m[0][0] = In1.m[0][0] * In2.m[0][0] + In1.m[0][1] * In2.m[1][0] 
                + In1.m[0][2] * In2.m[2][0] + In1.m[0][3] * In2.m[3][0];
    mat.m[0][1] = In1.m[0][0] * In2.m[0][1] + In1.m[0][1] * In2.m[1][1] 
                + In1.m[0][2] * In2.m[2][1] + In1.m[0][3] * In2.m[3][1];
    mat.m[0][2] = In1.m[0][0] * In2.m[0][2] + In1.m[0][1] * In2.m[1][2] 
                + In1.m[0][2] * In2.m[2][2] + In1.m[0][3] * In2.m[3][2];
    mat.m[0][3] = In1.m[0][0] * In2.m[0][3] + In1.m[0][1] * In2.m[1][3] 
                + In1.m[0][2] * In2.m[2][3] + In1.m[0][3] * In2.m[3][3];
    --================================================================
    mat.m[1][0] = In1.m[1][0] * In2.m[0][0] + In1.m[1][1] * In2.m[1][0] 
                + In1.m[1][2] * In2.m[2][0] + In1.m[1][3] * In2.m[3][0];
    mat.m[1][1] = In1.m[1][0] * In2.m[0][1] + In1.m[1][1] * In2.m[1][1] 
                + In1.m[1][2] * In2.m[2][1] + In1.m[1][3] * In2.m[3][1];
    mat.m[1][2] = In1.m[1][0] * In2.m[0][2] + In1.m[1][1] * In2.m[1][2] 
                + In1.m[1][2] * In2.m[2][2] + In1.m[1][3] * In2.m[3][2];
    mat.m[1][3] = In1.m[1][0] * In2.m[0][3] + In1.m[1][1] * In2.m[1][3] 
                + In1.m[1][2] * In2.m[2][3] + In1.m[1][3] * In2.m[3][3];
    --================================================================
    mat.m[2][0] = In1.m[2][0] * In2.m[0][0] + In1.m[2][1] * In2.m[1][0] 
                + In1.m[2][2] * In2.m[2][0] + In1.m[2][3] * In2.m[3][0];
    mat.m[2][1] = In1.m[2][0] * In2.m[0][1] + In1.m[2][1] * In2.m[1][1] 
                + In1.m[2][2] * In2.m[2][1] + In1.m[2][3] * In2.m[3][1];
    mat.m[2][2] = In1.m[2][0] * In2.m[0][2] + In1.m[2][1] * In2.m[1][2] 
                + In1.m[2][2] * In2.m[2][2] + In1.m[2][3] * In2.m[3][2];
    mat.m[2][3] = In1.m[2][0] * In2.m[0][3] + In1.m[2][1] * In2.m[1][3] 
                + In1.m[2][2] * In2.m[2][3] + In1.m[2][3] * In2.m[3][3];
    --================================================================
    mat.m[3][0] = In1.m[3][0] * In2.m[0][0] + In1.m[3][1] * In2.m[1][0] 
                + In1.m[3][2] * In2.m[2][0] + In1.m[3][3] * In2.m[3][0];
    mat.m[3][1] = In1.m[3][0] * In2.m[0][1] + In1.m[3][1] * In2.m[1][1] 
                + In1.m[3][2] * In2.m[2][1] + In1.m[3][3] * In2.m[3][1];
    mat.m[3][2] = In1.m[3][0] * In2.m[0][2] + In1.m[3][1] * In2.m[1][2] 
                + In1.m[3][2] * In2.m[2][2] + In1.m[3][3] * In2.m[3][2];
    mat.m[3][3] = In1.m[3][0] * In2.m[0][3] + In1.m[3][1] * In2.m[1][3] 
                + In1.m[3][2] * In2.m[2][3] + In1.m[3][3] * In2.m[3][3];  
    --================================================================
    return mat;
end
--====================================================================