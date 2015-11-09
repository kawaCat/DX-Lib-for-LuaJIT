
math.randomseed(os.clock())
--====================================================================
local ffi = require("ffi")
local DxLib = require("DxLib_ffi");
local App = require("exampleLib")
local ode = require("ode_ffi")
--====================================================================
local screenW = 550;
local screenH = 350;
--====================================================================

-- font
local fontSize = 25
local fontHandle = nil;

-- for animation 
local count = 0;
local count_Cam = 0;

-- fps
local fpsLimit = createFpsLimit();
--====================================================================

local maxBallNum =60;
local maxBoxNum =60;
local contactNum =0; -- show contact num text
--====================================================================

local world = nil 
local space = nil
local contactgroup =nil 
--====================================================================

local ground = nil                 -- ground geom
local groundVec ={x=2,y=0.001,z=2} -- ground size vec
--====================================================================

local radius=0.1
local ballTable = {}  -- ball obj table
--====================================================================

local boxLengh = 0.2
local boxTable ={}    -- box obj table
local box_Model = nil -- .mv1 model file
--====================================================================

-- camera and light
local targetPos = { x = 0,y = 0,z = 3 }; 
local cameraPos = { x = 0,y = 0,z = 0 };
local lightDirection = {x =0,y =0,z =0};
--====================================================================

--====================================================================
function addBox(posX,posY,posZ)
    local mass = 1 --(kg)
    local lenghX = boxLengh
    local lenghY = boxLengh;
    local lenghZ = boxLengh;
    --================================================================
    local boby = ode.dBodyCreate(world);
    local m = ffi.new("dMass[1]");
    ode.dMassSetBoxTotal (m,mass,lenghX,lenghY,lenghZ);
    ode.dMassAdjust(m,mass);
    ode.dBodySetMass(boby,m);
    
    local geom = ode.dCreateBox(space,lenghX,lenghY,lenghZ);
    ode.dGeomSetBody(geom,boby);
    --================================================================
    ode.dBodySetPosition(boby,posX,posY,posZ);
    -- ode.dGeomSetPosition(geom,posX,posY,posZ); --synced
    --================================================================
    local temp ={}
    temp.body = boby;
    temp.lX = lenghX
    temp.lY = lenghY;
    temp.lZ = lenghZ;
    temp.x = x;
    temp.y = y;
    temp.z = z;
    temp.bounce = 1
    temp.color = DxLib.dx_GetColor(255*math.random(),255*math.random(),255*math.random())
    temp.geom = geom
    --================================================================
    table.insert ( boxTable,temp)
end 
--====================================================================
function addBall()
    local mass = 2 *math.random(); --(kg)
    --================================================================
    local boby = ode.dBodyCreate(world);
    local r = 0.1 *math.random() +0.01
    local m = ffi.new("dMass[1]");
    ode.dMassSetSphereTotal(m,mass,r);
    ode.dMassAdjust(m,mass);
    ode.dBodySetMass(boby,m);
    
    local geom = ode.dCreateSphere(space,r);
    ode.dGeomSetBody(geom,boby);
    --================================================================
    local x = 0+0.5*math.random()-0.5/2
    local y = 3
    local z = 2+1*math.random()
    ode.dBodySetPosition(boby,x,y,z);
    --================================================================
    local temp ={}
    temp.body = boby;
    temp.radius = r;
    temp.x = x;
    temp.y = y;
    temp.z = z;
    temp.bounce = 0.2+0.4*math.random();
    temp.color = DxLib.dx_GetColor(255*math.random(),255*math.random(),255*math.random())
    temp.geom = geom
    --================================================================
    table.insert ( ballTable,temp)
    --================================================================
