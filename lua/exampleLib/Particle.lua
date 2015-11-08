
--====================================================================
-- @module particle
--====================================================================
local ffi = require("ffi")
local bit = require("bit")
local DxLib = require("DxLib_ffi");
--====================================================================

----------------------------------------------------------------------
-- get rotate pos 
-- @param ox --origin Pos x
-- @param oy
-- @param x -- pos
-- @param y
-- @param angleRad --angleRad
-- @return first x,second y
----------------------------------------------------------------------
local function rotPoint(ox,oy,x,y,angleRad)
    local lx = x -ox
    local ly = y -oy
    local px = lx * math.cos(angleRad) - ly *math.sin(angleRad)
    local py = lx * math.sin(angleRad) + ly *math.cos(angleRad)
    local rotX = ox+px 
    local rotY = oy+py
    return rotX,rotY
end
--====================================================================

-- -factory ParticleSingle
----------------------------------------------------------------------
-- -param imageHandle
-- -param startX particle start Posx
-- -param startY particle start Posx
-- -constructor 
-- -within Constrcutor
----------------------------------------------------------------------
function createParticleSingle(imageHandle,startX,startY)
    local ParticleSingle ={}
    ParticleSingle.x = startX or 0
    ParticleSingle.y = startY or 0
    ParticleSingle.imageHandle = imageHandle
    --================================================================
    -- start setting
    ParticleSingle.life = 60;
    ParticleSingle.alpha = 0;
    ParticleSingle.angle = 0.2
    ParticleSingle.zoom = 1;
    ParticleSingle.oAngle = 0 
    --================================================================
    -- setting 
    ParticleSingle.blendMode = DxLib.DX_BLENDMODE_ALPHA
    ParticleSingle.forceX = math.random() -0/5
    ParticleSingle.forceY = math.random() -0/5
    ParticleSingle.forceAngle = 0.4 *(math.random()-0.5);
    ParticleSingle.forceZoom = 0.2;
    ParticleSingle.incrementForceX = 1  --decrease, increase(0.97 ~1.05)??
    ParticleSingle.incrementForceY = 1  
    ParticleSingle.incrementAngle  = 1
    ParticleSingle.incrementZoom   = 1
    ParticleSingle.oX = startX -- oAngle origin pos x
    ParticleSingle.oY = startY 
    ParticleSingle.oAngleForce= 0;
    ParticleSingle.incrementOAngleForce=1;--decrease, increase (0.97 ~1.05)??
    --================================================================
    ParticleSingle.m_startX =startX
    ParticleSingle.m_startY =startY
    ParticleSingle.m_forceAlpha =1.0/(ParticleSingle.life/2)
    ParticleSingle.m_lifeCount =0;
    ParticleSingle.m_fadeDive = 2;
    --================================================================
    function ParticleSingle:updateAndDraw()
        self:update();
        self:draw();
    end 
    --================================================================
    function ParticleSingle:update()
        --============================================================
        self.x = self.x +self.forceX;
        self.y = self.y +self.forceY;
        --============================================================
        self.angle = self.angle + self.forceAngle;
        self.zoom  = self.zoom  + self.forceZoom;
        self.oAngle = self.oAngle + self.oAngleForce
        --============================================================
        if (self.incrementForceX ~= 1)
        then 
            self.forceX =  self.forceX * self.incrementForceX
        end 
        if (self.incrementForceY ~= 1)
        then 
            self.forceY =  self.forceY * self.incrementForceY
        end
        --============================================================
        if (self.incrementAngle ~= 1)
        then 
            self.forceAngle =  self.forceAngle * self.incrementAngle
        end 
        if (self.incrementZoom ~= 1)
        then 
            self.forceZoom =  self.forceZoom * self.incrementZoom
        end
        --============================================================
        if (self.incrementOAngleForce ~= 1)
        then 
            self.oAngleForce =  self.oAngleForce * self.incrementOAngleForce
        end
        --============================================================
        
        --============================================================
        self.m_lifeCount = self.m_lifeCount +1;
        --============================================================
        if ( self.m_lifeCount < (self.life/self.m_fadeDive))
        then 
            self.alpha =self.alpha + self.m_forceAlpha;
        elseif ( self.m_lifeCount > self.life -(self.life/self.m_fadeDive))
        then 
            self.alpha =self.alpha - self.m_forceAlpha;
        else
            self.alpha =self.alpha + self.m_forceAlpha;
        end 
        --============================================================
    end 
    --================================================================
    function ParticleSingle:draw()
        local blend,param = getDrawBlendMode();
        --============================================================
        DxLib.dx_SetDrawBlendMode(self.blendMode , self.alpha *255 ) ;
        --============================================================
        local x_, y_ = rotPoint( self.oX
                               , self.oY
                               , self.x
                               , self.y
                               , self.oAngle
                               )
        --============================================================
        DxLib.dx_DrawRotaGraph( x_ --x 
                              , y_ --y
                              , self.zoom
                              , self.angle
                              , self.imageHandle 
                              , true     -- TransFlag,  
                              , false ); -- invert flag (  TurnFlag)
        --============================================================                
        DxLib.dx_SetDrawBlendMode(blend,param);
    end
    --================================================================
    function ParticleSingle:isFinished()
        return ( self.m_lifeCount > self.life);
    end 
    --================================================================
    function ParticleSingle:_calcForceAlpha()
        self.m_forceAlpha =  1.0/(self.life/self.m_fadeDive)
    end 
    --================================================================
    ParticleSingle:_calcForceAlpha()
    --================================================================
    return ParticleSingle
end 
--====================================================================

-- @factory ParticleSingle

