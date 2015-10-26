--==================================================================
-- get multibyte string lengh
--==================================================================
function getMbLengh(multibyteStr)
    --==============================================================
    local out = ""
    local str= multibyteStr
    local oneStr  =  ""
    local oneStrByte = nil
    local offsetByte = 0
    local currentPos = 1
    --==============================================================
    local allStrCount = 0 --string lengh
    --==============================================================
    --get stringLengh
    --==============================================================
    while (  true )
    do 
        oneStr  =  string.sub(multibyteStr,currentPos,currentPos)
        oneStrByte = string.byte(oneStr)
        --==========================================================
        if ( oneStrByte ==nil)then    break;    end
        --==========================================================
        if     oneStrByte < 0x80 then     offsetByte = 1
        elseif oneStrByte < 0xE0 then     offsetByte = 2
        elseif oneStrByte < 0xF0 then     offsetByte = 3
        elseif oneStrByte < 0xF8 then     offsetByte = 4
        elseif oneStrByte < 0xFC then     offsetByte = 5
        elseif oneStrByte < 0xFE then     offsetByte = 6
        end
        --==========================================================
        currentPos = currentPos + offsetByte
        allStrCount =allStrCount+1
    end
    --==============================================================
    out = allStrCount
    --==============================================================
    return out 
    --==============================================================
end
--==================================================================

--==================================================================
-- multibyte utf string  substring
--==================================================================
function mbStrSub(multibyteStr,start_,end_)
    --==============================================================
    if type (multibyteStr) ~="string" then return "-" end 
    --==============================================================
    local out = ""
    --==============================================================
    local oneStr  =  ""
    local oneStrByte = nil
    --==============================================================
    local allStrCount =0
    --==============================================================
    local offsetByte = 0
    local currentPos = 1
    local currentStrNum = 1
    local eachStrTable = {} 
    --==============================================================
    -- each string to Table
    --==============================================================
    while (  true )
    do 
        --==========================================================
        oneStr = string.sub(multibyteStr,currentPos,currentPos)
        oneStrByte = string.byte(oneStr)
        --==========================================================
        if ( oneStrByte == nil )then break;end
        --==========================================================
        if     oneStrByte < 0x80 then  offsetByte = 1
        elseif oneStrByte < 0xE0 then  offsetByte = 2
        elseif oneStrByte < 0xF0 then  offsetByte = 3
        elseif oneStrByte < 0xF8 then  offsetByte = 4
        elseif oneStrByte < 0xFC then  offsetByte = 5
        elseif oneStrByte < 0xFE then  offsetByte = 6
        end
        --==========================================================
        local currentStr = string.sub(multibyteStr,currentPos,currentPos+(offsetByte-1))
        currentPos = currentPos + offsetByte
        --==========================================================
        if ( currentStr ~= nil)
        then 
            table.insert( eachStrTable,currentStr )
        end
        --==========================================================
        allStrCount = allStrCount+1
    end
    --==============================================================
    local startPos = start_ or 1 
    local endPos = end_ or allStrCount 
    --==============================================================
    if ( startPos < 1 )then startPos = 1 end 
    if ( endPos < startPos ) then endPos =startPos end 
    if ( startPos > endPos ) then startPos =endPos-1 end 
    if ( endPos  >  allStrCount ) then endPos =allStrCount end 
    --==============================================================
    for i=startPos,endPos 
    do 
        out = out .. eachStrTable[i]
    end 
    --==============================================================
    return out 
    --==============================================================
end
--==================================================================