end 
--====================================================================
function addForceBall()
    local mass = 0.5 *math.random();--(kg)
    --================================================================
    local boby = ode.dBodyCreate(world);
    local r = 0.1 *math.random() +0.01
    local m = ffi.new("dMass[1]");
    ode.dMassSetSphereTotal(m,mass,r);
    ode.dMassAdjust(m,mass);
    ode.dBodySetMass(boby,m);
    
    local geom = ode.dCreateSphere(space,r);
    ode.dGeomSetBody(geom,boby);
    --================================================================
    local cameraPos = DxLib.dx_GetCameraPosition();
    local x = cameraPos.x +2 * math.random()-1
    local y = cameraPos.y
    local z = cameraPos.z +2* math.random()
    
    local force = 
    {
         x =targetPos.x-cameraPos.x
        ,y =targetPos.y-cameraPos.y
        ,z =targetPos.z-cameraPos.z
    }
    
    ode.dBodySetPosition(boby,x,y,z);
    ode.dBodyAddForce(boby, force.x*50, force.y*50, force.z*50);
    --================================================================
    local temp ={}
    temp.body = boby;
    temp.radius = r;
    temp.x = x;
    temp.y = y;
    temp.z = z;
    temp.bounce = 0.2+0.2*math.random();
    temp.color = DxLib.dx_GetColor(255*math.random(),255*math.random(),255*math.random())
    temp.geom = geom
    --================================================================
    table.insert ( ballTable,temp)
    --================================================================
end 
--====================================================================
function _createStackBox(xNum,yNum,zNum,boxLengh_)
    local numX =xNum
    local numY =yNum
    local numZ =zNum
    for y_=1,numY
    do
        for z_ =1,numZ
        do
            if (z_ ==1 or z_ ==numZ )
            then 
                for x_ =1,numX
                do
                    addBox((x_-1)*boxLengh_ -0.5+boxLengh_/2 
                          ,(y_-1)*boxLengh_ +    boxLengh_/2
                          ,(z_-1)*boxLengh_ +3  -boxLengh_/2)
                end
            else
                addBox((0)     * boxLengh_ -0.5 +boxLengh_/2 
                      ,(y_-1)  * boxLengh_ +     boxLengh_/2
                      ,(z_-1)  * boxLengh_ +3   -boxLengh_/2)
                addBox((numX-1)* boxLengh_ -0.5 +boxLengh_/2 
                      ,(y_-1)  * boxLengh_ +     boxLengh_/2
                      ,(z_-1)  * boxLengh_ +3   -boxLengh_/2)  
            end
        end
    end 
    --================================================================
end
--====================================================================

--====================================================================
local function nearCallback(data,  o1,  o2 )
    --================================================================
    local isGround = (ground == o1) or ( ground == o2)
    local N = 1;
    local contact  =  ffi.new("dContact[?]",N);
    local n = ode.dCollide(o1,o2,N,contact[0].geom,ffi.sizeof("dContact"));
    --================================================================
    if (isGround ==false )
    then 
        contactNum = contactNum +1;
    end 
    --================================================================
    for i=0,n-1
    do
        --============================================================
        for ii,v in ipairs(ballTable)
        do 
            if (v.geom == o1 or v.geom == o2 )
            then 
                 contact[i].surface.mode = ode.dContactBounce
                 contact[i].surface.bounce = v.bounce;
                 contact[i].surface.mu   = ((1.0/0.0)) 
                 contact[i].surface.bounce_vel = 0.1; 
            end 
        end 
        for ii,v in ipairs(boxTable)
        do 
            if (   v.geom == o1 or v.geom == o2 )
            then 
                contact[i].surface.mode = ode.dContactBounce
                contact[i].surface.bounce = v.bounce;
                contact[i].surface.bounce_vel = -1 --disable
                contact[i].surface.mu   = ((1.0/0.0)) 
            end 
        end 
        --============================================================
        
        local c = ode.dJointCreateContact(world,contactgroup,contact[i]);
        ode.dJointAttach ( c
                         , ode.dGeomGetBody(contact[i].geom.g1)
                         , ode.dGeomGetBody(contact[i].geom.g2));
    end 
end 
--====================================================================

--====================================================================
function App.init ()
    --================================================================
    ode.dInitODE();
    --================================================================
    world = ode.dWorldCreate() ;
    ode.dWorldSetGravity(world,0,-3,0);
    space = ode.dHashSpaceCreate(nil);
    contactgroup =ode.dJointGroupCreate(0);
    --================================================================
    ground =  ode.dCreateBox( space,groundVec.x,groundVec.y,groundVec.z);    
    ode.dGeomSetPosition( ground, 0, -0.09, 3 ); 
    --================================================================
    
    --================================================================
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
    DxLib.dx_SetUseZBuffer3D( true ) ;
    DxLib.dx_SetWriteZBuffer3D( true ) ;