----------------------------------------------------------------------
-- @param[opt=100] maxNum
-- @param[opt=1/1000*30] waitTime default 1/1000 *30 -- 30 ms
-- @constructor 
-- @within Constrcutor
----------------------------------------------------------------------
function createParticleManager(maxNum,waitTime)
    local ParticleManager = {}
    ParticleManager.particleTable = {}
    ParticleManager.maxNum =maxNum or 300
    ParticleManager.m_waitTime =  waitTime or 1/1000 *30 -- 30 ms
    ParticleManager.m_lastAddTime = os.clock();
    --================================================================
    
    ------------------------------------------------------------------
    -- @param imageHandle
    -- @param x
    -- @param y
    -- @param[opt=1] num
    -- @return bool is add Particle
    ------------------------------------------------------------------
    function ParticleManager:addPartcileType1(imageHandle,x,y,num,forceAdd)
        --============================================================
        if ( self:_checkTime()==false and forceAdd==nil )
        then return false;end 
        --============================================================
        local num_ = num or 1
        --============================================================
        for i=1,num
        do
            local temp = createParticleSingle(imageHandle,x,y);
            temp.life = 120 *math.random();
            temp.forceX = 20 * (math.random() -0.5)
            temp.forceY = 20 * (math.random() -0.5)
            temp.forceAngle = math.rad(10*(math.random()-0.5))
            temp.forceZoom =(0.0211*math.random())
            temp.zoom = 0 --start zoom
            temp.oAngleForce = math.rad(3)
            table.insert ( self.particleTable,temp)
        end 
        return true;
    end 
    --================================================================

    ------------------------------------------------------------------
    -- @param imageHandle
    -- @param x
    -- @param y
    -- @param[opt=1] num
    -- @return bool is add Particle
    ------------------------------------------------------------------
    function ParticleManager:addPartcileType2(imageHandle,x,y,num,forceAdd)
        --============================================================
        if ( self:_checkTime()== false and forceAdd==nil )
        then return false;end 
        --============================================================
        local num_ = num or 1
        --============================================================
        for i=1,num_
        do
            local temp = createParticleSingle(imageHandle,x,y);
            temp.life = 100 *math.random();
            temp.forceX = 2 * (math.random() -0.5)
            temp.forceY = 2 * (math.random() -0.5)
            temp.forceAngle = math.rad(10*(math.random()-0.5))
            temp.forceZoom =(0.04*math.random())
            --temp.zoom = 0.3*math.random()
            temp.zoom = 0
            table.insert ( self.particleTable,temp)
        end 
        return true;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- @param imageHandle
    -- @param x
    -- @param y
    -- @param[opt=1] num
    -- @return bool is add Particle
    ------------------------------------------------------------------
    function ParticleManager:addPartcileType3(imageHandle,x,y,num,forceAdd)
        --============================================================
        if ( self:_checkTime()==false and forceAdd==nil )
        then return false;end 
        --============================================================
        local num_ = num or 1
        --============================================================
        for i=1,num_
        do
            local temp = createParticleSingle(imageHandle,x,y);
            temp.life = 120 *math.random();
            temp.forceX = 1 * (math.random() -0.5)
            temp.forceY = 1 * (math.random() -0.5)
            temp.forceAngle = math.rad(10*(math.random()-0.5))
            temp.forceZoom =(0.00211*math.random())
            temp.incrementForceX = 1.03  --decrease, increase(0.97 ~1.05)??
            temp.incrementForceY = 1.03  
            temp.zoom = 0
            table.insert ( self.particleTable,temp)
        end 
        return true;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- @param imageHandle
    -- @param x
    -- @param y
    -- @param[opt=1] num
    -- @return bool is add Particle
    ------------------------------------------------------------------
    function ParticleManager:addPartcileType4(imageHandle,x,y,num,forceAdd)
        --============================================================
        if ( self:_checkTime()==false and forceAdd==nil )
        then return false;end 
        --============================================================
        local num_ = num or 1
        --============================================================
        for i=1,num_
        do
            local temp = createParticleSingle(imageHandle,x,y);
            temp.life = 120 *math.random();
            temp.forceX = 20 * (math.random() -0.5)
            temp.forceY = 20 * (math.random() -0.5)
            temp.forceAngle = math.rad(10*(math.random()-0.5))
            temp.forceZoom =(0.0211*math.random())
            temp.zoom = 0 --start zoom
            temp.oAngleForce = math.rad(3)
            temp.incrementForceX = 0.99  
            temp.incrementForceY = 0.99  
            temp.incrementForceX = 0.98  
            temp.incrementForceY = 0.98 
            temp.incrementAngle  = 1.01
            table.insert ( self.particleTable,temp)
        end 
        return true;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- updateAndDraw
    ------------------------------------------------------------------
    function ParticleManager:updateAndDraw()
        self:_checkParticle();
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- 
    ------------------------------------------------------------------
    function ParticleManager:getParticleNum()
        return #self.particleTable
    end 
    --================================================================
    
    --================================================================
    function ParticleManager:_checkTime()
        local isNeedAdd = false;
        local t = os.clock()
        --============================================================
        if (t- self.m_lastAddTime > self.m_waitTime )
        then 
            isNeedAdd = true;
            self.m_lastAddTime = os.clock();
        end 
        --============================================================
        return isNeedAdd ;
    end
    --================================================================
    function ParticleManager:_checkParticle()
        --============================================================
        for i,v in ipairs(self.particleTable)
        do
            v:updateAndDraw()
        end 
        --============================================================
        for i,v in ipairs(self.particleTable)
        do
            if ( v:isFinished())
            then 
                table.remove(self.particleTable,i);
                --break;
            end 
        end 
        --============================================================
        while (#self.particleTable > self.maxNum )
        do
            table.remove(self.particleTable,1);
        end 
        --============================================================
    end
    --================================================================
    
    --================================================================
    return ParticleManager;
end 
--====================================================================

