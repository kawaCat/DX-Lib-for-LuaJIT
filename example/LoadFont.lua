    
----------------------------------------------------------------------
-- @module FontResource
----------------------------------------------------------------------
    
--====================================================================
local ffi = require("ffi")
--====================================================================
ffi.cdef
[[
    typedef const char* LPCSTR;
    typedef unsigned long       DWORD;
    typedef void*       PVOID;
    typedef int                 BOOL;
    int  AddFontResourceExA(  LPCSTR name,  DWORD fl,  PVOID res);
    BOOL RemoveFontResourceExA(  LPCSTR name,  DWORD fl,  PVOID pdv);
]]
--====================================================================
local FR_PRIVATE   = 0x10 -- from winApi
local FR_NOT_ENUM  = 0x20
--====================================================================

----------------------------------------------------------------------
-- @factory FontResource
--

----------------------------------------------------------------------
-- load font resource 
-- @constructor
-- @within Constructor
-- @param fontPath_ from luajit path 
----------------------------------------------------------------------
function createFontResource(fontPath_)
    local FontResource = {};
    FontResource.fontPath = fontPath_;
    --================================================================
    
    ------------------------------------------------------------------
    -- remove font resource 
    ------------------------------------------------------------------
    function FontResource:destroy()
        local result =  ffi.C.RemoveFontResourceExA( self.fontPath,FR_PRIVATE,nil);
        if ( result ~= true ) 
        then 
            --print ( "cantRemoveFontResource !!:" ..s(self.fontPath ) )
        end 
    end 
    --================================================================
    
    ------------------------------------------------------------------
    -- add font resource. was called at createFontResource()
    ------------------------------------------------------------------
    function FontResource:addResource()
        local result = ffi.C.AddFontResourceExA( self.fontPath ,FR_PRIVATE,nil);
        if ( result ~=true ) 
        then 
            --print ( "cant Load Font !!:" .. result .. s(self.fontPath ))
        end 
    end 
    --================================================================
    
    --================================================================
    FontResource:addResource();
    --================================================================
    return FontResource;
end 
--====================================================================