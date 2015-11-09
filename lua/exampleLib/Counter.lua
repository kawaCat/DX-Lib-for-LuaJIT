----------------------------------------------------------------------
-- @module Counter
----------------------------------------------------------------------

----------------------------------------------------------------------
-- @factory Counter

----------------------------------------------------------------------
-- between 0.0 ~ 1.0 counter.
-- use in animation.
-- @param[opt=60] frameNum 
-- @constructor
-- @within Constructor
----------------------------------------------------------------------
function createCounter(frameNum)
    local Counter ={}
    Counter.m_value =0;
    Counter.m_stepValue = 0;
    Counter.m_frameNum = frameNum or 60 
    --================================================================
    
    ------------------------------------------------------------------
    -- set counter frame.
    -- @param newFrameNum 
    ------------------------------------------------------------------
    function Counter:setCounterFrame(newFrameNum)
        self.m_frameNum = newFrameNum;
        self:_calcStepValue();
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- set to forward. in step()
    ------------------------------------------------------------------
    function Counter:setForward()
        self:_calcStepValue()
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- set to backword. in step()
    ------------------------------------------------------------------
    function Counter:setBackword()
        self:_calcStepValue()
        self:toggle();
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- set forward, backword inverse.
    ------------------------------------------------------------------
    function Counter:toggle()
        self.m_stepValue = self.m_stepValue * -1;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- reset
    ------------------------------------------------------------------
    function Counter:reset()
        self:_calcStepValue();
        self.m_value =0;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- is active
    ------------------------------------------------------------------
    function Counter:isActive()
        if (    self.m_value ~= 0.0 
            and self.m_vakue ~= 1.0)
        then 
            return true;
        end
        return false;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- is finished counter. (0.0 ~1.0 ) if finished ,counter value is 1.0 or 0.0
    ------------------------------------------------------------------
    function Counter:isFinished()
        if ( self.m_stepValue > 0)
        then 
            return (self.m_value >= 1.0)
        else
            return (self.m_value <= 0)
        end 
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- step counter value. usualy, whele calling onUpdate() or onDraw().
    ------------------------------------------------------------------
    function Counter:step()
        -- self.m_value = self.m_value + self.m_stepValue ;
        -- if ( self.m_value >= 1.0) then self.m_value = 1.0; end ;
        -- if ( self.m_value <= 0.0) then self.m_value = 0.0; end ;
        --============================================================  
        if (    self.m_value ~= 1.0 and self.m_stepValue > 0
            or  self.m_value ~= 0.0 and self.m_stepValue < 0 ) 
        then 
            self.m_value = self.m_value + self.m_stepValue;
            if ( self.m_value >= 1.0) then self.m_value = 1.0; end 
            if ( self.m_value <= 0.0) then self.m_value = 0.0; end ;
        end ;
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- get Counter Value
    ------------------------------------------------------------------
    function Counter:getValue() return self.m_value; end ;
    --================================================================
    
    --================================================================
    function Counter:_calcStepValue()
        self.m_stepValue = 1.0 / self.m_frameNum;
    end 
    --================================================================
    
    --================================================================
    Counter:_calcStepValue();
    --================================================================
    return Counter;
end 
--====================================================================

--local test =  createCounter(20) --20 frame counter
--local i = 1
--while (i <=100)
--do
--    test:step()
--    print ( i,test:getValue(),test:isFinished())
--    -- if ( test:isFinished() ==true )
--    if ( i ==80 )
--    then 
--        test:toggle()
--    end 
--    i =i +1 
--end 





