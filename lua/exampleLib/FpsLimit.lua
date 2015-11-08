
----------------------------------------------------------------------
-- @module FPS
----------------------------------------------------------------------

--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
--====================================================================

----------------------------------------------------------------------
-- @factory FpsLimit

----------------------------------------------------------------------
-- @constructor
-- @within Constructor
----------------------------------------------------------------------
function createFpsLimit()
    --================================================================
    local FpsLimit ={}
    FpsLimit.fps =0
    FpsLimit._fpsTable ={}
    FpsLimit.avgCount =60
    FpsLimit.lastTime = 0
    --================================================================
    
    ------------------------------------------------------------------
    -- getFps (avg)
    ------------------------------------------------------------------
    function FpsLimit:getFps() 
        local sumFps = 0
        for i,v in ipairs(self._fpsTable)
        do
            sumFps =sumFps+v;
        end
        return sumFps/self.avgCount
    end
    --================================================================
    
    ------------------------------------------------------------------
    -- limit FPS
    -- @tparam int limitFps
    ------------------------------------------------------------------
    function FpsLimit:limitFps(limitFps)
        --============================================================
        local nowTime = self:getTime()
        --============================================================
        local distanceTime = nowTime -self.lastTime
        local targetTime =1000/limitFps
        local sleepTime_W = targetTime - distanceTime
        --============================================================
        if ( sleepTime_W >0 ) 
        then 
            DxLib.dx_WaitTimer( sleepTime_W)
        end
        --============================================================
        local waitedTime = self:getTime()
        self.fps = 1000/(waitedTime -self.lastTime)
        self.lastTime = waitedTime
        --============================================================
        table.insert ( self._fpsTable,self.fps);
        table.remove ( self._fpsTable,1);
        --============================================================
    end
    --================================================================
    
    --================================================================
    function FpsLimit:getTime()
        -- if use DxLib
        return DxLib.dx_GetNowCount(false);
        --============================================================
        -- case of native lua
        -- return os.clock()*1000;
    end 
    --================================================================
    function FpsLimit:sleep(n)  -- seconds
        -- if use DxLib
        DxLib.dx_WaitTimer( n)
        --============================================================
        -- case of native lua
        -- local t0 = os.clock()
        -- while os.clock() - t0 <= n/1000 do end
    end
    --================================================================
    function FpsLimit:_initFpsTable()
        for i=1,self.avgCount
        do
            table.insert ( self._fpsTable,0);
        end 
    end
    --================================================================
    
    --================================================================
    FpsLimit.lastTime = FpsLimit:getTime();
    FpsLimit:_initFpsTable();
    --================================================================
    return FpsLimit;
end 
--====================================================================