end
--====================================================================
function App.prepare()
   
    loadedFont = createFontResource("resources/luximb.ttf"); 
    fontHandle = DxLib.dx_CreateFontToHandle( "Luxi Mono"
                                              , fontSize
                                              , 0
                                              , DxLib.DX_FONTTYPE_ANTIALIASING
                                              , -1
                                              , 0
                                              , false
                                              , false
                                              )
    
    --================================================================
    box_Model = DxLib.dx_MV1LoadModel( "resources/basicModels/box.mv1" ) ;
    if ( box_Model ==-1)
    then 
        box_Model= DxLib.dx_MV1LoadModel( "example/resources/basicModels/box.mv1" ) ; 
    end 
    
    --================================================================
    ode.dInitODE();
    --================================================================
    world = ode.dWorldCreate() ;
    ode.dWorldSetGravity(world,0,-5,0);
    space = ode.dHashSpaceCreate(nil);
    contactgroup =ode.dJointGroupCreate(0);
    --================================================================
     
    ground =  ode.dCreateBox( space,groundVec.x,groundVec.y,groundVec.z);    
    ode.dGeomSetPosition( ground, targetPos.x, 0, targetPos.z); 
    --================================================================
    
    _createStackBox(3,1,4,boxLengh);
end
--====================================================================
function App.onMouseDrag(MouseEvent,mouseX,mouseY)
    
    addBall();
    addForceBall();
    
    --================================================================
    if(#ballTable > maxBallNum )
    then
        ode.dGeomDestroy (ballTable[1].geom);
        ode.dBodyDestroy (ballTable[1].body);
        table.remove(ballTable,1)
        ode.dGeomDestroy (ballTable[1].geom);
        ode.dBodyDestroy (ballTable[1].body);
        table.remove(ballTable,1)
        return ;
    end 
end 
--====================================================================
function App.onMousePress(MouseEvent,mouseX,mouseY)
    --================================================================
    if (App.isMouseRightPress ==true )
    then
        for i,v in ipairs(ballTable)
        do
            ode.dGeomDestroy (v.geom);
            ode.dBodyDestroy (v.body);
        end 
        ballTable ={}
    end 
end
--====================================================================
function App.onUpdate(dt)
    --================================================================
    count = count + (dt/4)
    --================================================================
    if ( count >1.0)
    then
        count =0;
    end 
    --================================================================
    count_Cam = count_Cam+(dt/20)
    if ( count_Cam >1.0)
    then
        count_Cam =0;
    end 
end 
--====================================================================

--====================================================================
local function _updateCamera()
    --================================================================
    cameraPos.x = 2 * math.sin(math.pi*2*count_Cam) +targetPos.x
    cameraPos.y = 2 + targetPos.y
    cameraPos.z = 2 * math.cos(math.pi*2*count_Cam) +targetPos.z
    
    lightDirection.x =targetPos.x-cameraPos.x
    lightDirection.y =targetPos.y-cameraPos.y
    lightDirection.z =targetPos.z-cameraPos.z

    DxLib.dx_SetCameraNearFar( 1.0, 30.0 ) ;
    DxLib.dx_SetCameraPositionAndTarget_UpVecY( cameraPos, targetPos);  
    DxLib.dx_SetLightDirection(lightDirection) ;
    DxLib.dx_SetLightPosition( {x=0,y=20,z=0} ) ;
end
--====================================================================
local function _checkLengthFromCamera(objTable)
    for i,v in ipairs(objTable)
    do
        local pos_=ode.dBodyGetPosition(v.body);
        local cameraPos = DxLib.dx_GetCameraPosition();
        if (   math.abs(cameraPos.x -pos_[0] ) >10 
            or math.abs(cameraPos.y -pos_[1] ) >10  
            or math.abs(cameraPos.z -pos_[2] ) >10 )
        then 
            ode.dGeomDestroy (v.geom);
            ode.dBodyDestroy (v.body);
            table.remove(objTable,i)
            ode.dSpaceClean(space)
            break;
        end 
    end 
end 
--====================================================================
local function _checkMaxNum(objTable,maxNum)
    while (#objTable > maxNum )    
    do
        ode.dGeomDestroy (objTable[1].geom);
        ode.dBodyDestroy (objTable[1].body);
        table.remove(objTable,1)
    end
end 
--====================================================================

--====================================================================
local odeModelMat = ffi.new("dMatrix4[1]")
local odeMatT = ffi.new("dMatrix4[1]")
local odeMatR = ffi.new("dMatrix4[1]")
local mt = ffi.new("MATRIX[1]")
--====================================================================
local function _convertOdeMatToDxMat(r)
    mt[0].m[0][0]= r[0];   mt[0].m[0][1]= r[1];  mt[0].m[0][2]= r[2];   mt[0].m[0][3]= r[3];
    mt[0].m[1][0]= r[4];   mt[0].m[1][1]= r[5];  mt[0].m[1][2]= r[6];   mt[0].m[1][3]= r[7];
    mt[0].m[2][0]= r[8];   mt[0].m[2][1]= r[9];  mt[0].m[2][2]= r[10];  mt[0].m[2][3]= r[11];
    mt[0].m[3][0]= r[12];  mt[0].m[3][1]= r[13]  mt[0].m[3][2]= r[14];  mt[0].m[3][3]= r[15]
    return mt[0]
end 
--====================================================================
local function _drawObject()
    
    local blendMode ,blendParam = getDrawBlendMode();
    --================================================================
--++
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
    local groundPos = ode.dGeomGetPosition(ground);
    --================================================================
    DxLib.dx_MV1SetMatrix(box_Model,DxLib.dx_MGetIdent());
    DxLib.dx_MV1SetPosition( box_Model, DxLib.dx_VGet( groundPos[0]
                                                     , groundPos[1]
                                                     , groundPos[2]));
    DxLib.dx_MV1SetScale(  box_Model, { x=groundVec.x/2,y=groundVec.y/2,z=groundVec.z/2});
    DxLib.dx_MV1DrawModel( box_Model ) ;  
    --================================================================
    
    for i,v in ipairs(ballTable)
    do
        local pos_=ode.dBodyGetPosition(v.body);
        --local r=ode.dBodyGetRotation(v.body);
        DxLib.dx_DrawSphere3D( DxLib.dx_VGet( pos_[0],pos_[1],pos_[2] )  -- position
                             , v.radius
                             , 20 --divnum
                             , v.color
                             , DxLib.dx_GetColor( 0, 0, 0 )
                             , true) ;
        --============================================================
    end 
    --================================================================
    for i,v in ipairs(boxTable)
    do
        local pos_=ode.dBodyGetPosition(v.body);
        local r=ode.dBodyGetRotation(v.body);
        --============================================================
        
        --============================================================
        odeMatT[0][0] =  v.lX/2; odeMatT[0][1] =        0; odeMatT[0][2] =       0; odeMatT[0][3] = 0;
        odeMatT[0][4] =       0; odeMatT[0][5] =   v.lY/2; odeMatT[0][6] =       0; odeMatT[0][7] = 0;
        odeMatT[0][8] =       0; odeMatT[0][9] =        0; odeMatT[0][10]=  v.lZ/2; odeMatT[0][11]= 0;
        odeMatT[0][12]= pos_[0]; odeMatT[0][13]=  pos_[1]; odeMatT[0][14]= pos_[2]; odeMatT[0][15]= 1;
        --============================================================
        odeMatR[0][0] = r[0]; odeMatR[0][1] = r[1]; odeMatR[0][2] = r[2];  odeMatR[0][3] = r[3];
        odeMatR[0][4] = r[4]; odeMatR[0][5] = r[5]; odeMatR[0][6] = r[6];  odeMatR[0][7] = r[7];
        odeMatR[0][8] = r[8]; odeMatR[0][9] = r[9]; odeMatR[0][10]= r[10]; odeMatR[0][11]= r[11];
        odeMatR[0][12]= 0;    odeMatR[0][13]= 0;    odeMatR[0][14]= 0;     odeMatR[0][15]= 1;
        
        --============================================================
        ode.dMultiply1 (odeModelMat[0],  odeMatR[0], odeMatT[0], 4,4,4);
        local mat = _convertOdeMatToDxMat(odeModelMat[0])
        --============================================================
        DxLib.dx_MV1SetMatrix(box_Model,mat); 
        DxLib.dx_MV1DrawModel( box_Model ) ;  
    end 
--++
    --================================================================
    DxLib.dx_SetDrawBlendMode(blendMode , blendParam ) ;
end 
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
    
    local offset = fontSize+5 
    str =string.format("BallNum:%i/%i",#ballTable,maxBallNum);
    strWidth = DxLib.dx_GetDrawStringWidthToHandle(str,#str,fontHandle,false);
    drawStringToHandle( str,screenW-strWidth-10, offset*1+ 10,fontHandle);

    str =string.format("BoxNum:%i/%i",#boxTable,maxBoxNum);
    strWidth = DxLib.dx_GetDrawStringWidthToHandle(str,#str,fontHandle,false);
    drawStringToHandle( str,screenW-strWidth-10, offset*2+ 10,fontHandle);
    --================================================================
    str =string.format("contact Num :%i",contactNum);
    strWidth = DxLib.dx_GetDrawStringWidthToHandle(str,#str,fontHandle,false);
    drawStringToHandle( str,screenW-strWidth-10, offset*3 + 10,fontHandle);   
--++   
    --================================================================
    DxLib.dx_SetDrawBlendMode(blendMode , blendParam ) ;
end 
--====================================================================

--====================================================================
local function _randomObjAdd()
    if ( math.floor(math.random()*100) >90)
    then
        addBall();
        addForceBall();
        --============================================================
        local x = 2*math.random()-0.5/2
        local y = 2
        local z = 2+1*math.random()
        addBox(x,y,z)
    end 
end 
--====================================================================
local function _worldStep()
    --================================================================
    contactNum = 0;
    --================================================================
    local cb = ffi.cast("dNearCallback",nearCallback)
    ode.dSpaceCollide(space,nil,cb);
    cb:free();
    
    ode.dWorldQuickStep ( world ,0.006 );
    ode.dWorldSetQuickStepNumIterations ( world, 10 );
    ode.dJointGroupEmpty(contactgroup);
    --================================================================
end
--====================================================================

--====================================================================
function App.onDraw(dt)
    
    --================================================================
    drawBackGround(screenW,screenH,1)
    --================================================================
    
    DxLib.dx_SetDrawBlendMode( DxLib.DX_BLENDMODE_ALPHA , 255 ) ;
    --================================================================
    
    -- circle
    _drawAnimationSin();
    --================================================================
    
    -- step ode world and check contakt.
    _worldStep()
    --================================================================
    
    -- camera and light
    _updateCamera()
    --================================================================                                    

    -- draw object
    --================================================================
    _drawObject();
    DxLib.dx_ShadowMap_DrawEnd() ;
    --================================================================
    
    -- check ball ~ camera lengh
    _checkLengthFromCamera(ballTable);
    _checkLengthFromCamera(boxTable);
    --================================================================
    
    -- random add
    _randomObjAdd();
    --================================================================
    
    -- check max num
    _checkMaxNum(ballTable,maxBallNum)
    _checkMaxNum(boxTable,maxBoxNum)
    --================================================================
    
    -- draw info text
    _drawInfoText()
    --================================================================
    
    -- mouse point circle
    drawCicle(20,count,App.mouseX,App.mouseY,30)
    --================================================================
    
    --================================================================
    fpsLimit:limitFps(60)
end
--====================================================================
function App.onExit()
    ode.dWorldDestroy (world); -- is destroy with joint groupe?
    ode.dCloseODE();
    loadedFont:destroy();
end
--====================================================================

--====================================================================
App.run();
--====================================================================




