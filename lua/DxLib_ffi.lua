

--====================================================================
local ffi = require("ffi")
--====================================================================

-- define
--====================================================================
ffi.cdef 
[[
enum 
{
// DX_PI        = 3.1415926535897932384626433832795 
//,DX_PI_F      = 3.1415926535897932384626433832795
//,DX_TWO_PI    = 3.1415926535897932384626433832795 * 2.0
//,DX_TWO_PI_F  = 3.1415926535897932384626433832795 * 2.0
TRUE = 1
,FALSE = 0
,MAX_IMAGE_NUM = 32768
,MAX_2DSURFACE_NUM = 32768
,MAX_3DSURFACE_NUM = 65536
,MAX_IMAGE_DIVNUM = 64
,MAX_SURFACE_NUM = 65536
,MAX_SHADOWMAP_NUM = 8192
,MAX_SOFTIMAGE_NUM = 8192
,MAX_SOUND_NUM = 32768
,MAX_SOFTSOUND_NUM = 8192
,MAX_MUSIC_NUM = 256
,MAX_MOVIE_NUM = 100
,MAX_MASK_NUM = 512
,MAX_FONT_NUM = 40
,MAX_INPUT_NUM = 256
,MAX_SOCKET_NUM = 8192
,MAX_LIGHT_NUM = 4096
,MAX_SHADER_NUM = 4096
,MAX_MODEL_BASE_NUM = 32768
,MAX_MODEL_NUM = 32768
,MAX_VERTEX_BUFFER_NUM = 16384
,MAX_INDEX_BUFFER_NUM = 16384
,MAX_FILE_NUM = 32768
,MAX_JOYPAD_NUM = 16
,MAX_EVENTPROCESS_NUM = 5
,DEFAULT_SCREEN_SIZE_X = 640
,DEFAULT_SCREEN_SIZE_Y = 480
,DEFAULT_COLOR_BITDEPTH = 16
,DEFAULT_ZBUFFER_BITDEPTH = 16
,DX_DEFAULT_FONT_HANDLE = 2
,FONT_CACHE_MAXNUM = 2024
,FONT_CACHE_MEMORYSIZE = 327680
,FONT_CACHE_MAX_YLENGTH = 16384
,MAX_USERIMAGEREAD_FUNCNUM = 10
,DX_WINDOWSVERSION_31 = 0
,DX_WINDOWSVERSION_95 = 1
,DX_WINDOWSVERSION_98 = 2
,DX_WINDOWSVERSION_ME = 3
,DX_WINDOWSVERSION_NT31 = 260
,DX_WINDOWSVERSION_NT40 = 261
,DX_WINDOWSVERSION_2000 = 262
,DX_WINDOWSVERSION_XP = 263
,DX_WINDOWSVERSION_VISTA = 264
,DX_WINDOWSVERSION_7 = 265
,DX_WINDOWSVERSION_8 = 266
,DX_WINDOWSVERSION_8_1 = 267
,DX_WINDOWSVERSION_10 = 268
,DX_WINDOWSVERSION_NT_TYPE = 256
,DX_DIRECTXVERSION_NON = 0
,DX_DIRECTXVERSION_1 = 65536
,DX_DIRECTXVERSION_2 = 131072
,DX_DIRECTXVERSION_3 = 196608
,DX_DIRECTXVERSION_4 = 262144
,DX_DIRECTXVERSION_5 = 327680
,DX_DIRECTXVERSION_6 = 393216
,DX_DIRECTXVERSION_6_1 = 393472
,DX_DIRECTXVERSION_7 = 458752
,DX_DIRECTXVERSION_8 = 524288
,DX_DIRECTXVERSION_8_1 = 524544
,DX_CHARSET_DEFAULT = 0
,DX_CHARSET_SHFTJIS = 1
,DX_CHARSET_HANGEUL = 2
,DX_CHARSET_BIG5 = 3
,DX_CHARSET_GB2312 = 4
,DX_MIDIMODE_MCI = 0
,DX_MIDIMODE_DM = 1
,DX_DRAWMODE_NEAREST = 0
,DX_DRAWMODE_BILINEAR = 1
,DX_DRAWMODE_ANISOTROPIC = 2
,DX_DRAWMODE_OTHER = 3
,DX_DRAWMODE_NUM = 4
,DX_FONTTYPE_NORMAL = 0
,DX_FONTTYPE_EDGE = 1
,DX_FONTTYPE_ANTIALIASING = 2
,DX_FONTTYPE_ANTIALIASING_4X4 = 18
,DX_FONTTYPE_ANTIALIASING_8X8 = 34
,DX_FONTTYPE_ANTIALIASING_EDGE = 3
,DX_FONTTYPE_ANTIALIASING_EDGE_4X4 = 19
,DX_FONTTYPE_ANTIALIASING_EDGE_8X8 = 35
,DX_BLENDMODE_NOBLEND = 0
,DX_BLENDMODE_ALPHA = 1
,DX_BLENDMODE_ADD = 2
,DX_BLENDMODE_SUB = 3
,DX_BLENDMODE_MUL = 4
,DX_BLENDMODE_SUB2 = 5
,DX_BLENDMODE_XOR = 6
,DX_BLENDMODE_DESTCOLOR = 8
,DX_BLENDMODE_INVDESTCOLOR = 9
,DX_BLENDMODE_INVSRC = 10
,DX_BLENDMODE_MULA = 11
,DX_BLENDMODE_ALPHA_X4 = 12
,DX_BLENDMODE_ADD_X4 = 13
,DX_BLENDMODE_SRCCOLOR = 14
,DX_BLENDMODE_HALF_ADD = 15
,DX_BLENDMODE_SUB1 = 16
,DX_BLENDMODE_PMA_ALPHA = 17
,DX_BLENDMODE_PMA_ADD = 18
,DX_BLENDMODE_PMA_SUB = 19
,DX_BLENDMODE_PMA_INVSRC = 20
,DX_BLENDMODE_PMA_ALPHA_X4 = 21
,DX_BLENDMODE_PMA_ADD_X4 = 22
,DX_BLENDMODE_NUM = 23
,DX_BLENDGRAPHTYPE_NORMAL = 0
,DX_BLENDGRAPHTYPE_WIPE = 1
,DX_BLENDGRAPHTYPE_ALPHA = 2
,DX_GRAPH_FILTER_MONO = 0
,DX_GRAPH_FILTER_GAUSS = 1
,DX_GRAPH_FILTER_DOWN_SCALE = 2
,DX_GRAPH_FILTER_BRIGHT_CLIP = 3
,DX_GRAPH_FILTER_HSB = 4
,DX_GRAPH_FILTER_INVERT = 5
,DX_GRAPH_FILTER_LEVEL = 6
,DX_GRAPH_FILTER_TWO_COLOR = 7
,DX_GRAPH_FILTER_GRADIENT_MAP = 8
,DX_GRAPH_FILTER_PREMUL_ALPHA = 9
,DX_GRAPH_FILTER_INTERP_ALPHA = 10
,DX_GRAPH_FILTER_NUM = 11
,DX_GRAPH_BLEND_NORMAL = 0
,DX_GRAPH_BLEND_RGBA_SELECT_MIX = 1
,DX_GRAPH_BLEND_MULTIPLE = 2
,DX_GRAPH_BLEND_DIFFERENCE = 3
,DX_GRAPH_BLEND_ADD = 4
,DX_GRAPH_BLEND_SCREEN = 5
,DX_GRAPH_BLEND_OVERLAY = 6
,DX_GRAPH_BLEND_DODGE = 7
,DX_GRAPH_BLEND_BURN = 8
,DX_GRAPH_BLEND_DARKEN = 9
,DX_GRAPH_BLEND_LIGHTEN = 10
,DX_GRAPH_BLEND_SOFTLIGHT = 11
,DX_GRAPH_BLEND_HARDLIGHT = 12
,DX_GRAPH_BLEND_EXCLUSION = 13
,DX_GRAPH_BLEND_NORMAL_ALPHACH = 14
,DX_GRAPH_BLEND_ADD_ALPHACH = 15
,DX_GRAPH_BLEND_MULTIPLE_A_ONLY = 16
,DX_GRAPH_BLEND_PMA_MULTIPLE_A_ONLY = 17
,DX_GRAPH_BLEND_NUM = 18
,DX_RGBA_SELECT_SRC_R = 0
,DX_RGBA_SELECT_SRC_G = 1
,DX_RGBA_SELECT_SRC_B = 2
,DX_RGBA_SELECT_SRC_A = 3
,DX_RGBA_SELECT_BLEND_R = 4
,DX_RGBA_SELECT_BLEND_G = 5
,DX_RGBA_SELECT_BLEND_B = 6
,DX_RGBA_SELECT_BLEND_A = 7
,DX_CULLING_NONE = 0
,DX_CULLING_LEFT = 1
,DX_CULLING_RIGHT = 2
,DX_CULLING_NUM = 3
,DX_CAMERACLIP_LEFT = 1
,DX_CAMERACLIP_RIGHT = 2
,DX_CAMERACLIP_BOTTOM = 4
,DX_CAMERACLIP_TOP = 8
,DX_CAMERACLIP_BACK = 16
,DX_CAMERACLIP_FRONT = 32
,DX_MV1_VERTEX_TYPE_1FRAME = 0
,DX_MV1_VERTEX_TYPE_4FRAME = 1
,DX_MV1_VERTEX_TYPE_8FRAME = 2
,DX_MV1_VERTEX_TYPE_FREE_FRAME = 3
,DX_MV1_VERTEX_TYPE_NMAP_1FRAME = 4
,DX_MV1_VERTEX_TYPE_NMAP_4FRAME = 5
,DX_MV1_VERTEX_TYPE_NMAP_8FRAME = 6
,DX_MV1_VERTEX_TYPE_NMAP_FREE_FRAME = 7
,DX_MV1_VERTEX_TYPE_NUM = 8
,DX_MV1_MESHCATEGORY_NORMAL = 0
,DX_MV1_MESHCATEGORY_OUTLINE = 1
,DX_MV1_MESHCATEGORY_OUTLINE_ORIG_SHADER = 2
,DX_MV1_MESHCATEGORY_NUM = 3
,MV1_SAVETYPE_MESH = 1
,MV1_SAVETYPE_ANIM = 2
,MV1_SAVETYPE_NORMAL = MV1_SAVETYPE_MESH +MV1_SAVETYPE_ANIM  
,MV1_ANIMKEY_DATATYPE_ROTATE = 0
,MV1_ANIMKEY_DATATYPE_ROTATE_X = 1
,MV1_ANIMKEY_DATATYPE_ROTATE_Y = 2
,MV1_ANIMKEY_DATATYPE_ROTATE_Z = 3
,MV1_ANIMKEY_DATATYPE_SCALE = 5
,MV1_ANIMKEY_DATATYPE_SCALE_X = 6
,MV1_ANIMKEY_DATATYPE_SCALE_Y = 7
,MV1_ANIMKEY_DATATYPE_SCALE_Z = 8
,MV1_ANIMKEY_DATATYPE_TRANSLATE = 10
,MV1_ANIMKEY_DATATYPE_TRANSLATE_X = 11
,MV1_ANIMKEY_DATATYPE_TRANSLATE_Y = 12
,MV1_ANIMKEY_DATATYPE_TRANSLATE_Z = 13
,MV1_ANIMKEY_DATATYPE_MATRIX4X4C = 15
,MV1_ANIMKEY_DATATYPE_MATRIX3X3 = 17
,MV1_ANIMKEY_DATATYPE_SHAPE = 18
,MV1_ANIMKEY_DATATYPE_OTHRE = 20
,MV1_ANIMKEY_TIME_TYPE_ONE = 0
,MV1_ANIMKEY_TIME_TYPE_KEY = 1
,MV1_ANIMKEY_TYPE_QUATERNION_X = 0
,MV1_ANIMKEY_TYPE_VECTOR = 1
,MV1_ANIMKEY_TYPE_MATRIX4X4C = 2
,MV1_ANIMKEY_TYPE_MATRIX3X3 = 3
,MV1_ANIMKEY_TYPE_FLAT = 4
,MV1_ANIMKEY_TYPE_LINEAR = 5
,MV1_ANIMKEY_TYPE_BLEND = 6
,MV1_ANIMKEY_TYPE_QUATERNION_VMD = 7
,DX_SCREEN_FRONT = -4
,DX_SCREEN_BACK = -2
,DX_SCREEN_WORK = -3
,DX_SCREEN_TEMPFRONT = -5
,DX_NONE_GRAPH = -5
,DX_SHAVEDMODE_NONE = 0
,DX_SHAVEDMODE_DITHER = 1
,DX_SHAVEDMODE_DIFFUS = 2
,DX_IMAGESAVETYPE_BMP = 0
,DX_IMAGESAVETYPE_JPEG = 1
,DX_IMAGESAVETYPE_PNG = 2
,DX_PLAYTYPE_LOOPBIT = 2
,DX_PLAYTYPE_BACKBIT = 1
,DX_PLAYTYPE_NORMAL = 0
,DX_PLAYTYPE_BACK = ( DX_PLAYTYPE_BACKBIT  )
,DX_PLAYTYPE_LOOP = ( DX_PLAYTYPE_LOOPBIT +DX_PLAYTYPE_BACKBIT  )
,DX_MOVIEPLAYTYPE_BCANCEL = 0
,DX_MOVIEPLAYTYPE_NORMAL = 1
,DX_SOUNDTYPE_NORMAL = 0
,DX_SOUNDTYPE_STREAMSTYLE = 1
,DX_SOUNDDATATYPE_MEMNOPRESS = 0
,DX_SOUNDDATATYPE_MEMNOPRESS_PLUS = 1
,DX_SOUNDDATATYPE_MEMPRESS = 2
,DX_SOUNDDATATYPE_FILE = 3
,DX_READSOUNDFUNCTION_PCM = 1
,DX_READSOUNDFUNCTION_ACM = 2
,DX_READSOUNDFUNCTION_OGG = 4
,DX_READSOUNDFUNCTION_MP3 = 8
,DX_READSOUNDFUNCTION_DSMP3 = 16
,DX_REVERB_PRESET_DEFAULT = 0
,DX_REVERB_PRESET_GENERIC = 1
,DX_REVERB_PRESET_PADDEDCELL = 2
,DX_REVERB_PRESET_ROOM = 3
,DX_REVERB_PRESET_BATHROOM = 4
,DX_REVERB_PRESET_LIVINGROOM = 5
,DX_REVERB_PRESET_STONEROOM = 6
,DX_REVERB_PRESET_AUDITORIUM = 7
,DX_REVERB_PRESET_CONCERTHALL = 8
,DX_REVERB_PRESET_CAVE = 9
,DX_REVERB_PRESET_ARENA = 10
,DX_REVERB_PRESET_HANGAR = 11
,DX_REVERB_PRESET_CARPETEDHALLWAY = 12
,DX_REVERB_PRESET_HALLWAY = 13
,DX_REVERB_PRESET_STONECORRIDOR = 14
,DX_REVERB_PRESET_ALLEY = 15
,DX_REVERB_PRESET_FOREST = 16
,DX_REVERB_PRESET_CITY = 17
,DX_REVERB_PRESET_MOUNTAINS = 18
,DX_REVERB_PRESET_QUARRY = 19
,DX_REVERB_PRESET_PLAIN = 20
,DX_REVERB_PRESET_PARKINGLOT = 21
,DX_REVERB_PRESET_SEWERPIPE = 22
,DX_REVERB_PRESET_UNDERWATER = 23
,DX_REVERB_PRESET_SMALLROOM = 24
,DX_REVERB_PRESET_MEDIUMROOM = 25
,DX_REVERB_PRESET_LARGEROOM = 26
,DX_REVERB_PRESET_MEDIUMHALL = 27
,DX_REVERB_PRESET_LARGEHALL = 28
,DX_REVERB_PRESET_PLATE = 29
,DX_REVERB_PRESET_NUM = 30
,DX_MASKTRANS_WHITE = 0
,DX_MASKTRANS_BLACK = 1
,DX_MASKTRANS_NONE = 2
,DX_ZWRITE_MASK = 0
,DX_ZWRITE_CLEAR = 1
,DX_CMP_NEVER = 1
,DX_CMP_LESS = 2
,DX_CMP_EQUAL = 3
,DX_CMP_LESSEQUAL = 4
,DX_CMP_GREATER = 5
,DX_CMP_NOTEQUAL = 6
,DX_CMP_GREATEREQUAL = 7
,DX_CMP_ALWAYS = 8
,DX_ZCMP_DEFAULT = ( DX_CMP_LESSEQUAL  )
,DX_ZCMP_REVERSE = ( DX_CMP_GREATEREQUAL  )
,DX_SHADEMODE_FLAT = 1
,DX_SHADEMODE_GOURAUD = 2
,DX_FOGMODE_NONE = 0
,DX_FOGMODE_EXP = 1
,DX_FOGMODE_EXP2 = 2
,DX_FOGMODE_LINEAR = 3
,DX_MATERIAL_TYPE_NORMAL = 0
,DX_MATERIAL_TYPE_TOON = 1
,DX_MATERIAL_TYPE_TOON_2 = 2
,DX_MATERIAL_BLENDTYPE_TRANSLUCENT = 0
,DX_MATERIAL_BLENDTYPE_ADDITIVE = 1
,DX_MATERIAL_BLENDTYPE_MODULATE = 2
,DX_MATERIAL_BLENDTYPE_NONE = 3
,DX_TEXADDRESS_WRAP = 1
,DX_TEXADDRESS_MIRROR = 2
,DX_TEXADDRESS_CLAMP = 3
,DX_TEXADDRESS_BORDER = 4
,DX_TEXADDRESS_NUM = 5
,DX_VERTEX_TYPE_NORMAL_3D = 0
,DX_VERTEX_TYPE_SHADER_3D = 1
,DX_VERTEX_TYPE_NUM = 2
,DX_INDEX_TYPE_16BIT = 0
,DX_INDEX_TYPE_32BIT = 1
,DX_LOADMODEL_PHYSICS_DISABLE = 1
,DX_LOADMODEL_PHYSICS_LOADCALC = 0
,DX_LOADMODEL_PHYSICS_REALTIME = 2
,DX_SEMITRANSDRAWMODE_ALWAYS = 0
,DX_SEMITRANSDRAWMODE_SEMITRANS_ONLY = 1
,DX_SEMITRANSDRAWMODE_NOT_SEMITRANS_ONLY = 2
,DX_CUBEMAP_FACE_POSITIVE_X = 0
,DX_CUBEMAP_FACE_NEGATIVE_X = 1
,DX_CUBEMAP_FACE_POSITIVE_Y = 2
,DX_CUBEMAP_FACE_NEGATIVE_Y = 3
,DX_CUBEMAP_FACE_POSITIVE_Z = 4
,DX_CUBEMAP_FACE_NEGATIVE_Z = 5
,DX_PRIMTYPE_POINTLIST = 1
,DX_PRIMTYPE_LINELIST = 2
,DX_PRIMTYPE_LINESTRIP = 3
,DX_PRIMTYPE_TRIANGLELIST = 4
,DX_PRIMTYPE_TRIANGLESTRIP = 5
,DX_PRIMTYPE_TRIANGLEFAN = 6
,DX_LIGHTTYPE_D3DLIGHT_POINT = 1
,DX_LIGHTTYPE_D3DLIGHT_SPOT = 2
,DX_LIGHTTYPE_D3DLIGHT_DIRECTIONAL = 3
,DX_LIGHTTYPE_D3DLIGHT_FORCEDWORD = 2147483647
,DX_LIGHTTYPE_POINT = 1
,DX_LIGHTTYPE_SPOT = 2
,DX_LIGHTTYPE_DIRECTIONAL = 3
,DX_GRAPHICSIMAGE_FORMAT_3D_RGB16 = 0
,DX_GRAPHICSIMAGE_FORMAT_3D_RGB32 = 1
,DX_GRAPHICSIMAGE_FORMAT_3D_ALPHA_RGB16 = 2
,DX_GRAPHICSIMAGE_FORMAT_3D_ALPHA_RGB32 = 3
,DX_GRAPHICSIMAGE_FORMAT_3D_ALPHATEST_RGB16 = 4
,DX_GRAPHICSIMAGE_FORMAT_3D_ALPHATEST_RGB32 = 5
,DX_GRAPHICSIMAGE_FORMAT_3D_DXT1 = 6
,DX_GRAPHICSIMAGE_FORMAT_3D_DXT2 = 7
,DX_GRAPHICSIMAGE_FORMAT_3D_DXT3 = 8
,DX_GRAPHICSIMAGE_FORMAT_3D_DXT4 = 9
,DX_GRAPHICSIMAGE_FORMAT_3D_DXT5 = 10
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_RGB16 = 11
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_RGB32 = 12
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ALPHA_RGB32 = 13
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ABGR_I16 = 14
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ABGR_F16 = 15
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ABGR_F32 = 16
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ONE_I8 = 17
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ONE_I16 = 18
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ONE_F16 = 19
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_ONE_F32 = 20
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_TWO_I8 = 21
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_TWO_I16 = 22
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_TWO_F16 = 23
,DX_GRAPHICSIMAGE_FORMAT_3D_DRAWVALID_TWO_F32 = 24
,DX_GRAPHICSIMAGE_FORMAT_3D_NUM = 25
,DX_GRAPHICSIMAGE_FORMAT_2D = 26
,DX_GRAPHICSIMAGE_FORMAT_R5G6B5 = 27
,DX_GRAPHICSIMAGE_FORMAT_X8A8R5G6B5 = 28
,DX_GRAPHICSIMAGE_FORMAT_X8R8G8B8 = 29
,DX_GRAPHICSIMAGE_FORMAT_A8R8G8B8 = 30
,DX_GRAPHICSIMAGE_FORMAT_NUM = 31
,DX_BASEIMAGE_FORMAT_NORMAL = 0
,DX_BASEIMAGE_FORMAT_DXT1 = 1
,DX_BASEIMAGE_FORMAT_DXT2 = 2
,DX_BASEIMAGE_FORMAT_DXT3 = 3
,DX_BASEIMAGE_FORMAT_DXT4 = 4
,DX_BASEIMAGE_FORMAT_DXT5 = 5
,TOOLBUTTON_STATE_ENABLE = 0
,TOOLBUTTON_STATE_PRESSED = 1
,TOOLBUTTON_STATE_DISABLE = 2
,TOOLBUTTON_STATE_PRESSED_DISABLE = 3
,TOOLBUTTON_STATE_NUM = 4
,TOOLBUTTON_TYPE_NORMAL = 0
,TOOLBUTTON_TYPE_CHECK = 1
,TOOLBUTTON_TYPE_GROUP = 2
,TOOLBUTTON_TYPE_SEP = 3
,TOOLBUTTON_TYPE_NUM = 4
,MENUITEM_IDTOP = -1414812757
,MENUITEM_ADD_CHILD = 0
,MENUITEM_ADD_INSERT = 1
,MENUITEM_MARK_NONE = 0
,MENUITEM_MARK_CHECK = 1
,MENUITEM_MARK_RADIO = 2
,DX_NUMMODE_10 = 0
,DX_NUMMODE_16 = 1
,DX_STRMODE_NOT0 = 2
,DX_STRMODE_USE0 = 3
,DX_CHECKINPUT_KEY = 1
,DX_CHECKINPUT_PAD = 2
,DX_CHECKINPUT_MOUSE = 4
,DX_CHECKINPUT_ALL = DX_CHECKINPUT_KEY
                    +DX_CHECKINPUT_PAD
                    +DX_CHECKINPUT_MOUSE
,DX_INPUT_KEY_PAD1 = 4097
,DX_INPUT_PAD1 = 1
,DX_INPUT_PAD2 = 2
,DX_INPUT_PAD3 = 3
,DX_INPUT_PAD4 = 4
,DX_INPUT_PAD5 = 5
,DX_INPUT_PAD6 = 6
,DX_INPUT_PAD7 = 7
,DX_INPUT_PAD8 = 8
,DX_INPUT_PAD9 = 9
,DX_INPUT_PAD10 = 10
,DX_INPUT_PAD11 = 11
,DX_INPUT_PAD12 = 12
,DX_INPUT_PAD13 = 13
,DX_INPUT_PAD14 = 14
,DX_INPUT_PAD15 = 15
,DX_INPUT_PAD16 = 16
,DX_INPUT_KEY = 4096
,DX_MOVIESURFACE_NORMAL = 0
,DX_MOVIESURFACE_OVERLAY = 1
,DX_MOVIESURFACE_FULLCOLOR = 2
,PAD_INPUT_DOWN = 1
,PAD_INPUT_LEFT = 2
,PAD_INPUT_RIGHT = 4
,PAD_INPUT_UP = 8
,PAD_INPUT_A = 16
,PAD_INPUT_B = 32
,PAD_INPUT_C = 64
,PAD_INPUT_X = 128
,PAD_INPUT_Y = 256
,PAD_INPUT_Z = 512
,PAD_INPUT_L = 1024
,PAD_INPUT_R = 2048
,PAD_INPUT_START = 4096
,PAD_INPUT_M = 8192
,PAD_INPUT_D = 16384
,PAD_INPUT_F = 32768
,PAD_INPUT_G = 65536
,PAD_INPUT_H = 131072
,PAD_INPUT_I = 262144
,PAD_INPUT_J = 524288
,PAD_INPUT_K = 1048576
,PAD_INPUT_LL = 2097152
,PAD_INPUT_N = 4194304
,PAD_INPUT_O = 8388608
,PAD_INPUT_P = 16777216
,PAD_INPUT_RR = 33554432
,PAD_INPUT_S = 67108864
,PAD_INPUT_T = 134217728
,PAD_INPUT_U = 268435456
,PAD_INPUT_V = 536870912
,PAD_INPUT_W = 1073741824
,PAD_INPUT_XX = -2147483648
,PAD_INPUT_1 = 16
,PAD_INPUT_2 = 32
,PAD_INPUT_3 = 64
,PAD_INPUT_4 = 128
,PAD_INPUT_5 = 256
,PAD_INPUT_6 = 512
,PAD_INPUT_7 = 1024
,PAD_INPUT_8 = 2048
,PAD_INPUT_9 = 4096
,PAD_INPUT_10 = 8192
,PAD_INPUT_11 = 16384
,PAD_INPUT_12 = 32768
,PAD_INPUT_13 = 65536
,PAD_INPUT_14 = 131072
,PAD_INPUT_15 = 262144
,PAD_INPUT_16 = 524288
,PAD_INPUT_17 = 1048576
,PAD_INPUT_18 = 2097152
,PAD_INPUT_19 = 4194304
,PAD_INPUT_20 = 8388608
,PAD_INPUT_21 = 16777216
,PAD_INPUT_22 = 33554432
,PAD_INPUT_23 = 67108864
,PAD_INPUT_24 = 134217728
,PAD_INPUT_25 = 268435456
,PAD_INPUT_26 = 536870912
,PAD_INPUT_27 = 1073741824
,PAD_INPUT_28 = -2147483648
,XINPUT_BUTTON_DPAD_UP = 0
,XINPUT_BUTTON_DPAD_DOWN = 1
,XINPUT_BUTTON_DPAD_LEFT = 2
,XINPUT_BUTTON_DPAD_RIGHT = 3
,XINPUT_BUTTON_START = 4
,XINPUT_BUTTON_BACK = 5
,XINPUT_BUTTON_LEFT_THUMB = 6
,XINPUT_BUTTON_RIGHT_THUMB = 7
,XINPUT_BUTTON_LEFT_SHOULDER = 8
,XINPUT_BUTTON_RIGHT_SHOULDER = 9
,XINPUT_BUTTON_A = 12
,XINPUT_BUTTON_B = 13
,XINPUT_BUTTON_X = 14
,XINPUT_BUTTON_Y = 15
,MOUSE_INPUT_LEFT = 1
,MOUSE_INPUT_RIGHT = 2
,MOUSE_INPUT_MIDDLE = 4
,MOUSE_INPUT_1 = 1
,MOUSE_INPUT_2 = 2
,MOUSE_INPUT_3 = 4
,MOUSE_INPUT_4 = 8
,MOUSE_INPUT_5 = 16
,MOUSE_INPUT_6 = 32
,MOUSE_INPUT_7 = 64
,MOUSE_INPUT_8 = 128
,KEY_INPUT_BACK = 14
,KEY_INPUT_TAB = 15
,KEY_INPUT_RETURN = 28
,KEY_INPUT_LSHIFT = 42
,KEY_INPUT_RSHIFT = 54
,KEY_INPUT_LCONTROL = 29
,KEY_INPUT_RCONTROL = 157
,KEY_INPUT_ESCAPE = 1
,KEY_INPUT_SPACE = 57
,KEY_INPUT_PGUP = 201
,KEY_INPUT_PGDN = 209
,KEY_INPUT_END = 207
,KEY_INPUT_HOME = 199
,KEY_INPUT_LEFT = 203
,KEY_INPUT_UP = 200
,KEY_INPUT_RIGHT = 205
,KEY_INPUT_DOWN = 208
,KEY_INPUT_INSERT = 210
,KEY_INPUT_DELETE = 211
,KEY_INPUT_MINUS = 12
,KEY_INPUT_YEN = 125
,KEY_INPUT_PREVTRACK = 144
,KEY_INPUT_PERIOD = 52
,KEY_INPUT_SLASH = 53
,KEY_INPUT_LALT = 56
,KEY_INPUT_RALT = 184
,KEY_INPUT_SCROLL = 70
,KEY_INPUT_SEMICOLON = 39
,KEY_INPUT_COLON = 146
,KEY_INPUT_LBRACKET = 26
,KEY_INPUT_RBRACKET = 27
,KEY_INPUT_AT = 145
,KEY_INPUT_BACKSLASH = 43
,KEY_INPUT_COMMA = 51
,KEY_INPUT_KANJI = 148
,KEY_INPUT_CONVERT = 121
,KEY_INPUT_NOCONVERT = 123
,KEY_INPUT_KANA = 112
,KEY_INPUT_APPS = 221
,KEY_INPUT_CAPSLOCK = 58
,KEY_INPUT_SYSRQ = 183
,KEY_INPUT_PAUSE = 197
,KEY_INPUT_LWIN = 219
,KEY_INPUT_RWIN = 220
,KEY_INPUT_NUMLOCK = 69
,KEY_INPUT_NUMPAD0 = 82
,KEY_INPUT_NUMPAD1 = 79
,KEY_INPUT_NUMPAD2 = 80
,KEY_INPUT_NUMPAD3 = 81
,KEY_INPUT_NUMPAD4 = 75
,KEY_INPUT_NUMPAD5 = 76
,KEY_INPUT_NUMPAD6 = 77
,KEY_INPUT_NUMPAD7 = 71
,KEY_INPUT_NUMPAD8 = 72
,KEY_INPUT_NUMPAD9 = 73
,KEY_INPUT_MULTIPLY = 55
,KEY_INPUT_ADD = 78
,KEY_INPUT_SUBTRACT = 74
,KEY_INPUT_DECIMAL = 83
,KEY_INPUT_DIVIDE = 181
,KEY_INPUT_NUMPADENTER = 156
,KEY_INPUT_F1 = 59
,KEY_INPUT_F2 = 60
,KEY_INPUT_F3 = 61
,KEY_INPUT_F4 = 62
,KEY_INPUT_F5 = 63
,KEY_INPUT_F6 = 64
,KEY_INPUT_F7 = 65
,KEY_INPUT_F8 = 66
,KEY_INPUT_F9 = 67
,KEY_INPUT_F10 = 68
,KEY_INPUT_F11 = 87
,KEY_INPUT_F12 = 88
,KEY_INPUT_A = 30
,KEY_INPUT_B = 48
,KEY_INPUT_C = 46
,KEY_INPUT_D = 32
,KEY_INPUT_E = 18
,KEY_INPUT_F = 33
,KEY_INPUT_G = 34
,KEY_INPUT_H = 35
,KEY_INPUT_I = 23
,KEY_INPUT_J = 36
,KEY_INPUT_K = 37
,KEY_INPUT_L = 38
,KEY_INPUT_M = 50
,KEY_INPUT_N = 49
,KEY_INPUT_O = 24
,KEY_INPUT_P = 25
,KEY_INPUT_Q = 16
,KEY_INPUT_R = 19
,KEY_INPUT_S = 31
,KEY_INPUT_T = 20
,KEY_INPUT_U = 22
,KEY_INPUT_V = 47
,KEY_INPUT_W = 17
,KEY_INPUT_X = 45
,KEY_INPUT_Y = 21
,KEY_INPUT_Z = 44
,KEY_INPUT_0 = 11
,KEY_INPUT_1 = 2
,KEY_INPUT_2 = 3
,KEY_INPUT_3 = 4
,KEY_INPUT_4 = 5
,KEY_INPUT_5 = 6
,KEY_INPUT_6 = 7
,KEY_INPUT_7 = 8
,KEY_INPUT_8 = 9
,KEY_INPUT_9 = 10
,CTRL_CODE_BS = 8
,CTRL_CODE_TAB = 9
,CTRL_CODE_CR = 13
,CTRL_CODE_DEL = 16
,CTRL_CODE_COPY = 3
,CTRL_CODE_PASTE = 22
,CTRL_CODE_CUT = 24
,CTRL_CODE_ALL = 1
,CTRL_CODE_LEFT = 29
,CTRL_CODE_RIGHT = 28
,CTRL_CODE_UP = 30
,CTRL_CODE_DOWN = 31
,CTRL_CODE_HOME = 26
,CTRL_CODE_END = 25
,CTRL_CODE_PAGE_UP = 23
,CTRL_CODE_PAGE_DOWN = 21
,CTRL_CODE_ESC = 27
,CTRL_CODE_CMP = 32
,DX_KEYINPSTRCOLOR_NORMAL_STR = 0
,DX_KEYINPSTRCOLOR_NORMAL_STR_EDGE = 1
,DX_KEYINPSTRCOLOR_NORMAL_CURSOR = 2
,DX_KEYINPSTRCOLOR_SELECT_STR = 3
,DX_KEYINPSTRCOLOR_SELECT_STR_EDGE = 4
,DX_KEYINPSTRCOLOR_SELECT_STR_BACK = 5
,DX_KEYINPSTRCOLOR_IME_STR = 6
,DX_KEYINPSTRCOLOR_IME_STR_EDGE = 7
,DX_KEYINPSTRCOLOR_IME_STR_BACK = 8
,DX_KEYINPSTRCOLOR_IME_CURSOR = 9
,DX_KEYINPSTRCOLOR_IME_LINE = 10
,DX_KEYINPSTRCOLOR_IME_SELECT_STR = 11
,DX_KEYINPSTRCOLOR_IME_SELECT_STR_EDGE = 12
,DX_KEYINPSTRCOLOR_IME_SELECT_STR_BACK = 13
,DX_KEYINPSTRCOLOR_IME_CONV_WIN_STR = 14
,DX_KEYINPSTRCOLOR_IME_CONV_WIN_STR_EDGE = 15
,DX_KEYINPSTRCOLOR_IME_CONV_WIN_SELECT_STR = 16
,DX_KEYINPSTRCOLOR_IME_CONV_WIN_SELECT_STR_EDGE = 17
,DX_KEYINPSTRCOLOR_IME_CONV_WIN_SELECT_STR_BACK = 18
,DX_KEYINPSTRCOLOR_IME_CONV_WIN_EDGE = 19
,DX_KEYINPSTRCOLOR_IME_CONV_WIN_BACK = 20
,DX_KEYINPSTRCOLOR_IME_MODE_STR = 21
,DX_KEYINPSTRCOLOR_IME_MODE_STR_EDGE = 22
,DX_KEYINPSTRCOLOR_NUM = 23
,DX_KEYINPSTR_ENDCHARAMODE_OVERWRITE = 0
,DX_KEYINPSTR_ENDCHARAMODE_NOTCHANGE = 1
,DX_FSRESOLUTIONMODE_NATIVE = 0
,DX_FSRESOLUTIONMODE_DESKTOP = 1
,DX_FSRESOLUTIONMODE_MAXIMUM = 2
,DX_FSSCALINGMODE_BILINEAR = 0
,DX_FSSCALINGMODE_NEAREST = 1
,DX_CHANGESCREEN_OK = 0
,DX_CHANGESCREEN_RETURN = 1
,DX_CHANGESCREEN_DEFAULT = 2
,DX_CHANGESCREEN_REFRESHNORMAL = 3
,LOADIMAGE_TYPE_FILE = 0
,LOADIMAGE_TYPE_MEM = 1
,LOADIMAGE_TYPE_NONE = 1
,HTTP_ERR_SERVER = 0
,HTTP_ERR_NOTFOUND = 1
,HTTP_ERR_MEMORY = 2
,HTTP_ERR_LOST = 3
,HTTP_ERR_NONE = 1
,HTTP_RES_COMPLETE = 0
,HTTP_RES_STOP = 1
,HTTP_RES_ERROR = 2
,HTTP_RES_NOW = 1
};
//--==================================================================
typedef char  TCHAR;
typedef long  LONG;
typedef __int64 LONGLONG;
typedef unsigned __int64 ULONGLONG;
typedef unsigned char       BYTE;
typedef unsigned long       DWORD;
typedef  DWORD  DWORD_PTR;
typedef int                 INT;
typedef unsigned int        UINT;
typedef unsigned int        *PUINT;
typedef unsigned long       DWORD;
typedef int                 BOOL;
typedef unsigned char       BYTE;
typedef unsigned short      WORD;
//--==================================================================
typedef struct tagRECT
{
    LONG    left;
    LONG    top;
    LONG    right;
    LONG    bottom;
} RECT;
//--==================================================================
typedef struct {int unused;}HWND; 
typedef struct {int unused;}HINSTANCE; 
typedef struct {int unused;}HICON;
typedef HINSTANCE HMODULE; 
typedef struct {int unused;}HRGN; 
typedef struct {int unused;}HBITMAP; 
typedef struct {int unused;}HBRUSH; 
//--==================================================================
typedef struct tagBITMAPINFOHEADER{
        DWORD      biSize;
        LONG       biWidth;
        LONG       biHeight;
        WORD       biPlanes;
        WORD       biBitCount;
        DWORD      biCompression;
        DWORD      biSizeImage;
        LONG       biXPelsPerMeter;
        LONG       biYPelsPerMeter;
        DWORD      biClrUsed;
        DWORD      biClrImportant;
} BITMAPINFOHEADER;
//--==================================================================
typedef struct tagRGBQUAD {
        BYTE    rgbBlue;
        BYTE    rgbGreen;
        BYTE    rgbRed;
        BYTE    rgbReserved;
} RGBQUAD;
//--==================================================================
typedef struct tagBITMAPINFO {
    BITMAPINFOHEADER    bmiHeader;
    RGBQUAD             bmiColors[1];
} BITMAPINFO;
//--==================================================================
typedef struct tWAVEFORMATEX
{
    WORD        wFormatTag;         /* format type */
    WORD        nChannels;          /* number of channels (i.e. mono, stereo...) */
    DWORD       nSamplesPerSec;     /* sample rate */
    DWORD       nAvgBytesPerSec;    /* for buffer estimation */
    WORD        nBlockAlign;        /* block size of data */
    WORD        wBitsPerSample;     /* number of bits per sample of mono data */
    WORD        cbSize;             /* the count in bytes of the size of */
                                    /* extra information (after cbSize) */
} WAVEFORMATEX;
//--==================================================================
typedef struct _GUID {
    unsigned long  Data1;
    unsigned short Data2;
    unsigned short Data3;
    unsigned char  Data4[ 8 ];
} GUID;
//--==================================================================
]]
--====================================================================
-- 64bit or 32bit  ????
if ffi.abi '64bit' 
then
    ffi.cdef[[
        typedef __int64 LONG_PTR;
        typedef unsigned __int64 ULONG_PTR;
    ]]
else
    ffi.cdef[[
        typedef  long LONG_PTR;
        typedef  unsigned int UINT_PTR;
    ]]  
end
--====================================================================
ffi.cdef
[[
typedef UINT_PTR            WPARAM;
typedef LONG_PTR            LPARAM;
typedef LONG_PTR            LRESULT;
typedef LRESULT (__stdcall* WNDPROC)(HWND, UINT, WPARAM, LPARAM);
]]
--====================================================================
--DXLib Struct Type
--====================================================================
ffi.cdef
[[

typedef char DX_CHAR  ;

// ＩＭＥ入力文字列の描画に必要な情報の内の文節情報
typedef struct tagIMEINPUTCLAUSEDATA
{
    int                        Position ;                     // 何バイト目から
    int                        Length ;                       // 何バイトか
} IMEINPUTCLAUSEDATA, *LPIMEINPUTCLAUSEDATA ;

                                                              // ＩＭＥ入力文字列の描画に必要な情報
typedef struct tagIMEINPUTDATA
{
    const TCHAR *                 InputString;                // 入力中の文字列

    int                           CursorPosition;             // カーソルの入力文字列中の位置(バイト単位)

    const IMEINPUTCLAUSEDATA *    ClauseData;                 // 文節情報
    int                           ClauseNum;                  // 文節情報の数
    int                           SelectClause;               // 選択中の分節( -1 の場合はどの文節にも属していない( 末尾にカーソルがある ) )

    int                           CandidateNum;               // 変換候補の数( 0の場合は変換中ではない )
    const TCHAR **                CandidateList;              // 変換候補文字列リスト( 例：ｎ番目の候補を描画する場合  DrawString( 0, 0, data.CandidateList[ n ], GetColor(255,255,255) ); )
    int                           SelectCandidate ;           // 選択中の変換候補

    int                           ConvertFlag ;               // 文字変換中かどうか( TRUE:変換中  FALSE:変換中ではない( 文字単位でカーソルが移動できる状態 ) )
} IMEINPUTDATA, *LPIMEINPUTDATA ;

// 画面モード情報データ型
typedef struct tagDISPLAYMODEDATA
{
    int                        Width ;                // 水平解像度
    int                        Height ;               // 垂直解像度
    int                        ColorBitDepth ;        // 色ビット深度
    int                        RefreshRate ;          // リフレッシュレート( -1 の場合は規定値 )
} DISPLAYMODEDATA, *LPDISPLAYMODEDATA ;

// タイムデータ型
typedef struct tagDATEDATA
{
    int                        Year ;               // 年
    int                        Mon ;                // 月
    int                        Day ;                // 日
    int                        Hour ;               // 時間
    int                        Min ;                // 分
    int                        Sec ;                // 秒
} DATEDATA, *LPDATEDATA ;

// ファイル情報構造体
typedef struct tagFILEINFO
{
    TCHAR                   Name[260] ;             // オブジェクト名
    int                     DirFlag ;               // ディレクトリかどうか( TRUE:ディレクトリ  FALSE:ファイル )
    LONGLONG                Size ;                  // サイズ
    DATEDATA                CreationTime ;          // 作成日時
    DATEDATA                LastWriteTime ;         // 最終更新日時
} FILEINFO, *LPFILEINFO ;



// 行列構造体
typedef struct tagMATRIX
{
    float                    m[4][4] ;
} MATRIX, *LPMATRIX ;

// ベクトルデータ型
typedef struct tagVECTOR
{
    float                    x, y, z ;
} VECTOR, *LPVECTOR, XYZ, *LPXYZ ;

// FLOAT2個データ型
typedef struct tagFLOAT2
{
    float                    u, v ;
} UV ;

// float 型のカラー値
typedef struct tagCOLOR_F
{
    float                    r, g, b, a ;
} COLOR_F, *LPCOLOR_F ;

// unsigned char 型のカラー値
typedef struct tagCOLOR_U8
{
    BYTE                    b, g, r, a ;
} COLOR_U8 ;

// FLOAT4個データ型
typedef struct tagFLOAT4
{
    float                    x, y, z, w ;
} FLOAT4, *LPFLOAT4 ;

// INT4個データ型
typedef struct tagINT4
{
    int                        x, y, z, w ;
} INT4 ;

// ２Ｄ描画に使用する頂点データ型(DrawPrimitive2D用)
typedef struct tagVERTEX2D
{
    VECTOR                  pos ;
    float                   rhw ;
    COLOR_U8                dif ;
    float                   u, v ;
} VERTEX2D, *LPVERTEX2D ; 

// ２Ｄ描画に使用する頂点データ型(DrawPrimitive2DToShader用)
typedef struct tagVERTEX2DSHADER
{
    VECTOR                  pos ;
    float                   rhw ;
    COLOR_U8                dif ;
    COLOR_U8                spc ;
    float                   u, v ;
    float                   su, sv ;
} VERTEX2DSHADER, *LPVERTEX2DSHADER ; 

// ２Ｄ描画に使用する頂点データ型(公開用)
typedef struct tagVERTEX
{
    float                    x, y ;
    float                    u, v ;
    unsigned char            b, g, r, a ;
} VERTEX ;

// ３Ｄ描画に使用する頂点データ型( 旧バージョンのもの )
typedef struct tagVERTEX_3D
{
    VECTOR                   pos ;
    unsigned char            b, g, r, a ;
    float                    u, v ;
} VERTEX_3D, *LPVERTEX_3D ;

// ３Ｄ描画に使用する頂点データ型
typedef struct tagVERTEX3D
{
    VECTOR                  pos ;                           // 座標
    VECTOR                  norm ;                          // 法線
    COLOR_U8                dif ;                           // ディフューズカラー
    COLOR_U8                spc ;                           // スペキュラカラー
    float                   u, v ;                          // テクスチャ座標
    float                   su, sv ;                        // 補助テクスチャ座標
} VERTEX3D, *LPVERTEX3D ;

// ３Ｄ描画に使用する頂点データ型( DrawPrimitive3DToShader用 )
// 注意…メンバ変数に追加があるかもしれませんので、宣言時の初期化( VERTEX3DSHADER Vertex = { 0.0f, 0.0f, ... というようなもの )はしない方が良いです
typedef struct tagVERTEX3DSHADER
{
    VECTOR                  pos ;                           // 座標
    FLOAT4                  spos ;                          // 補助座標
    VECTOR                  norm ;                          // 法線
    VECTOR                  tan ;                           // 接線
    VECTOR                  binorm ;                        // 従法線
    COLOR_U8                dif ;                           // ディフューズカラー
    COLOR_U8                spc ;                           // スペキュラカラー
    float                   u, v ;                          // テクスチャ座標
    float                   su, sv ;                        // 補助テクスチャ座標
} VERTEX3DSHADER, *LPVERTEX3DSHADER ;

// ライトパラメータ
typedef struct tagLIGHTPARAM
{
    int                      LightType ;                      // ライトのタイプ( DX_LIGHTTYPE_D3DLIGHT_POINT 等 )
    COLOR_F                  Diffuse ;                        // ディフューズカラー
    COLOR_F                  Specular ;                       // スペキュラカラー
    COLOR_F                  Ambient ;                        // アンビエント色
    VECTOR                   Position ;                       // 位置
    VECTOR                   Direction ;                      // 方向
    float                    Range ;                          // 有効距離
    float                    Falloff ;                        // フォールオフ 1.0f にしておくのが好ましい
    float                    Attenuation0 ;                   // 距離による減衰係数０
    float                    Attenuation1 ;                   // 距離による減衰係数１
    float                    Attenuation2 ;                   // 距離による減衰係数２
    float                    Theta ;                          // スポットライトの内部コーンの照明角度( ラジアン )
    float                    Phi ;                            // スポットライトの外部コーンの照明角度
} LIGHTPARAM ;

// マテリアルパラメータ
typedef struct tagMATERIALPARAM
{
    COLOR_F                  Diffuse ;                     // ディフューズカラー
    COLOR_F                  Ambient ;                     // アンビエントカラー
    COLOR_F                  Specular ;                    // スペキュラカラー
    COLOR_F                  Emissive ;                    // エミッシブカラー
    float                    Power ;                       // スペキュラハイライトの鮮明度
} MATERIALPARAM ;

// ラインヒットチェック結果格納用構造体
typedef struct tagHITRESULT_LINE
{
    int                      HitFlag ;                     // 当たったかどうか( 1:当たった  0:当たらなかった )
    VECTOR                   Position ;                    // 当たった座標
} HITRESULT_LINE ;

// 関数 Segment_Segment_Analyse の結果を受け取る為の構造体
typedef struct tagSEGMENT_SEGMENT_RESULT
{
    float                    SegA_SegB_MinDist_Square ;     // 線分Ａと線分Ｂが最も接近する座標間の距離の二乗

    float                    SegA_MinDist_Pos1_Pos2_t ;     // 線分Ａと線分Ｂに最も接近する座標の線分Ａの t ( 0.0f ～ 1.0f 、最近点座標 = ( SegAPos2 - SegAPos1 ) * t + SegAPos1 )
    float                    SegB_MinDist_Pos1_Pos2_t ;     // 線分Ｂが線分Ａに最も接近する座標の線分Ｂの t ( 0.0f ～ 1.0f 、最近点座標 = ( SegBPos2 - SegBPos1 ) * t + SegBPos1 )

    VECTOR                    SegA_MinDist_Pos ;            // 線分Ａが線分Ｂに最も接近する線分Ａ上の座標
    VECTOR                    SegB_MinDist_Pos ;            // 線分Ｂが線分Ａに最も接近する線分Ｂ上の座標
} SEGMENT_SEGMENT_RESULT ;

// 関数 Segment_Point_Analyse の結果を受け取る為の構造体
typedef struct tagSEGMENT_POINT_RESULT
{
    float                    Seg_Point_MinDist_Square ;    // 線分と点が最も接近する座標間の距離の二乗
    float                    Seg_MinDist_Pos1_Pos2_t ;     // 線分が点に最も接近する座標の線分の t ( 0.0f ～ 1.0f 、最近点座標 = ( SegPos2 - SegPos1 ) * t + SegPos1 )
    VECTOR                    Seg_MinDist_Pos ;            // 線分が点に最も接近する線分上の座標
} SEGMENT_POINT_RESULT ;

// 関数 Segment_Triangle_Analyse の結果を受け取る為の構造体
typedef struct tagSEGMENT_TRIANGLE_RESULT
{
    float                    Seg_Tri_MinDist_Square ;      // 線分と三角形が最も接近する座標間の距離の二乗

    float                    Seg_MinDist_Pos1_Pos2_t ;     // 線分が三角形に最も接近する座標の線分の t ( 0.0f ～ 1.0f 、最近点座標 = ( SegPos2 - SegPos1 ) * t + SegPos1 )
    VECTOR                    Seg_MinDist_Pos ;            // 線分が三角形に最も接近する線分上の座標

    float                    Tri_MinDist_Pos1_w ;          // 三角形が線分に最も接近する座標の三角形座標１の重み( 最近点座標 = TriPos1 * TriPos1_w + TriPos2 * TriPos2_w + TriPos3 * TriPos3_w )
    float                    Tri_MinDist_Pos2_w ;          // 三角形が線分に最も接近する座標の三角形座標２の重み
    float                    Tri_MinDist_Pos3_w ;          // 三角形が線分に最も接近する座標の三角形座標３の重み
    VECTOR                    Tri_MinDist_Pos ;            // 三角形が線分に最も接近する三角形上の座標
} SEGMENT_TRIANGLE_RESULT ;

// 関数 Triangle_Point_Analyse の結果を受け取る為の構造体
typedef struct tagTRIANGLE_POINT_RESULT
{
    float                    Tri_Pnt_MinDist_Square ;      // 三角形と点が最も接近する座標間の距離の二乗

    float                    Tri_MinDist_Pos1_w ;          // 三角形が点に最も接近する座標の三角形座標１の重み( 最近点座標 = TriPos1 * TriPos1_w + TriPos2 * TriPos2_w + TriPos3 * TriPos3_w )
    float                    Tri_MinDist_Pos2_w ;          // 三角形が点に最も接近する座標の三角形座標２の重み
    float                    Tri_MinDist_Pos3_w ;          // 三角形が点に最も接近する座標の三角形座標３の重み
    VECTOR                    Tri_MinDist_Pos ;            // 三角形が点に最も接近する三角形上の座標
} TRIANGLE_POINT_RESULT ;

// 関数 Plane_Point_Analyse の結果を受け取る為の構造体
typedef struct tagPLANE_POINT_RESULT
{
    int                        Pnt_Plane_Normal_Side ;      // 点が平面の法線の側にあるかどうか( 1:法線の側にある  0:法線と反対側にある )
    float                    Plane_Pnt_MinDist_Square ;     // 平面と点の距離
    VECTOR                    Plane_MinDist_Pos ;           // 平面上の点との最近点座標
} PLANE_POINT_RESULT ;

// コリジョン結果代入用ポリゴン
typedef struct tagMV1_COLL_RESULT_POLY
{
    int                        HitFlag ;                    // ( MV1CollCheck_Line でのみ有効 )ヒットフラグ( 1:ヒットした  0:ヒットしなかった )
    VECTOR                    HitPosition ;                 // ( MV1CollCheck_Line でのみ有効 )ヒット座標
                                                         
    int                        FrameIndex ;                 // 当たったポリゴンが含まれるフレームの番号
    int                        PolygonIndex ;               // 当たったポリゴンの番号
    int                        MaterialIndex ;              // 当たったポリゴンが使用しているマテリアルの番号
    VECTOR                    Position[ 3 ] ;               // 当たったポリゴンを形成する三点の座標
    VECTOR                    Normal ;                      // 当たったポリゴンの法線
} MV1_COLL_RESULT_POLY ;

// コリジョン結果代入用ポリゴン配列
typedef struct tagMV1_COLL_RESULT_POLY_DIM
{
    int                        HitNum ;                     // ヒットしたポリゴンの数
    MV1_COLL_RESULT_POLY *    Dim ;                         // ヒットしたポリゴンの配列( HitNum個分存在する )
} MV1_COLL_RESULT_POLY_DIM ;

// 参照用頂点構造体
typedef struct tagMV1_REF_VERTEX
{
    VECTOR                    Position ;                             // 位置
    VECTOR                    Normal ;                               // 法線
    UV                        TexCoord[ 2 ] ;                        // テクスチャ座標
    COLOR_U8                DiffuseColor ;                           // ディフューズカラー
    COLOR_U8                SpecularColor ;                          // スペキュラカラー
} MV1_REF_VERTEX ;

// 参照用ポリゴン構造体
typedef struct tagMV1_REF_POLYGON
{
    unsigned short            FrameIndex ;                           // このポリゴンが属しているフレーム
    unsigned short            MaterialIndex ;                        // 使用しているマテリアル
    int                        VIndexTarget ;                        // VIndex が指すインデックスの参照先( 1:フレーム  0:モデル全体 )
    int                        VIndex[ 3 ] ;                         // ３角形ポリゴンを成す参照頂点のインデックス
    VECTOR                    MinPosition ;                          // ポリゴンを成す頂点座標の最小値
    VECTOR                    MaxPosition ;                          // ポリゴンを成す頂点座標の最大値
} MV1_REF_POLYGON ;

// 参照用ポリゴンデータ構造体
typedef struct tagMV1_REF_POLYGONLIST
{
    int                        PolygonNum ;                           // 参照用ポリゴンの数
    int                        VertexNum ;                            // 頂点の数
    VECTOR                    MinPosition ;                           // 頂点座標の最小値
    VECTOR                    MaxPosition ;                           // 頂点座標の最大値
    MV1_REF_POLYGON    *        Polygons ;                            // 参照用ポリゴン配列
    MV1_REF_VERTEX *        Vertexs ;                                 // 参照用頂点配列
} MV1_REF_POLYGONLIST ;

// ３Ｄサウンドリバーブエフェクトパラメータ構造体
// ( 注釈は MSDN の XAUDIO2FX_REVERB_PARAMETERS 構造体の解説をほぼ引用しています )
typedef struct tagSOUND3D_REVERB_PARAM
{
    float                    WetDryMix ;                            // リバーブとなる出力の割合( 指定可能範囲 0.0f ～ 100.0f )

    unsigned int            ReflectionsDelay ;                      // ダイレクト パスに対する初期反射の遅延時間、単位はミリ秒( 指定可能範囲 0 ～ 300 )
    BYTE                    ReverbDelay ;                           // 初期反射に対するリバーブの遅延時間、単位はミリ秒( 指定可能範囲 0 ～ 85 )
    BYTE                    RearDelay ;                             // 左後方出力および右後方出力の遅延時間、単位はミリ秒( 指定可能範囲 0 ～ 5 )

    BYTE                    PositionLeft ;                          // シミュレーション空間における視聴者に対する左入力の位置( 指定可能範囲 0 ～ 30 )
                                                                    // PositionLeft を最小値に設定した場合、左入力は視聴者の近くに配置されます。
                                                                    // この位置では、サウンド フィールドにおいて初期反射が優勢になり、残響減衰は弱まって、振幅が小さくなります。
                                                                    // PositionLeft を最大値に設定した場合、左入力はシミュレーション室内で視聴者から最大限遠い位置に配置されます。
                                                                    // PositionLeft は残響減衰時間 (部屋の残響効果) に影響せず、視聴者に対する音源の見かけの位置のみに影響します。
    BYTE                    PositionRight ;                         // PositionLeft と同効果の右入力値( 指定可能範囲 0 ～ 30 )、右入力にのみ影響を与える
    BYTE                    PositionMatrixLeft ;                    // 音源から視聴者までの距離によるインプレッションを増減させる値( 指定可能範囲 0 ～ 30 )
    BYTE                    PositionMatrixRight ;                   // 音源から視聴者までの距離によるインプレッションを増減させま値( 指定可能範囲 0 ～ 30 )
    BYTE                    EarlyDiffusion ;                        // 個々の壁の反射特性値( 指定可能範囲 0 ～ 15 )、( 堅く平らな表面をシミュレートするには小さな値を設定し、散乱性の表面をシミュレートするには大きな値を設定します。)
    BYTE                    LateDiffusion ;                         // 個々の壁のリバーブ特性値( 指定可能範囲 0 ～ 15 )、( 堅く平らな表面をシミュレートするには小さな値を設定し、散乱性の表面をシミュレートするには大きな値を設定します。)
    BYTE                    LowEQGain ;                             // 1 kHz における減衰時間を基準にして低周波数の減衰時間調整値( 指定可能範囲 0 ～ 12 )
                                                                    // 値とゲイン (dB) の関係
                                                                    // 値          0  1  2  3  4  5  6  7  8  9 10 11 12
                                                                    // ゲイン(dB) -8 -7 -6 -5 -4 -3 -2 -1  0 +1 +2 +3 +4
                                                                    // LowEQGain の値が 8 の場合、低周波数の減衰時間と 1 kHz における減衰時間が等しくなることに注意してください
    BYTE                    LowEQCutoff ;                           // LowEQGain パラメーターにより制御されるローパス フィルターの折点周波数の設定値( 指定可能範囲 0 ～ 9 )
                                                                    // 値と周波数 (Hz) の関係
                                                                    // 値          0   1   2   3   4   5   6   7   8   9
                                                                    // 周波数(Hz) 50 100 150 200 250 300 350 400 450 500
    BYTE                    HighEQGain ;                            // 1 kHz における減衰時間を基準にして高周波数の減衰時間調整値( 指定可能範囲 0 ～ 8 )
                                                                    // 値とゲイン (dB) の関係
                                                                    // 値          0  1  2  3  4  5  6  7 8
                                                                    // ゲイン(dB) -8 -7 -6 -5 -4 -3 -2 -1 0
                                                                    // 0 に設定すると、高周波数の音が 1 kHz の場合と同じ割合で減衰します。最大値に設定すると、高周波数の音が 1 kHz の場合よりもはるかに高い割合で減衰します。
    BYTE                    HighEQCutoff ;                          // HighEQGain パラメーターにより制御されるハイパス フィルターの折点周波数設定値( 指定可能範囲 0 ～ 14 )
                                                                    // 値と周波数 (kHz) の関係
                                                                    // 値          0    1    2     3    4     5    6     7    8     9   10    11   12    13   14
                                                                    // 周波数(kHz) 1  1.5    2   2.5    3   3.5    4   4.5    5   5.5    6   6.5    7   7.5    8

    float                    RoomFilterFreq ;                       // 室内エフェクトのローパス フィルターの折点周波数、単位は Hz ( 指定可能範囲 20.0f ～ 20000.0f )
    float                    RoomFilterMain ;                       // 初期反射と後期フィールド残響の両方に適用されるローパス フィルターのパス バンド強度レベル、単位は dB ( 指定可能範囲 -100.0f ～ 0.0f )
    float                    RoomFilterHF ;                         // 折点周波数 (RoomFilterFreq) での初期反射と後期フィールド残響の両方に適用されるローパス フィルターのパス バンド強度レベル、単位は dB ( 指定可能範囲 -100.0f ～ 0.0f )
    float                    ReflectionsGain ;                      // 初期反射の強度/レベルを調整値、単位は dB ( 指定可能範囲 -100.0f ～ 20.0f )
    float                    ReverbGain ;                           // リバーブの強度/レベルを調整値、単位は dB ( 指定可能範囲 -100.0f ～ 20.0f )
    float                    DecayTime ;                            // 1 kHz における残響減衰時間、単位は秒 ( 指定可能範囲 0.1f ～ 上限値特になし )、これは、フル スケールの入力信号が 60 dB 減衰するまでの時間です。
    float                    Density ;                              // 後期フィールド残響のモード密度を制御値、単位はパーセント( 指定可能範囲 0.0f ～ 100.0f )
                                                                    // 無色 (colorless) の空間では、Density を最大値 (100.0f ) に設定する必要があります。
                                                                    // Density を小さくすると、サウンドはくぐもった音 (くし形フィルターが適用された音) になります。
                                                                    // これはサイロをシミュレーションするときに有効なエフェクトです。
    float                    RoomSize ;                             // 音響空間の見かけ上のサイズ、単位はフィート( 指定可能範囲 1.0f (30.48 cm) ～ 100.0f (30.48 m) )
} SOUND3D_REVERB_PARAM ;

// ストリームデータ制御用関数ポインタ構造体タイプ２
typedef struct tagSTREAMDATASHREDTYPE2
{
    DWORD_PTR                (*Open        )( const TCHAR *Path, int UseCacheFlag, int BlockReadFlag, int UseASyncReadFlag ) ;
    int                        (*Close        )( DWORD_PTR Handle ) ;
    LONGLONG                (*Tell        )( DWORD_PTR Handle ) ;
    int                        (*Seek        )( DWORD_PTR Handle, LONGLONG SeekPoint, int SeekType ) ;
    size_t                    (*Read        )( void *Buffer, size_t BlockSize, size_t DataNum, DWORD_PTR Handle ) ;
    int                        (*Eof        )( DWORD_PTR Handle ) ;
    int                        (*IdleCheck    )( DWORD_PTR Handle ) ;
    int                        (*ChDir        )( const TCHAR *Path ) ;
    int                        (*GetDir    )( TCHAR *Buffer ) ;
    DWORD_PTR                (*FindFirst    )( const TCHAR *FilePath, FILEINFO *Buffer ) ;        // 戻り値: -1=エラー  -1以外=FindHandle
    int                        (*FindNext    )( DWORD_PTR FindHandle, FILEINFO *Buffer ) ;            // 戻り値: -1=エラー  0=成功
    int                        (*FindClose    )( DWORD_PTR FindHandle ) ;                            // 戻り値: -1=エラー  0=成功
} STREAMDATASHREDTYPE2 ;

// ストリームデータ制御用関数ポインタ構造体
typedef struct tagSTREAMDATASHRED
{
    LONGLONG                (*Tell        )( void *StreamDataPoint ) ;
    int                        (*Seek        )( void *StreamDataPoint, LONGLONG SeekPoint, int SeekType ) ;
    size_t                    (*Read        )( void *Buffer, size_t BlockSize, size_t DataNum, void *StreamDataPoint ) ;
//    size_t                    (*Write        )( void *Buffer, size_t BlockSize, size_t DataNum, void *StreamDataPoint ) ;
    int                        (*Eof        )( void *StreamDataPoint ) ;
    int                        (*IdleCheck    )( void *StreamDataPoint ) ;
    int                        (*Close        )( void *StreamDataPoint ) ;
} STREAMDATASHRED, *LPSTREAMDATASHRED ;

// ストリームデータ制御用データ構造体
typedef struct tagSTREAMDATA
{
    STREAMDATASHRED            ReadShred ;
    void                    *DataPoint ;
} STREAMDATA ;

// パレット情報構造体
typedef struct tagCOLORPALETTEDATA
{
    unsigned char            Blue ;
    unsigned char            Green ;
    unsigned char            Red ;
    unsigned char            Alpha ;
} COLORPALETTEDATA ;

// カラー構造情報構造体
typedef struct tagCOLORDATA
{
    unsigned char            Format ;                                           // フォーマット( DX_BASEIMAGE_FORMAT_NORMAL 等 )

    unsigned char            ChannelNum ;                                       // チャンネル数
    unsigned char            ChannelBitDepth ;                                  // １チャンネル辺りのビット深度
    unsigned char            FloatTypeFlag ;                                    // 浮動小数点型かどうか( TRUE:浮動小数点型  FALSE:整数型 )
    unsigned char            PixelByte ;                                        // １ピクセルあたりのバイト数

                                                                                // 以下は ChannelNum 又は ChannelBitDepth が 0 の時のみ有効
    unsigned char            ColorBitDepth ;                                    // ビット深度
    unsigned char            NoneLoc, NoneWidth ;                               // 使われていないビットのアドレスと幅
    unsigned char            RedWidth, GreenWidth, BlueWidth, AlphaWidth ;      // 各色のビット幅
    unsigned char            RedLoc    , GreenLoc  , BlueLoc  , AlphaLoc   ;    // 各色の配置されているビットアドレス
    unsigned int            RedMask , GreenMask , BlueMask , AlphaMask  ;       // 各色のビットマスク
    unsigned int            NoneMask ;                                          // 使われていないビットのマスク
    COLORPALETTEDATA        Palette[ 256 ] ;                                    // パレット( ColorBitDepth が８以下の場合のみ有効 )
} COLORDATA, *LPCOLORDATA ;

// 基本イメージデータ構造体
typedef struct tagBASEIMAGE
{
    COLORDATA                ColorData ;                             // 色情報
    int                        Width, Height, Pitch ;                // 幅、高さ、ピッチ
    void                    *GraphData ;                             // グラフィックイメージ
    int                        MipMapCount ;                         // ミップマップの数
    int                        GraphDataCount ;                      // グラフィックイメージの数
} BASEIMAGE, GRAPHIMAGE, *LPGRAPHIMAGE ;

// ラインデータ型
typedef struct tagLINEDATA
{
    int  x1, y1 ;                     // 座標
    int  x2, y2 ; 
    int  color ;                                // 色
    int  pal ;                                  // パラメータ
} LINEDATA, *LPLINEDATA ;

// 座標データ型
typedef struct tagPOINTDATA
{
    int                        x, y ;                                 // 座標
    int                        color ;                                // 色
    int                        pal ;                                  // パラメータ
} POINTDATA, *LPPOINTDATA ;

// イメージフォーマットデータ
typedef struct tagIMAGEFORMATDESC
{
    unsigned char            TextureFlag ;                      // テクスチャか、フラグ( TRUE:テクスチャ  FALSE:標準サーフェス )
    unsigned char            CubeMapTextureFlag ;               // キューブマップテクスチャか、フラグ( TRUE:キューブマップテクスチャ　FALSE:それ以外 )
    unsigned char            AlphaChFlag ;                      // αチャンネルはあるか、フラグ    ( TRUE:ある  FALSE:ない )
    unsigned char            DrawValidFlag ;                    // 描画可能か、フラグ( TRUE:可能  FALSE:不可能 )
    unsigned char            SystemMemFlag ;                    // システムメモリ上に存在しているか、フラグ( TRUE:システムメモリ上  FALSE:ＶＲＡＭ上 )( 標準サーフェスの時のみ有効 )
    unsigned char            UseManagedTextureFlag ;            // マネージドテクスチャを使用するか、フラグ

    unsigned char            BaseFormat ;                       // 基本フォーマット( DX_BASEIMAGE_FORMAT_NORMAL 等 )
    unsigned char            MipMapCount ;                      // ミップマップの数
    unsigned char            AlphaTestFlag ;                    // αテストチャンネルはあるか、フラグ( TRUE:ある  FALSE:ない )( テクスチャの場合のみ有効 )
    unsigned char            FloatTypeFlag ;                    // 浮動小数点型かどうか
    unsigned char            ColorBitDepth ;                    // 色深度( テクスチャの場合のみ有効 )
    unsigned char            ChannelNum ;                       // チャンネルの数
    unsigned char            ChannelBitDepth ;                  // １チャンネル辺りのビット深度( テクスチャの場合のみ有効、0 の場合は ColorBitDepth が使用される )
    unsigned char            BlendGraphFlag ;                   // ブレンド用画像か、フラグ
    unsigned char            UsePaletteFlag ;                   // パレットを使用しているか、フラグ( SystemMemFlag が TRUE の場合のみ有効 )

    unsigned char            MSSamples ;                        // マルチサンプリング数( 描画対象の場合使用 )
    unsigned char            MSQuality ;                        // マルチサンプリングクオリティ( 描画対象の場合使用 )
} IMAGEFORMATDESC ;


// DirectInput のジョイパッド入力情報
typedef struct tagDINPUT_JOYSTATE
{
    int                        X ;                                // スティックのＸ軸パラメータ( -1000～1000 )
    int                        Y ;                                // スティックのＹ軸パラメータ( -1000～1000 )
    int                        Z ;                                // スティックのＺ軸パラメータ( -1000～1000 )
    int                        Rx ;                               // スティックのＸ軸回転パラメータ( -1000～1000 )
    int                        Ry ;                               // スティックのＹ軸回転パラメータ( -1000～1000 )
    int                        Rz ;                               // スティックのＺ軸回転パラメータ( -1000～1000 )
    int                        Slider[ 2 ] ;                      // スライダー二つ
    unsigned int            POV[ 4 ] ;                            // ハットスイッチ４つ( 0xffffffff:入力なし 0:上 4500:右上 9000:右 13500:右下 18000:下 22500:左下 27000:左 31500:左上 )
    unsigned char            Buttons[ 32 ] ;                      // ボタン３２個( 押されたボタンは 128 になる )
} DINPUT_JOYSTATE ;

// XInput のジョイパッド入力情報
typedef struct tagXINPUT_STATE
{
    unsigned char            Buttons[ 16 ] ;                    // ボタン１６個( 添字には XINPUT_BUTTON_DPAD_UP 等を使用する、0:押されていない  1:押されている )
    unsigned char            LeftTrigger ;                      // 左トリガー( 0～255 )
    unsigned char            RightTrigger ;                     // 右トリガー( 0～255 )
    short                    ThumbLX ;                          // 左スティックの横軸値( -32768 ～ 32767 )
    short                    ThumbLY ;                          // 左スティックの縦軸値( -32768 ～ 32767 )
    short                    ThumbRX ;                          // 右スティックの横軸値( -32768 ～ 32767 )
    short                    ThumbRY ;                          // 右スティックの縦軸値( -32768 ～ 32767 )
} XINPUT_STATE ;

// WinSockets使用時のアドレス指定用構造体
typedef struct tagIPDATA
{
    unsigned char            d1, d2, d3, d4 ;                // アドレス値
} IPDATA, *LPIPDATA ;

typedef struct tagIPDATA_IPv6
{
    union
    {
        unsigned char            Byte[ 16 ] ;
        unsigned short            Word[ 8 ] ;
    } ;
} IPDATA_IPv6 ;

]]

--====================================================================
-- DxDll 
--====================================================================
ffi.cdef
[[
int  __stdcall dx_SetKeyInputStringColor( ULONGLONG  NmlStr, ULONGLONG  NmlCur, ULONGLONG  IMEStr, ULONGLONG  IMECur, ULONGLONG  IMELine, ULONGLONG  IMESelectStr, ULONGLONG  IMEModeStr, ULONGLONG  NmlStrE , ULONGLONG  IMESelectStrE , ULONGLONG  IMEModeStrE , ULONGLONG  IMESelectWinE , ULONGLONG  IMESelectWinF , ULONGLONG  SelectStrBackColor , ULONGLONG  SelectStrColor , ULONGLONG  SelectStrEdgeColor );
int  __stdcall dx_GraphFilterS( int GrHandle, int FilterType, int Param0, int Param1, int Param2, int Param3, int Param4, int Param5 ) ;
int  __stdcall dx_GraphFilterBltS( int SrcGrHandle, int DestGrHandle, int FilterType, int Param0, int Param1, int Param2, int Param3, int Param4, int Param5 ) ;
int  __stdcall dx_GraphFilterRectBltS( int SrcGrHandle, int DestGrHandle, int SrcX1, int SrcY1, int SrcX2, int SrcY2, int DestX, int DestY, int FilterType, int Param0, int Param1, int Param2, int Param3, int Param4, int Param5 ) ;
int  __stdcall dx_GraphBlendS( int GrHandle, int BlendGrHandle, int BlendRatio, int BlendType, int Param0, int Param1, int Param2, int Param3, int Param4, int Param5 ) ;
int  __stdcall dx_GraphBlendBltS( int SrcGrHandle, int BlendGrHandle, int DestGrHandle, int BlendRatio, int BlendType, int Param0, int Param1, int Param2, int Param3, int Param4, int Param5 ) ;
int  __stdcall dx_GraphBlendRectBltS( int SrcGrHandle, int BlendGrHandle, int DestGrHandle, int SrcX1, int SrcY1, int SrcX2, int SrcY2, int BlendX, int BlendY, int DestX, int DestY, int BlendRatio, int BlendType, int Param0, int Param1, int Param2, int Param3, int Param4, int Param5 ) ;
int  __stdcall dx_SetBlendGraphParamS( int BlendGraph, int BlendType, int Param0, int Param1, int Param2, int Param3, int Param4, int Param5 ) ;
VECTOR __stdcall dx_VGet( float x, float y, float z ) ;
VECTOR __stdcall dx_VAdd( VECTOR In1, VECTOR In2 ) ;
VECTOR __stdcall dx_VSub( VECTOR In1, VECTOR In2 ) ;
float __stdcall dx_VDot( VECTOR In1, VECTOR In2 ) ;
VECTOR __stdcall dx_VCross( VECTOR In1, VECTOR In2 ) ;
VECTOR __stdcall dx_VScale( VECTOR In, float Scale ) ;
float __stdcall dx_VSquareSize( VECTOR In ) ;
VECTOR __stdcall dx_VTransform( VECTOR InV, MATRIX InM ) ;
VECTOR __stdcall dx_VTransformSR( VECTOR InV, MATRIX InM ) ;
int  __stdcall dx_DxLib_Init( void);
int  __stdcall dx_DxLib_End( void);
int  __stdcall dx_DxLib_GlobalStructInitialize( void);
int  __stdcall dx_DxLib_IsInit( void);
int  __stdcall dx_ProcessMessage( void);
int  __stdcall dx_WaitTimer( int  WaitTime);
int  __stdcall dx_WaitKey( void);
int  __stdcall dx_GetNowCount( int  UseRDTSCFlag );
LONGLONG  __stdcall dx_GetNowHiPerformanceCount( int  UseRDTSCFlag );
int  __stdcall dx_GetDateTime( DATEDATA *  DateBuf);
int  __stdcall dx_GetRand( int  RandMax);
int  __stdcall dx_SRand( int  Seed);
int  __stdcall dx_ErrorLogAdd( const char * ErrorStr);
int  __stdcall dx_ErrorLogTabAdd( void);
int  __stdcall dx_ErrorLogTabSub( void);
int  __stdcall dx_SetUseTimeStampFlag( int  UseFlag);
int  __stdcall dx_SetLogDrawOutFlag( int  DrawFlag);
int  __stdcall dx_GetLogDrawFlag( void);
int  __stdcall dx_SetLoglSize( int  Size);
int  __stdcall dx_clsDx( void);
int  __stdcall dx_SetUseASyncLoadFlag( int  Flag);
int  __stdcall dx_CheckHandleASyncLoad( int  Handle);
int  __stdcall dx_GetHandleASyncLoadResult( int  Handle);
int  __stdcall dx_GetASyncLoadNum( void);
int  __stdcall dx_SetDeleteHandleFlag( int  Handle, int *  DeleteFlag);
int __stdcall dx_GetResourceInfo( const TCHAR * ResourceName , const TCHAR * ResourceType , void * * DataPointerP , int * DataSizeP ) ;
const TCHAR * __stdcall dx_GetResourceIDString( int ResourceID ) ;
int  __stdcall dx_GetWindowCRect( RECT *  RectBuf);
int  __stdcall dx_GetWindowActiveFlag( void);
int  __stdcall dx_GetWindowMinSizeFlag( void);
int  __stdcall dx_GetActiveFlag( void);
HWND __stdcall dx_GetMainWindowHandle( void );
int  __stdcall dx_GetWindowModeFlag( void);
int  __stdcall dx_GetDefaultState( int *  SizeX, int *  SizeY, int *  ColorBitDepth, int *  RefreshRate);
int  __stdcall dx_GetNoActiveState( int  ResetFlag );
int  __stdcall dx_GetMouseDispFlag( void);
int  __stdcall dx_GetAlwaysRunFlag( void);
int  __stdcall dx__GetSystemInfo( int *  DxLibVer, int *  DirectXVer, int *  WindowsVer);
int  __stdcall dx_GetPcInfo( TCHAR *  OSString, TCHAR *  DirectXString, TCHAR *  CPUString, int *  CPUSpeed, double *  FreeMemorySize, double *  TotalMemorySize, TCHAR *  VideoDriverFileName, TCHAR *  VideoDriverString, double *  FreeVideoMemorySize, double *  TotalVideoMemorySize);
int  __stdcall dx_GetUseMMXFlag( void);
int  __stdcall dx_GetUseSSEFlag( void);
int  __stdcall dx_GetUseSSE2Flag( void);
int  __stdcall dx_GetWindowCloseFlag( void);
HINSTANCE __stdcall dx_GetTaskInstance( void );
int  __stdcall dx_GetUseWindowRgnFlag( void);
int __stdcall dx_GetWindowSizeChangeEnableFlag( int * FitScreen ) ;
double __stdcall dx_GetWindowSizeExtendRate( double * ExRateX ) ;
int  __stdcall dx_GetWindowSize( int *  Width, int *  Height);
int  __stdcall dx_GetWindowPosition( int *  x, int *  y);
int  __stdcall dx_GetWindowUserCloseFlag( int  StateResetFlag );
int  __stdcall dx_GetNotDrawFlag( void);
int  __stdcall dx_GetPaintMessageFlag( void);
int  __stdcall dx_GetValidHiPerformanceCounter( void);
TCHAR __stdcall dx_GetInputSystemChar( int DeleteFlag ) ;
int  __stdcall dx_ChangeWindowMode( int  Flag);
int  __stdcall dx_SetUseCharSet( int  CharSet);
int  __stdcall dx_LoadPauseGraph( const char * FileName);
int  __stdcall dx_LoadPauseGraphFromMem( const void * MemImage, int  MemImageSize);
int __stdcall dx_SetActiveStateChangeCallBackFunction( int ( *CallBackFunction )( int ActiveState , void * UserData ) , void * UserData ) ;
int  __stdcall dx_SetWindowText( const char * WindowText);
int  __stdcall dx_SetMainWindowText( const char * WindowText);
int  __stdcall dx_SetMainWindowClassName( const char * ClassName);
int  __stdcall dx_SetOutApplicationLogValidFlag( int  Flag);
int  __stdcall dx_SetApplicationLogSaveDirectory( const char * DirectoryPath);
int  __stdcall dx_SetUseDateNameLogFile( int  Flag);
int  __stdcall dx_SetAlwaysRunFlag( int  Flag);
int  __stdcall dx_SetWindowIconID( int  ID);
int  __stdcall dx_SetWindowIconHandle( HICON  Icon);
int __stdcall dx_SetUseASyncChangeWindowModeFunction( int Flag , void ( *CallBackFunction )( void * ) , void * Data ) ;
int  __stdcall dx_SetWindowStyleMode( int  Mode);
int  __stdcall dx_SetWindowSizeChangeEnableFlag( int  Flag, int  FitScreen );
int  __stdcall dx_SetWindowSizeExtendRate( double  ExRateX, double  ExRateY );
int  __stdcall dx_SetWindowSize( int  Width, int  Height);
int  __stdcall dx_SetWindowPosition( int  x, int  y);
int  __stdcall dx_SetSysCommandOffFlag( int  Flag, const char * HookDllPath );
int __stdcall dx_SetHookWinProc( WNDPROC WinProc ) ;
int  __stdcall dx_SetUseHookWinProcReturnValue( int  UseFlag);
int  __stdcall dx_SetDoubleStartValidFlag( int  Flag);
int  __stdcall dx_AddMessageTakeOverWindow( HWND  Window);
int  __stdcall dx_SubMessageTakeOverWindow( HWND  Window);
int  __stdcall dx_SetWindowInitPosition( int  x, int  y);
int  __stdcall dx_SetNotWinFlag( int  Flag);
int  __stdcall dx_SetNotDrawFlag( int  Flag);
int  __stdcall dx_SetNotSoundFlag( int  Flag);
int  __stdcall dx_SetNotInputFlag( int  Flag);
int  __stdcall dx_SetDialogBoxHandle( HWND  WindowHandle);
int  __stdcall dx_SetWindowVisibleFlag( int  Flag);
int  __stdcall dx_SetWindowMinimizeFlag( int  Flag);
int  __stdcall dx_SetWindowUserCloseEnableFlag( int  Flag);
int  __stdcall dx_SetDxLibEndPostQuitMessageFlag( int  Flag);
int  __stdcall dx_SetUserWindow( HWND  WindowHandle);
int  __stdcall dx_SetUserChildWindow( HWND  WindowHandle);
int  __stdcall dx_SetUserWindowMessageProcessDXLibFlag( int  Flag);
int  __stdcall dx_SetUseFPUPreserveFlag( int  Flag);
int  __stdcall dx_SetValidMousePointerWindowOutClientAreaMoveFlag( int  Flag);
int  __stdcall dx_SetUseBackBufferTransColorFlag( int  Flag);
int  __stdcall dx_SetUseUpdateLayerdWindowFlag( int  Flag);
int __stdcall dx_SetResourceModule( HMODULE ResourceModule ) ;
int  __stdcall dx_GetClipboardText( TCHAR *  DestBuffer);
int  __stdcall dx_SetClipboardText( const char * Text);
int  __stdcall dx_SetDragFileValidFlag( int  Flag);
int  __stdcall dx_DragFileInfoClear( void);
int  __stdcall dx_GetDragFilePath( TCHAR *  FilePathBuffer);
int  __stdcall dx_GetDragFileNum( void);
HRGN __stdcall dx_CreateRgnFromGraph( int Width , int Height , const void * MaskData , int Pitch , int Byte ) ;
HRGN __stdcall dx_CreateRgnFromBaseImage( BASEIMAGE * BaseImage , int TransColorR , int TransColorG , int TransColorB ) ;
int  __stdcall dx_SetWindowRgnGraph( const char * FileName);
int  __stdcall dx_UpdateTransColorWindowRgn( void);
int  __stdcall dx_SetupToolBar( const char * BitmapName, int  DivNum, int  ResourceID );
int  __stdcall dx_AddToolBarButton( int  Type, int  State, int  ImageIndex, int  ID);
int  __stdcall dx_AddToolBarSep( void);
int  __stdcall dx_GetToolBarButtonState( int  ID);
int  __stdcall dx_SetToolBarButtonState( int  ID, int  State);
int  __stdcall dx_DeleteAllToolBarButton( void);
int  __stdcall dx_SetUseMenuFlag( int  Flag);
int  __stdcall dx_SetUseKeyAccelFlag( int  Flag);
int  __stdcall dx_AddKeyAccel( const char * ItemName, int  ItemID, int  KeyCode, int  CtrlFlag, int  AltFlag, int  ShiftFlag);
int  __stdcall dx_AddKeyAccel_Name( const char * ItemName, int  KeyCode, int  CtrlFlag, int  AltFlag, int  ShiftFlag);
int  __stdcall dx_AddKeyAccel_ID( int  ItemID, int  KeyCode, int  CtrlFlag, int  AltFlag, int  ShiftFlag);
int  __stdcall dx_ClearKeyAccel( void);
int  __stdcall dx_AddMenuItem( int  AddType, const char * ItemName, int  ItemID, int  SeparatorFlag, const char * NewItemName , int  NewItemID );
int  __stdcall dx_DeleteMenuItem( const char * ItemName, int  ItemID);
int  __stdcall dx_CheckMenuItemSelect( const char * ItemName, int  ItemID);
int  __stdcall dx_SetMenuItemEnable( const char * ItemName, int  ItemID, int  EnableFlag);
int  __stdcall dx_SetMenuItemMark( const char * ItemName, int  ItemID, int  Mark);
int  __stdcall dx_CheckMenuItemSelectAll( void);
int  __stdcall dx_AddMenuItem_Name( const char * ParentItemName, const char * NewItemName);
int  __stdcall dx_AddMenuLine_Name( const char * ParentItemName);
int  __stdcall dx_InsertMenuItem_Name( const char * ItemName, const char * NewItemName);
int  __stdcall dx_InsertMenuLine_Name( const char * ItemName);
int  __stdcall dx_DeleteMenuItem_Name( const char * ItemName);
int  __stdcall dx_CheckMenuItemSelect_Name( const char * ItemName);
int  __stdcall dx_SetMenuItemEnable_Name( const char * ItemName, int  EnableFlag);
int  __stdcall dx_SetMenuItemMark_Name( const char * ItemName, int  Mark);
int  __stdcall dx_AddMenuItem_ID( int  ParentItemID, const char * NewItemName, int  NewItemID );
int  __stdcall dx_AddMenuLine_ID( int  ParentItemID);
int  __stdcall dx_InsertMenuItem_ID( int  ItemID, int  NewItemID);
int  __stdcall dx_InsertMenuLine_ID( int  ItemID, int  NewItemID);
int  __stdcall dx_DeleteMenuItem_ID( int  ItemID);
int  __stdcall dx_CheckMenuItemSelect_ID( int  ItemID);
int  __stdcall dx_SetMenuItemEnable_ID( int  ItemID, int  EnableFlag);
int  __stdcall dx_SetMenuItemMark_ID( int  ItemID, int  Mark);
int  __stdcall dx_DeleteMenuItemAll( void);
int  __stdcall dx_ClearMenuItemSelect( void);
int  __stdcall dx_GetMenuItemID( const char * ItemName);
int  __stdcall dx_GetMenuItemName( int  ItemID, TCHAR *  NameBuffer);
int  __stdcall dx_LoadMenuResource( int  MenuResourceID);
int __stdcall dx_SetMenuItemSelectCallBackFunction( void ( *CallBackFunction )( const TCHAR * ItemName , int ItemID ) ) ;
int __stdcall dx_SetWindowMenu( int MenuID , int ( *MenuProc )( WORD ID ) ) ;
int  __stdcall dx_SetDisplayMenuFlag( int  Flag);
int  __stdcall dx_GetDisplayMenuFlag( void);
int  __stdcall dx_GetUseMenuFlag( void);
int  __stdcall dx_SetAutoMenuDisplayFlag( int  Flag);
int  __stdcall dx_SetMouseDispFlag( int  DispFlag);
int  __stdcall dx_GetMousePoint( int *  XBuf, int *  YBuf);
int  __stdcall dx_SetMousePoint( int  PointX, int  PointY);
int  __stdcall dx_GetMouseInput( void);
int  __stdcall dx_GetMouseWheelRotVol( int  CounterReset );
int  __stdcall dx_GetMouseHWheelRotVol( int  CounterReset );
float  __stdcall dx_GetMouseWheelRotVolF( int  CounterReset );
float  __stdcall dx_GetMouseHWheelRotVolF( int  CounterReset );

int  __stdcall dx_GetMouseInputLog( int *  Button, int *  ClickX, int *  ClickY, int  LogDelete );
void *  __stdcall dx_DxAlloc( size_t  AllocSize, const char * File , int  Line );
void *  __stdcall dx_DxCalloc( size_t  AllocSize, const char * File , int  Line );
void *  __stdcall dx_DxRealloc( void *  Memory, size_t  AllocSize, const char * File , int  Line );
void  __stdcall dx_DxFree( void *  Memory);
size_t  __stdcall dx_DxSetAllocSizeTrap( size_t  Size);
int  __stdcall dx_DxSetAllocPrintFlag( int  Flag);
size_t  __stdcall dx_DxGetAllocSize( void);
int  __stdcall dx_DxGetAllocNum( void);
void  __stdcall dx_DxDumpAlloc( void);
int  __stdcall dx_DxErrorCheckAlloc( void);
int  __stdcall dx_DxSetAllocSizeOutFlag( int  Flag);
int  __stdcall dx_DxSetAllocMemoryErrorCheckFlag( int  Flag);
int  __stdcall dx_ProcessNetMessage( int  RunReleaseProcess );
int  __stdcall dx_GetHostIPbyName( const char * HostName, IPDATA *  IPDataBuf);
int  __stdcall dx_GetHostIPbyName_IPv6( const char * HostName, IPDATA_IPv6 *  IPDataBuf);
int  __stdcall dx_ConnectNetWork( IPDATA  IPData, int  Port );
int  __stdcall dx_ConnectNetWork_IPv6( IPDATA_IPv6  IPData, int  Port );
int  __stdcall dx_ConnectNetWork_ASync( IPDATA  IPData, int  Port );
int  __stdcall dx_ConnectNetWork_IPv6_ASync( IPDATA_IPv6  IPData, int  Port );
int  __stdcall dx_PreparationListenNetWork( int  Port );
int  __stdcall dx_PreparationListenNetWork_IPv6( int  Port );
int  __stdcall dx_StopListenNetWork( void);
int  __stdcall dx_CloseNetWork( int  NetHandle);
int  __stdcall dx_GetNetWorkAcceptState( int  NetHandle);
int  __stdcall dx_GetNetWorkDataLength( int  NetHandle);
int  __stdcall dx_GetNetWorkSendDataLength( int  NetHandle);
int  __stdcall dx_GetNewAcceptNetWork( void);
int  __stdcall dx_GetLostNetWork( void);
int  __stdcall dx_GetNetWorkIP( int  NetHandle, IPDATA *  IpBuf);
int  __stdcall dx_GetNetWorkIP_IPv6( int  NetHandle, IPDATA_IPv6 *  IpBuf);
int  __stdcall dx_GetMyIPAddress( IPDATA *  IpBuf);
int  __stdcall dx_SetConnectTimeOutWait( int  Time);
int  __stdcall dx_SetUseDXNetWorkProtocol( int  Flag);
int  __stdcall dx_GetUseDXNetWorkProtocol( void);
int  __stdcall dx_SetUseDXProtocol( int  Flag);
int  __stdcall dx_GetUseDXProtocol( void);
int  __stdcall dx_SetNetWorkCloseAfterLostFlag( int  Flag);
int  __stdcall dx_GetNetWorkCloseAfterLostFlag( void);
int  __stdcall dx_NetWorkRecv( int  NetHandle, void *  Buffer, int  Length);
int  __stdcall dx_NetWorkRecvToPeek( int  NetHandle, void *  Buffer, int  Length);
int  __stdcall dx_NetWorkRecvBufferClear( int  NetHandle);
int  __stdcall dx_NetWorkSend( int  NetHandle, const void * Buffer, int  Length);
int  __stdcall dx_MakeUDPSocket( int  RecvPort );
int  __stdcall dx_MakeUDPSocket_IPv6( int  RecvPort );
int  __stdcall dx_DeleteUDPSocket( int  NetUDPHandle);
int  __stdcall dx_NetWorkSendUDP( int  NetUDPHandle, IPDATA  SendIP, int  SendPort, const void * Buffer, int  Length);
int  __stdcall dx_NetWorkSendUDP_IPv6( int  NetUDPHandle, IPDATA_IPv6  SendIP, int  SendPort, const void * Buffer, int  Length);
int  __stdcall dx_NetWorkRecvUDP( int  NetUDPHandle, IPDATA *  RecvIP, int *  RecvPort, void *  Buffer, int  Length, int  Peek);
int  __stdcall dx_NetWorkRecvUDP_IPv6( int  NetUDPHandle, IPDATA_IPv6 *  RecvIP, int *  RecvPort, void *  Buffer, int  Length, int  Peek);
int  __stdcall dx_CheckNetWorkRecvUDP( int  NetUDPHandle);
int  __stdcall dx_StockInputChar( TCHAR  CharCode);
int  __stdcall dx_ClearInputCharBuf( void);
TCHAR __stdcall dx_GetInputChar( int DeleteFlag ) ;
TCHAR __stdcall dx_GetInputCharWait( int DeleteFlag ) ;
int  __stdcall dx_GetOneChar( TCHAR *  CharBuffer, int  DeleteFlag);
int  __stdcall dx_GetOneCharWait( TCHAR *  CharBuffer, int  DeleteFlag);
int  __stdcall dx_GetCtrlCodeCmp( TCHAR  Char);
int  __stdcall dx_DrawIMEInputString( int  x, int  y, int  SelectStringNum);
int  __stdcall dx_SetUseIMEFlag( int  UseFlag);
int  __stdcall dx_SetInputStringMaxLengthIMESync( int  Flag);
int  __stdcall dx_SetIMEInputStringMaxLength( int  Length);
int  __stdcall dx_GetStringPoint( const char * String, int  Point);
int  __stdcall dx_GetStringPoint2( const char * String, int  Point);
int  __stdcall dx_GetStringLength( const char * String);
int  __stdcall dx_DrawObtainsString( int  x, int  y, int  AddY, const char * String, int  StrColor, int  StrEdgeColor , int  FontHandle , int  SelectBackColor , int  SelectStrColor , int  SelectStrEdgeColor , int  SelectStart , int  SelectEnd );
int  __stdcall dx_DrawObtainsString_CharClip( int  x, int  y, int  AddY, const char * String, int  StrColor, int  StrEdgeColor , int  FontHandle , int  SelectBackColor , int  SelectStrColor , int  SelectStrEdgeColor , int  SelectStart , int  SelectEnd );
int  __stdcall dx_DrawObtainsBox( int  x1, int  y1, int  x2, int  y2, int  AddY, int  Color, int  FillFlag);
int  __stdcall dx_InputStringToCustom( int  x, int  y, int  BufLength, TCHAR *  StrBuffer, int  CancelValidFlag, int  SingleCharOnlyFlag, int  NumCharOnlyFlag, int  DoubleCharOnlyFlag );
int  __stdcall dx_KeyInputString( int  x, int  y, int  CharMaxLength, TCHAR *  StrBuffer, int  CancelValidFlag);
int  __stdcall dx_KeyInputSingleCharString( int  x, int  y, int  CharMaxLength, TCHAR *  StrBuffer, int  CancelValidFlag);
int  __stdcall dx_KeyInputNumber( int  x, int  y, int  MaxNum, int  MinNum, int  CancelValidFlag);
int  __stdcall dx_GetIMEInputModeStr( TCHAR *  GetBuffer);
const IMEINPUTDATA * __stdcall dx_GetIMEInputData( void );
int  __stdcall dx_SetKeyInputStringColor2( int  TargetColor, int  Color);
int  __stdcall dx_ResetKeyInputStringColor2( int  TargetColor);
int  __stdcall dx_SetKeyInputStringFont( int  FontHandle);
int  __stdcall dx_SetKeyInputStringEndCharaMode( int  EndCharaMode);
int  __stdcall dx_DrawKeyInputModeString( int  x, int  y);
int  __stdcall dx_InitKeyInput( void);
int  __stdcall dx_MakeKeyInput( int  MaxStrLength, int  CancelValidFlag, int  SingleCharOnlyFlag, int  NumCharOnlyFlag, int  DoubleCharOnlyFlag );
int  __stdcall dx_DeleteKeyInput( int  InputHandle);
int  __stdcall dx_SetActiveKeyInput( int  InputHandle);
int  __stdcall dx_GetActiveKeyInput( void);
int  __stdcall dx_CheckKeyInput( int  InputHandle);
int  __stdcall dx_ReStartKeyInput( int  InputHandle);
int  __stdcall dx_ProcessActKeyInput( void);
int  __stdcall dx_DrawKeyInputString( int  x, int  y, int  InputHandle);
int  __stdcall dx_SetKeyInputSelectArea( int  SelectStart, int  SelectEnd, int  InputHandle);
int  __stdcall dx_GetKeyInputSelectArea( int *  SelectStart, int *  SelectEnd, int  InputHandle);
int  __stdcall dx_SetKeyInputDrawStartPos( int  DrawStartPos, int  InputHandle);
int  __stdcall dx_GetKeyInputDrawStartPos( int  InputHandle);
int  __stdcall dx_SetKeyInputCursorBrinkTime( int  Time);
int  __stdcall dx_SetKeyInputCursorBrinkFlag( int  Flag);
int  __stdcall dx_SetKeyInputString( const char * String, int  InputHandle);
int  __stdcall dx_SetKeyInputNumber( int  Number, int  InputHandle);
int  __stdcall dx_SetKeyInputNumberToFloat( float  Number, int  InputHandle);
int  __stdcall dx_GetKeyInputString( TCHAR *  StrBuffer, int  InputHandle);
int  __stdcall dx_GetKeyInputNumber( int  InputHandle);
float  __stdcall dx_GetKeyInputNumberToFloat( int  InputHandle);
int  __stdcall dx_SetKeyInputCursorPosition( int  Position, int  InputHandle);
int  __stdcall dx_GetKeyInputCursorPosition( int  InputHandle);
int  __stdcall dx_FileRead_open( const char * FilePath, int  ASync );
LONGLONG  __stdcall dx_FileRead_size( const char * FilePath);
int  __stdcall dx_FileRead_close( int  FileHandle);
LONGLONG  __stdcall dx_FileRead_tell( int  FileHandle);
int  __stdcall dx_FileRead_seek( int  FileHandle, LONGLONG  Offset, int  Origin);
int  __stdcall dx_FileRead_read( void *  Buffer, int  ReadSize, int  FileHandle);
int  __stdcall dx_FileRead_idle_chk( int  FileHandle);
int  __stdcall dx_FileRead_eof( int  FileHandle);
int  __stdcall dx_FileRead_gets( TCHAR *  Buffer, int  BufferSize, int  FileHandle);
TCHAR __stdcall dx_FileRead_getc( int FileHandle ) ;
DWORD_PTR  __stdcall dx_FileRead_createInfo( const char * ObjectPath);
int  __stdcall dx_FileRead_getInfoNum( DWORD_PTR  FileInfoHandle);
int __stdcall dx_FileRead_getInfo( int Index , FILEINFO * Buffer , DWORD_PTR FileInfoHandle ) ;
int  __stdcall dx_FileRead_deleteInfo( DWORD_PTR  FileInfoHandle);
DWORD_PTR __stdcall dx_FileRead_findFirst( const TCHAR * FilePath , FILEINFO * Buffer ) ;
int __stdcall dx_FileRead_findNext( DWORD_PTR FindHandle , FILEINFO * Buffer ) ;
int __stdcall dx_FileRead_findClose( DWORD_PTR FindHandle ) ;
int  __stdcall dx_FileRead_fullyLoad( const char * FilePath);
int  __stdcall dx_FileRead_fullyLoad_delete( int  FLoadHandle);
const void * __stdcall dx_FileRead_fullyLoad_getImage( int  FLoadHandle);
LONGLONG  __stdcall dx_FileRead_fullyLoad_getSize( int  FLoadHandle);
int  __stdcall dx_GetStreamFunctionDefault( void);
int __stdcall dx_ChangeStreamFunction( const STREAMDATASHREDTYPE2 * StreamThread ) ;
int  __stdcall dx_ConvertFullPath( const char * Src, TCHAR *  Dest, const char * CurrentDir );
int  __stdcall dx_CheckHitKey( int  KeyCode);
int  __stdcall dx_CheckHitKeyAll( int  CheckType );
int  __stdcall dx_GetHitKeyStateAll( DX_CHAR *  KeyStateBuf);
int  __stdcall dx_SetKeyExclusiveCooperativeLevelFlag( int  Flag);
int  __stdcall dx_GetJoypadNum( void);
int  __stdcall dx_GetJoypadInputState( int  InputType);
int  __stdcall dx_GetJoypadAnalogInput( int *  XBuf, int *  YBuf, int  InputType);
int  __stdcall dx_GetJoypadAnalogInputRight( int *  XBuf, int *  YBuf, int  InputType);
int  __stdcall dx_GetJoypadDirectInputState( int  InputType, DINPUT_JOYSTATE *  DInputState);
int  __stdcall dx_CheckJoypadXInput( int  InputType);
int  __stdcall dx_GetJoypadXInputState( int  InputType, XINPUT_STATE *  XInputState);
int  __stdcall dx_KeyboradBufferProcess( void);
int __stdcall dx_GetJoypadGUID( int PadIndex , GUID * GuidBuffer ) ;
int  __stdcall dx_ConvertKeyCodeToVirtualKey( int  KeyCode);
int  __stdcall dx_ConvertVirtualKeyToKeyCode( int  VirtualKey);
int  __stdcall dx_SetJoypadInputToKeyInput( int  InputType, int  PadInput, int  KeyInput1, int  KeyInput2 , int  KeyInput3 , int  KeyInput4 );
int  __stdcall dx_SetJoypadDeadZone( int  InputType, double  Zone);
int  __stdcall dx_StartJoypadVibration( int  InputType, int  Power, int  Time, int  EffectIndex );
int  __stdcall dx_StopJoypadVibration( int  InputType, int  EffectIndex );
int  __stdcall dx_GetJoypadPOVState( int  InputType, int  POVNumber);
int  __stdcall dx_GetJoypadName( int  InputType, TCHAR *  InstanceNameBuffer, TCHAR *  ProductNameBuffer);
int  __stdcall dx_ReSetupJoypad( void);
int  __stdcall dx_SetKeyboardNotDirectInputFlag( int  Flag);
int  __stdcall dx_SetUseDirectInputFlag( int  Flag);
int  __stdcall dx_SetUseXInputFlag( int  Flag);
int  __stdcall dx_SetUseJoypadVibrationFlag( int  Flag);
int  __stdcall dx_MakeGraph( int  SizeX, int  SizeY, int  NotUse3DFlag );
int  __stdcall dx_MakeScreen( int  SizeX, int  SizeY, int  UseAlphaChannel );
int  __stdcall dx_DerivationGraph( int  SrcX, int  SrcY, int  Width, int  Height, int  SrcGraphHandle);
int  __stdcall dx_DeleteGraph( int  GrHandle, int  LogOutFlag );
int  __stdcall dx_DeleteSharingGraph( int  GrHandle);
int  __stdcall dx_GetGraphNum( void);
int  __stdcall dx_FillGraph( int  GrHandle, int  Red, int  Green, int  Blue, int  Alpha );
int  __stdcall dx_SetGraphLostFlag( int  GrHandle, int *  LostFlag);
int  __stdcall dx_InitGraph( int  LogOutFlag );
int  __stdcall dx_ReloadFileGraphAll( void);
int  __stdcall dx_MakeShadowMap( int  SizeX, int  SizeY);
int  __stdcall dx_DeleteShadowMap( int  SmHandle);
int  __stdcall dx_SetShadowMapLightDirection( int  SmHandle, VECTOR  Direction);
int  __stdcall dx_ShadowMap_DrawSetup( int  SmHandle);
int  __stdcall dx_ShadowMap_DrawEnd( void);
int  __stdcall dx_SetUseShadowMap( int  SmSlotIndex, int  SmHandle);
int  __stdcall dx_SetShadowMapDrawArea( int  SmHandle, VECTOR  MinPosition, VECTOR  MaxPosition);
int  __stdcall dx_ResetShadowMapDrawArea( int  SmHandle);
int  __stdcall dx_SetShadowMapAdjustDepth( int  SmHandle, float  Depth);
int  __stdcall dx_TestDrawShadowMap( int  SmHandle, int  x1, int  y1, int  x2, int  y2);
int __stdcall dx_BltBmpToGraph( const COLORDATA * BmpColorData , HBITMAP RgbBmp , HBITMAP AlphaBmp , int CopyPointX , int CopyPointY , int GrHandle ) ;
int __stdcall dx_BltBmpToDivGraph( const COLORDATA * BmpColorData , HBITMAP RgbBmp , HBITMAP AlphaBmp , int AllNum , int XNum , int YNum , int Width , int Height , const int * GrHandle , int ReverseFlag ) ;
int __stdcall dx_BltBmpOrGraphImageToGraph( const COLORDATA * BmpColorData , HBITMAP RgbBmp , HBITMAP AlphaBmp , int BmpFlag , const BASEIMAGE * RgbBaseImage , const BASEIMAGE * AlphaBaseImage , int CopyPointX , int CopyPointY , int GrHandle ) ;
int __stdcall dx_BltBmpOrGraphImageToGraph2( const COLORDATA * BmpColorData , HBITMAP RgbBmp , HBITMAP AlphaBmp , int BmpFlag , const BASEIMAGE * RgbBaseImage , const BASEIMAGE * AlphaBaseImage , const RECT * SrcRect , int DestX , int DestY , int GrHandle ) ;
int __stdcall dx_BltBmpOrGraphImageToDivGraph( const COLORDATA * BmpColorData , HBITMAP RgbBmp , HBITMAP AlphaBmp , int BmpFlag , const BASEIMAGE * RgbBaseImage , const BASEIMAGE * AlphaBaseImage , int AllNum , int XNum , int YNum , int Width , int Height , const int * GrHandle , int ReverseFlag ) ;
int  __stdcall dx_LoadBmpToGraph( const char * FileName, int  TextureFlag, int  ReverseFlag, int  SurfaceMode );
int  __stdcall dx_LoadGraph( const char * FileName, int  NotUse3DFlag );
int  __stdcall dx_LoadReverseGraph( const char * FileName, int  NotUse3DFlag );
int  __stdcall dx_LoadDivGraph( const char * FileName, int  AllNum, int  XNum, int  YNum, int  XSize, int  YSize, int *  HandleBuf, int  NotUse3DFlag );
int  __stdcall dx_LoadDivBmpToGraph( const char * FileName, int  AllNum, int  XNum, int  YNum, int  SizeX, int  SizeY, int *  HandleBuf, int  TextureFlag, int  ReverseFlag);
int  __stdcall dx_LoadReverseDivGraph( const char * FileName, int  AllNum, int  XNum, int  YNum, int  XSize, int  YSize, int *  HandleBuf, int  NotUse3DFlag );
int  __stdcall dx_LoadBlendGraph( const char * FileName);
int __stdcall dx_LoadGraphToResource( int ResourceID ) ;
int  __stdcall dx_LoadDivGraphToResource( int  ResourceID, int  AllNum, int  XNum, int  YNum, int  XSize, int  YSize, int *  HandleBuf);
int __stdcall dx_LoadGraphToResource_2( const TCHAR * ResourceName , const TCHAR * ResourceType ) ;
int  __stdcall dx_LoadDivGraphToResource_2( const char * ResourceName, const char * ResourceType, int  AllNum, int  XNum, int  YNum, int  XSize, int  YSize, int *  HandleBuf);
int  __stdcall dx_CreateGraphFromMem( const void * RGBFileImage, int  RGBFileImageSize, const void * AlphaFileImage , int  AlphaFileImageSize , int  TextureFlag , int  ReverseFlag );
int  __stdcall dx_ReCreateGraphFromMem( const void * RGBFileImage, int  RGBFileImageSize, int  GrHandle, const void * AlphaFileImage , int  AlphaFileImageSize , int  TextureFlag , int  ReverseFlag );
int  __stdcall dx_CreateDivGraphFromMem( const void * RGBFileImage, int  RGBFileImageSize, int  AllNum, int  XNum, int  YNum, int  SizeX, int  SizeY, int *  HandleBuf, int  TextureFlag , int  ReverseFlag , const void * AlphaFileImage , int  AlphaFileImageSize );
int  __stdcall dx_ReCreateDivGraphFromMem( const void * RGBFileImage, int  RGBFileImageSize, int  AllNum, int  XNum, int  YNum, int  SizeX, int  SizeY, const int *  HandleBuf, int  TextureFlag , int  ReverseFlag , const void * AlphaFileImage , int  AlphaFileImageSize );
int __stdcall dx_CreateGraphFromBmp( const BITMAPINFO * RGBBmpInfo , const void * RGBBmpImage , const BITMAPINFO * AlphaBmpInfo ) ;
int __stdcall dx_ReCreateGraphFromBmp( const BITMAPINFO * RGBBmpInfo , const void * RGBBmpImage , int GrHandle , const BITMAPINFO * AlphaBmpInfo ) ;
int __stdcall dx_CreateDivGraphFromBmp( const BITMAPINFO * RGBBmpInfo , const void * RGBBmpImage , int AllNum , int XNum , int YNum , int SizeX , int SizeY , int * HandleBuf , int TextureFlag ) ;
int __stdcall dx_ReCreateDivGraphFromBmp( const BITMAPINFO * RGBBmpInfo , const void * RGBBmpImage , int AllNum , int XNum , int YNum , int SizeX , int SizeY , const int * HandleBuf , int TextureFlag ) ;
int __stdcall dx_CreateDXGraph( const BASEIMAGE * RgbBaseImage , const BASEIMAGE * AlphaBaseImage , int TextureFlag ) ;
int __stdcall dx_CreateGraphFromGraphImage( const BASEIMAGE * RgbBaseImage , int TextureFlag ) ;
int __stdcall dx_CreateGraphFromGraphImage_2( const BASEIMAGE * RgbBaseImage , const BASEIMAGE * AlphaBaseImage , int TextureFlag ) ;
int __stdcall dx_ReCreateGraphFromGraphImage( const BASEIMAGE * RgbBaseImage , int GrHandle , int TextureFlag ) ;
int __stdcall dx_ReCreateGraphFromGraphImage_2( const BASEIMAGE * RgbBaseImage , const BASEIMAGE * AlphaBaseImage , int GrHandle , int TextureFlag ) ;
int __stdcall dx_CreateDivGraphFromGraphImage( BASEIMAGE * RgbBaseImage , int AllNum , int XNum , int YNum , int SizeX , int SizeY , int * HandleBuf , int TextureFlag ) ;
int __stdcall dx_CreateDivGraphFromGraphImage_2( BASEIMAGE * RgbBaseImage , const BASEIMAGE * AlphaBaseImage , int AllNum , int XNum , int YNum , int SizeX , int SizeY , int * HandleBuf , int TextureFlag ) ;
int __stdcall dx_ReCreateDivGraphFromGraphImage( BASEIMAGE * RgbBaseImage , int AllNum , int XNum , int YNum , int SizeX , int SizeY , const int * HandleBuf , int TextureFlag ) ;
int __stdcall dx_ReCreateDivGraphFromGraphImage_2( BASEIMAGE * RgbBaseImage , const BASEIMAGE * AlphaBaseImage , int AllNum , int XNum , int YNum , int SizeX , int SizeY , const int * HandleBuf , int TextureFlag ) ;
int  __stdcall dx_CreateGraph( int  Width, int  Height, int  Pitch, const void * RGBImage, const void * AlphaImage , int  GrHandle );
int  __stdcall dx_CreateDivGraph( int  Width, int  Height, int  Pitch, const void * RGBImage, int  AllNum, int  XNum, int  YNum, int  SizeX, int  SizeY, int *  HandleBuf, const void * AlphaImage );
int  __stdcall dx_ReCreateGraph( int  Width, int  Height, int  Pitch, const void * RGBImage, int  GrHandle, const void * AlphaImage );
int  __stdcall dx_CreateBlendGraphFromSoftImage( int  SIHandle);
int  __stdcall dx_CreateGraphFromSoftImage( int  SIHandle);
int  __stdcall dx_CreateGraphFromRectSoftImage( int  SIHandle, int  x, int  y, int  SizeX, int  SizeY);
int  __stdcall dx_ReCreateGraphFromSoftImage( int  SIHandle, int  GrHandle);
int  __stdcall dx_ReCreateGraphFromRectSoftImage( int  SIHandle, int  x, int  y, int  SizeX, int  SizeY, int  GrHandle);
int  __stdcall dx_CreateDivGraphFromSoftImage( int  SIHandle, int  AllNum, int  XNum, int  YNum, int  SizeX, int  SizeY, int *  HandleBuf);
int __stdcall dx_CreateGraphFromBaseImage( const BASEIMAGE * BaseImage ) ;
int __stdcall dx_CreateGraphFromRectBaseImage( const BASEIMAGE * BaseImage , int x , int y , int SizeX , int SizeY ) ;
int __stdcall dx_ReCreateGraphFromBaseImage( const BASEIMAGE * BaseImage , int GrHandle ) ;
int __stdcall dx_ReCreateGraphFromRectBaseImage( const BASEIMAGE * BaseImage , int x , int y , int SizeX , int SizeY , int GrHandle ) ;
int __stdcall dx_CreateDivGraphFromBaseImage( BASEIMAGE * BaseImage , int AllNum , int XNum , int YNum , int SizeX , int SizeY , int * HandleBuf ) ;
int  __stdcall dx_ReloadGraph( const char * FileName, int  GrHandle, int  ReverseFlag );
int  __stdcall dx_ReloadDivGraph( const char * FileName, int  AllNum, int  XNum, int  YNum, int  XSize, int  YSize, const int *  HandleBuf, int  ReverseFlag );
int  __stdcall dx_ReloadReverseGraph( const char * FileName, int  GrHandle);
int  __stdcall dx_ReloadReverseDivGraph( const char * FileName, int  AllNum, int  XNum, int  YNum, int  XSize, int  YSize, const int *  HandleBuf);
int  __stdcall dx_SetGraphColorBitDepth( int  ColorBitDepth);
int  __stdcall dx_GetGraphColorBitDepth( void);
int  __stdcall dx_SetCreateGraphColorBitDepth( int  BitDepth);
int  __stdcall dx_GetCreateGraphColorBitDepth( void);
int  __stdcall dx_SetCreateGraphChannelBitDepth( int  BitDepth);
int  __stdcall dx_GetCreateGraphChannelBitDepth( void);
int  __stdcall dx_SetDrawValidGraphCreateFlag( int  Flag);
int  __stdcall dx_GetDrawValidGraphCreateFlag( void);
int  __stdcall dx_SetDrawValidFlagOf3DGraph( int  Flag);
int  __stdcall dx_SetLeftUpColorIsTransColorFlag( int  Flag);
int  __stdcall dx_SetUseBlendGraphCreateFlag( int  Flag);
int  __stdcall dx_GetUseBlendGraphCreateFlag( void);
int  __stdcall dx_SetUseAlphaTestGraphCreateFlag( int  Flag);
int  __stdcall dx_GetUseAlphaTestGraphCreateFlag( void);
int  __stdcall dx_SetUseAlphaTestFlag( int  Flag);
int  __stdcall dx_GetUseAlphaTestFlag( void);
int  __stdcall dx_SetCubeMapTextureCreateFlag( int  Flag);
int  __stdcall dx_GetCubeMapTextureCreateFlag( void);
int  __stdcall dx_SetUseNoBlendModeParam( int  Flag);
int  __stdcall dx_SetDrawValidAlphaChannelGraphCreateFlag( int  Flag);
int  __stdcall dx_GetDrawValidAlphaChannelGraphCreateFlag( void);
int  __stdcall dx_SetDrawValidFloatTypeGraphCreateFlag( int  Flag);
int  __stdcall dx_GetDrawValidFloatTypeGraphCreateFlag( void);
int  __stdcall dx_SetDrawValidGraphCreateZBufferFlag( int  Flag);
int  __stdcall dx_GetDrawValidGraphCreateZBufferFlag( void);
int  __stdcall dx_SetCreateDrawValidGraphZBufferBitDepth( int  BitDepth);
int  __stdcall dx_GetCreateDrawValidGraphZBufferBitDepth( void);
int  __stdcall dx_SetCreateDrawValidGraphChannelNum( int  ChannelNum);
int  __stdcall dx_GetCreateDrawValidGraphChannelNum( void);
int  __stdcall dx_SetCreateDrawValidGraphMultiSample( int  Samples, int  Quality);
int  __stdcall dx_SetDrawValidMultiSample( int  Samples, int  Quality);
int  __stdcall dx_GetMultiSampleQuality( int  Samples);
int  __stdcall dx_SetUseTransColor( int  Flag);
int  __stdcall dx_SetUseTransColorGraphCreateFlag( int  Flag);
int  __stdcall dx_SetUseGraphAlphaChannel( int  Flag);
int  __stdcall dx_GetUseGraphAlphaChannel( void);
int  __stdcall dx_SetUseAlphaChannelGraphCreateFlag( int  Flag);
int  __stdcall dx_GetUseAlphaChannelGraphCreateFlag( void);
int  __stdcall dx_SetUseNotManageTextureFlag( int  Flag);
int  __stdcall dx_GetUseNotManageTextureFlag( void);
int  __stdcall dx_SetTransColor( int  Red, int  Green, int  Blue);
int  __stdcall dx_GetTransColor( int *  Red, int *  Green, int *  Blue);
int  __stdcall dx_SetUseDivGraphFlag( int  Flag);
int  __stdcall dx_SetUseAlphaImageLoadFlag( int  Flag);
int  __stdcall dx_SetUseMaxTextureSize( int  Size);
int  __stdcall dx_SetUseGraphBaseDataBackup( int  Flag);
int  __stdcall dx_GetUseGraphBaseDataBackup( void);
int  __stdcall dx_SetUseSystemMemGraphCreateFlag( int  Flag);
int  __stdcall dx_GetUseSystemMemGraphCreateFlag( void);
const DWORD * __stdcall dx_GetFullColorImage( int GrHandle ) ;
int __stdcall dx_GraphLock( int GrHandle , int * PitchBuf , void * * DataPointBuf , COLORDATA * * ColorDataPP ) ;
int  __stdcall dx_GraphUnLock( int  GrHandle);
int  __stdcall dx_SetUseGraphZBuffer( int  GrHandle, int  UseFlag, int  BitDepth );
int  __stdcall dx_CopyGraphZBufferImage( int  DestGrHandle, int  SrcGrHandle);
int  __stdcall dx_SetDeviceLostDeleteGraphFlag( int  GrHandle, int  DeleteFlag);
int  __stdcall dx_GetGraphSize( int  GrHandle, int *  SizeXBuf, int *  SizeYBuf);
int  __stdcall dx_GetGraphTextureSize( int  GrHandle, int *  SizeXBuf, int *  SizeYBuf);
int  __stdcall dx_GetGraphMipmapCount( int  GrHandle);
int  __stdcall dx_GetGraphFilePath( int  GrHandle, TCHAR *  FilePathBuffer);
const COLORDATA * __stdcall dx_GetTexColorData( int AlphaCh , int AlphaTest , int ColorBitDepth , int DrawValid ) ;
const COLORDATA * __stdcall dx_GetTexColorData_2( const IMAGEFORMATDESC * Format ) ;
const COLORDATA * __stdcall dx_GetTexColorData_3( int FormatIndex ) ;
int  __stdcall dx_GetMaxGraphTextureSize( int *  SizeX, int *  SizeY);
int  __stdcall dx_GetValidRestoreShredPoint( void);
int  __stdcall dx_GetCreateGraphColorData( COLORDATA *  ColorData, IMAGEFORMATDESC *  Format);
int  __stdcall dx_GetGraphPalette( int  GrHandle, int  ColorIndex, int *  Red, int *  Green, int *  Blue);
int  __stdcall dx_GetGraphOriginalPalette( int  GrHandle, int  ColorIndex, int *  Red, int *  Green, int *  Blue);
int  __stdcall dx_SetGraphPalette( int  GrHandle, int  ColorIndex, int  Color);
int  __stdcall dx_ResetGraphPalette( int  GrHandle);
int  __stdcall dx_DrawLine( int  x1, int  y1, int  x2, int  y2, int  Color, int  Thickness );
int  __stdcall dx_DrawBox( int  x1, int  y1, int  x2, int  y2, int  Color, int  FillFlag);
int  __stdcall dx_DrawFillBox( int  x1, int  y1, int  x2, int  y2, int  Color);
int  __stdcall dx_DrawLineBox( int  x1, int  y1, int  x2, int  y2, int  Color);
int  __stdcall dx_DrawCircle( int  x, int  y, int  r, int  Color, int  FillFlag , int  LineThickness );
int  __stdcall dx_DrawOval( int  x, int  y, int  rx, int  ry, int  Color, int  FillFlag, int  LineThickness );
int  __stdcall dx_DrawTriangle( int  x1, int  y1, int  x2, int  y2, int  x3, int  y3, int  Color, int  FillFlag);
int  __stdcall dx_DrawQuadrangle( int  x1, int  y1, int  x2, int  y2, int  x3, int  y3, int  x4, int  y4, int  Color, int  FillFlag);
int  __stdcall dx_DrawRoundRect( int  x1, int  y1, int  x2, int  y2, int  rx, int  ry, int  Color, int  FillFlag);
int  __stdcall dx_DrawPixel( int  x, int  y, int  Color);
int  __stdcall dx_Paint( int  x, int  y, int  FillColor, int  BoundaryColor );
int  __stdcall dx_DrawPixelSet( const POINTDATA *  PointData, int  Num);
int  __stdcall dx_DrawLineSet( const LINEDATA *  LineData, int  Num);
int  __stdcall dx_DrawPixel3D( VECTOR  Pos, int  Color);
int  __stdcall dx_DrawLine3D( VECTOR  Pos1, VECTOR  Pos2, int  Color);
int  __stdcall dx_DrawTriangle3D( VECTOR  Pos1, VECTOR  Pos2, VECTOR  Pos3, int  Color, int  FillFlag);
int  __stdcall dx_DrawCube3D( VECTOR  Pos1, VECTOR  Pos2, int  DifColor, int  SpcColor, int  FillFlag);
int  __stdcall dx_DrawSphere3D( VECTOR  CenterPos, float  r, int  DivNum, int  DifColor, int  SpcColor, int  FillFlag);
int  __stdcall dx_DrawCapsule3D( VECTOR  Pos1, VECTOR  Pos2, float  r, int  DivNum, int  DifColor, int  SpcColor, int  FillFlag);
int  __stdcall dx_DrawCone3D( VECTOR  TopPos, VECTOR  BottomPos, float  r, int  DivNum, int  DifColor, int  SpcColor, int  FillFlag);
int  __stdcall dx_LoadGraphScreen( int  x, int  y, const char * GraphName, int  TransFlag);
int  __stdcall dx_DrawGraph( int  x, int  y, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawExtendGraph( int  x1, int  y1, int  x2, int  y2, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawRotaGraph( int  x, int  y, double  ExRate, double  Angle, int  GrHandle, int  TransFlag, int  TurnFlag );
int  __stdcall dx_DrawRotaGraph2( int  x, int  y, int  cx, int  cy, double  ExtRate, double  Angle, int  GrHandle, int  TransFlag, int  TurnFlag );
int  __stdcall dx_DrawRotaGraph3( int  x, int  y, int  cx, int  cy, double  ExtRateX, double  ExtRateY, double  Angle, int  GrHandle, int  TransFlag, int  TurnFlag );
int  __stdcall dx_DrawModiGraph( int  x1, int  y1, int  x2, int  y2, int  x3, int  y3, int  x4, int  y4, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawTurnGraph( int  x, int  y, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawGraphF( float  xf, float  yf, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawExtendGraphF( float  x1f, float  y1f, float  x2f, float  y2, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawRotaGraphF( float  xf, float  yf, double  ExRate, double  Angle, int  GrHandle, int  TransFlag, int  TurnFlag );
int  __stdcall dx_DrawRotaGraph2F( float  xf, float  yf, float  cxf, float  cyf, double  ExtRate, double  Angle, int  GrHandle, int  TransFlag, int  TurnFlag );
int  __stdcall dx_DrawRotaGraph3F( float  xf, float  yf, float  cxf, float  cyf, double  ExtRateX, double  ExtRateY, double  Angle, int  GrHandle, int  TransFlag, int  TurnFlag );
int  __stdcall dx_DrawModiGraphF( float  x1, float  y1, float  x2, float  y2, float  x3, float  y3, float  x4, float  y4, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawTurnGraphF( float  xf, float  yf, int  GrHandle, int  TransFlag);
int __stdcall dx_DrawChipMap( int Sx , int Sy , int XNum , int YNum , const int * MapData , int ChipTypeNum , int MapDataPitch , const int * ChipGrHandle , int TransFlag ) ;
int __stdcall dx_DrawChipMap_2( int MapWidth , int MapHeight , const int * MapData , int ChipTypeNum , const int * ChipGrHandle , int TransFlag , int MapDrawPointX , int MapDrawPointY , int MapDrawWidth , int MapDrawHeight , int ScreenX , int ScreenY ) ;
int  __stdcall dx_DrawTile( int  x1, int  y1, int  x2, int  y2, int  Tx, int  Ty, double  ExtRate, double  Angle, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawRectGraph( int  DestX, int  DestY, int  SrcX, int  SrcY, int  Width, int  Height, int  GraphHandle, int  TransFlag, int  TurnFlag);
int  __stdcall dx_DrawRectExtendGraph( int  DestX1, int  DestY1, int  DestX2, int  DestY2, int  SrcX, int  SrcY, int  SrcWidth, int  SrcHeight, int  GraphHandle, int  TransFlag);
int  __stdcall dx_DrawRectRotaGraph( int  x, int  y, int  SrcX, int  SrcY, int  Width, int  Height, double  ExtRate, double  Angle, int  GraphHandle, int  TransFlag, int  TurnFlag);
int  __stdcall dx_DrawRectRotaGraph2( int  x, int  y, int  SrcX, int  SrcY, int  Width, int  Height, int  cx, int  cy, double  ExtRate, double  Angle, int  GraphHandle, int  TransFlag, int  TurnFlag);
int  __stdcall dx_DrawRectRotaGraph3( int  x, int  y, int  SrcX, int  SrcY, int  Width, int  Height, int  cx, int  cy, double  ExtRateX, double  ExtRateY, double  Angle, int  GraphHandle, int  TransFlag, int  TurnFlag);
int  __stdcall dx_DrawRectGraphF( float  DestX, float  DestY, int  SrcX, int  SrcY, int  Width, int  Height, int  GraphHandle, int  TransFlag, int  TurnFlag);
int  __stdcall dx_DrawRectExtendGraphF( float  DestX1, float  DestY1, float  DestX2, float  DestY2, int  SrcX, int  SrcY, int  SrcWidth, int  SrcHeight, int  GraphHandle, int  TransFlag);
int  __stdcall dx_DrawRectRotaGraphF( float  x, float  y, int  SrcX, int  SrcY, int  Width, int  Height, double  ExtRate, double  Angle, int  GraphHandle, int  TransFlag, int  TurnFlag);
int  __stdcall dx_DrawRectRotaGraph2F( float  x, float  y, int  SrcX, int  SrcY, int  Width, int  Height, float  cxf, float  cyf, double  ExtRate, double  Angle, int  GraphHandle, int  TransFlag, int  TurnFlag);
int  __stdcall dx_DrawRectRotaGraph3F( float  x, float  y, int  SrcX, int  SrcY, int  Width, int  Height, float  cxf, float  cyf, double  ExtRateX, double  ExtRateY, double  Angle, int  GraphHandle, int  TransFlag, int  TurnFlag);
int  __stdcall dx_DrawBlendGraph( int  x, int  y, int  GrHandle, int  TransFlag, int  BlendGraph, int  BorderParam, int  BorderRange);
int  __stdcall dx_DrawBlendGraphPos( int  x, int  y, int  GrHandle, int  TransFlag, int  bx, int  by, int  BlendGraph, int  BorderParam, int  BorderRange);
int  __stdcall dx_DrawCircleGauge( int  CenterX, int  CenterY, double  Percent, int  GrHandle, double  StartPercent );
int  __stdcall dx_DrawGraphToZBuffer( int  X, int  Y, int  GrHandle, int  WriteZMode);
int  __stdcall dx_DrawTurnGraphToZBuffer( int  x, int  y, int  GrHandle, int  WriteZMode);
int  __stdcall dx_DrawExtendGraphToZBuffer( int  x1, int  y1, int  x2, int  y2, int  GrHandle, int  WriteZMode);
int  __stdcall dx_DrawRotaGraphToZBuffer( int  x, int  y, double  ExRate, double  Angle, int  GrHandle, int  WriteZMode, int  TurnFlag );
int  __stdcall dx_DrawRotaGraph2ToZBuffer( int  x, int  y, int  cx, int  cy, double  ExtRate, double  Angle, int  GrHandle, int  WriteZMode, int  TurnFlag );
int  __stdcall dx_DrawRotaGraph3ToZBuffer( int  x, int  y, int  cx, int  cy, double  ExtRateX, double  ExtRateY, double  Angle, int  GrHandle, int  WriteZMode, int  TurnFlag );
int  __stdcall dx_DrawModiGraphToZBuffer( int  x1, int  y1, int  x2, int  y2, int  x3, int  y3, int  x4, int  y4, int  GrHandle, int  WriteZMode);
int  __stdcall dx_DrawBoxToZBuffer( int  x1, int  y1, int  x2, int  y2, int  FillFlag, int  WriteZMode);
int  __stdcall dx_DrawCircleToZBuffer( int  x, int  y, int  r, int  FillFlag, int  WriteZMode);
int  __stdcall dx_DrawTriangleToZBuffer( int  x1, int  y1, int  x2, int  y2, int  x3, int  y3, int  FillFlag, int  WriteZMode);
int  __stdcall dx_DrawQuadrangleToZBuffer( int  x1, int  y1, int  x2, int  y2, int  x3, int  y3, int  x4, int  y4, int  FillFlag, int  WriteZMode);
int  __stdcall dx_DrawRoundRectToZBuffer( int  x1, int  y1, int  x2, int  y2, int  rx, int  ry, int  FillFlag, int  WriteZMode);
int  __stdcall dx_DrawPolygon( const VERTEX *  Vertex, int  PolygonNum, int  GrHandle, int  TransFlag, int  UVScaling );
int  __stdcall dx_DrawPolygon2D( const VERTEX2D *  Vertex, int  PolygonNum, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPolygon3D( const VERTEX3D *  Vertex, int  PolygonNum, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPolygonIndexed2D( const VERTEX2D *  Vertex, int  VertexNum, const unsigned short *  Indices, int  PolygonNum, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPolygonIndexed3D( const VERTEX3D *  Vertex, int  VertexNum, const unsigned short *  Indices, int  PolygonNum, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPolygonIndexed3DBase( const VERTEX_3D *  Vertex, int  VertexNum, const unsigned short *  Indices, int  IndexNum, int  PrimitiveType, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPolygon3DBase( const VERTEX_3D *  Vertex, int  VertexNum, int  PrimitiveType, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPolygon3D_2( const VERTEX_3D *  Vertex, int  PolygonNum, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPolygonBase( const VERTEX *  Vertex, int  VertexNum, int  PrimitiveType, int  GrHandle, int  TransFlag, int  UVScaling );
int  __stdcall dx_DrawPrimitive2D( const VERTEX2D *  Vertex, int  VertexNum, int  PrimitiveType, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPrimitive3D( const VERTEX3D *  Vertex, int  VertexNum, int  PrimitiveType, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPrimitiveIndexed2D( const VERTEX2D *  Vertex, int  VertexNum, const unsigned short *  Indices, int  IndexNum, int  PrimitiveType, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPrimitiveIndexed3D( const VERTEX3D *  Vertex, int  VertexNum, const unsigned short *  Indices, int  IndexNum, int  PrimitiveType, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPolygon3D_UseVertexBuffer( int  VertexBufHandle, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPrimitive3D_UseVertexBuffer( int  VertexBufHandle, int  PrimitiveType, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPrimitive3D_UseVertexBuffer2( int  VertexBufHandle, int  PrimitiveType, int  StartVertex, int  UseVertexNum, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPolygonIndexed3D_UseVertexBuffer( int  VertexBufHandle, int  IndexBufHandle, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPrimitiveIndexed3D_UseVertexBuffer( int  VertexBufHandle, int  IndexBufHandle, int  PrimitiveType, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawPrimitiveIndexed3D_UseVertexBuffer2( int  VertexBufHandle, int  IndexBufHandle, int  PrimitiveType, int  BaseVertex, int  StartVertex, int  UseVertexNum, int  StartIndex, int  UseIndexNum, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawGraph3D( float  x, float  y, float  z, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawExtendGraph3D( float  x, float  y, float  z, double  ExRateX, double  ExRateY, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawRotaGraph3D( float  x, float  y, float  z, double  ExRate, double  Angle, int  GrHandle, int  TransFlag, int  TurnFlag );
int  __stdcall dx_DrawRota2Graph3D( float  x, float  y, float  z, float  cx, float  cy, double  ExtRateX, double  ExtRateY, double  Angle, int  GrHandle, int  TransFlag, int  TurnFlag );
int  __stdcall dx_DrawModiBillboard3D( VECTOR  Pos, float  x1, float  y1, float  x2, float  y2, float  x3, float  y3, float  x4, float  y4, int  GrHandle, int  TransFlag);
int  __stdcall dx_DrawBillboard3D( VECTOR  Pos, float  cx, float  cy, float  Size, float  Angle, int  GrHandle, int  TransFlag, int  TurnFlag );
int  __stdcall dx_SetDrawMode( int  DrawMode);
int  __stdcall dx_GetDrawMode( void);
int  __stdcall dx_SetDrawBlendMode( int  BlendMode, int  BlendParam);
int  __stdcall dx_GetDrawBlendMode( int *  BlendMode, int *  BlendParam);
int  __stdcall dx_SetDrawAlphaTest( int  TestMode, int  TestParam);
int  __stdcall dx_SetBlendGraph( int  BlendGraph, int  BorderParam, int  BorderRange);
int  __stdcall dx_SetBlendGraphPosition( int  x, int  y);
int  __stdcall dx_SetDrawBright( int  RedBright, int  GreenBright, int  BlueBright);
int  __stdcall dx_GetDrawBright( int *  Red, int *  Green, int *  Blue);
int  __stdcall dx_SetIgnoreDrawGraphColor( int  EnableFlag);
int  __stdcall dx_SetMaxAnisotropy( int  MaxAnisotropy);
int  __stdcall dx_SetUseZBufferFlag( int  Flag);
int  __stdcall dx_SetWriteZBufferFlag( int  Flag);
int  __stdcall dx_SetZBufferCmpType( int  CmpType);
int  __stdcall dx_SetZBias( int  Bias);
int  __stdcall dx_SetUseZBuffer3D( int  Flag);
int  __stdcall dx_SetWriteZBuffer3D( int  Flag);
int  __stdcall dx_SetZBufferCmpType3D( int  CmpType);
int  __stdcall dx_SetZBias3D( int  Bias);
int  __stdcall dx_SetDrawZ( float  Z);
int  __stdcall dx_SetDrawArea( int  x1, int  y1, int  x2, int  y2);
int  __stdcall dx_GetDrawArea( RECT *  Rect);
int  __stdcall dx_SetDrawAreaFull( void);
int  __stdcall dx_SetDraw3DScale( float  Scale);
int __stdcall dx_SetRestoreShredPoint( void ( *ShredPoint )( void ) ) ;
int __stdcall dx_SetRestoreGraphCallback( void ( *Callback )( void ) ) ;
int  __stdcall dx_RunRestoreShred( void);
int __stdcall dx_SetGraphicsDeviceRestoreCallbackFunction( void ( *Callback )( void * Data ) , void * CallbackData ) ;
int __stdcall dx_SetGraphicsDeviceLostCallbackFunction( void ( *Callback )( void * Data ) , void * CallbackData ) ;
int  __stdcall dx_SetTransformToWorld( const MATRIX *  Matrix);
int  __stdcall dx_GetTransformToWorldMatrix( MATRIX *  MatBuf);
int  __stdcall dx_SetTransformToView( const MATRIX *  Matrix);
int  __stdcall dx_GetTransformToViewMatrix( MATRIX *  MatBuf);
int  __stdcall dx_SetTransformToProjection( const MATRIX *  Matrix);
int  __stdcall dx_GetTransformToProjectionMatrix( MATRIX *  MatBuf);
int  __stdcall dx_SetTransformToViewport( const MATRIX *  Matrix);
int  __stdcall dx_GetTransformToViewportMatrix( MATRIX *  MatBuf);
int  __stdcall dx_GetTransformToAPIViewportMatrix( MATRIX *  MatBuf);
int  __stdcall dx_SetDefTransformMatrix( void);
int  __stdcall dx_GetTransformPosition( VECTOR *  LocalPos, float *  x, float *  y);
float  __stdcall dx_GetBillboardPixelSize( VECTOR  WorldPos, float  WorldSize);
VECTOR  __stdcall dx_ConvWorldPosToViewPos( VECTOR  WorldPos);
VECTOR  __stdcall dx_ConvWorldPosToScreenPos( VECTOR  WorldPos);
FLOAT4  __stdcall dx_ConvWorldPosToScreenPosPlusW( VECTOR  WorldPos);
VECTOR  __stdcall dx_ConvScreenPosToWorldPos( VECTOR  ScreenPos);
VECTOR  __stdcall dx_ConvScreenPosToWorldPos_ZLinear( VECTOR  ScreenPos);
int  __stdcall dx_SetUseCullingFlag( int  Flag);
int  __stdcall dx_SetUseBackCulling( int  Flag);
int  __stdcall dx_SetTextureAddressMode( int  Mode, int  Stage );
int  __stdcall dx_SetTextureAddressModeUV( int  ModeU, int  ModeV, int  Stage );
int  __stdcall dx_SetTextureAddressTransform( float  TransU, float  TransV, float  ScaleU, float  ScaleV, float  RotCenterU, float  RotCenterV, float  Rotate);
int  __stdcall dx_SetTextureAddressTransformMatrix( MATRIX  Matrix);
int  __stdcall dx_ResetTextureAddressTransform( void);
int  __stdcall dx_SetFogEnable( int  Flag);
int  __stdcall dx_SetFogMode( int  Mode);
int  __stdcall dx_SetFogColor( int  r, int  g, int  b);
int  __stdcall dx_SetFogStartEnd( float  start, float  end);
int  __stdcall dx_SetFogDensity( float  density);
int  __stdcall dx_GetPixel( int  x, int  y);
int  __stdcall dx_SetBackgroundColor( int  Red, int  Green, int  Blue);
int  __stdcall dx_GetDrawScreenGraph( int  x1, int  y1, int  x2, int  y2, int  GrHandle, int  UseClientFlag );
int  __stdcall dx_BltDrawValidGraph( int  TargetDrawValidGrHandle, int  x1, int  y1, int  x2, int  y2, int  DestX, int  DestY, int  DestGrHandle);
int  __stdcall dx_ScreenFlip( void);
int  __stdcall dx_ScreenCopy( void);
int  __stdcall dx_WaitVSync( int  SyncNum);
int __stdcall dx_ClearDrawScreen( const RECT * ClearRect ) ;
int __stdcall dx_ClearDrawScreenZBuffer( const RECT * ClearRect ) ;
int  __stdcall dx_ClsDrawScreen( void);
int  __stdcall dx_SetDrawScreen( int  DrawScreen);
int  __stdcall dx_GetDrawScreen( void);
int  __stdcall dx_GetActiveGraph( void);
int  __stdcall dx_SetDrawZBuffer( int  DrawScreen);
int  __stdcall dx_BltBackScreenToWindow( HWND  Window, int  ClientX, int  ClientY);
int  __stdcall dx_BltRectBackScreenToWindow( HWND  Window, RECT  BackScreenRect, RECT  WindowClientRect);
int  __stdcall dx_SetScreenFlipTargetWindow( HWND  TargetWindow);
int  __stdcall dx_SetGraphMode( int  ScreenSizeX, int  ScreenSizeY, int  ColorBitDepth, int  RefreshRate );
int  __stdcall dx_SetFullScreenResolutionMode( int  ResolutionMode);
int  __stdcall dx_SetFullScreenScalingMode( int  ScalingMode);
int  __stdcall dx_SetEmulation320x240( int  Flag);
int  __stdcall dx_SetZBufferSize( int  ZBufferSizeX, int  ZBufferSizeY);
int  __stdcall dx_SetZBufferBitDepth( int  BitDepth);
int  __stdcall dx_SetWaitVSyncFlag( int  Flag);
int  __stdcall dx_GetWaitVSyncFlag( void);
int  __stdcall dx_SetFullSceneAntiAliasingMode( int  Samples, int  Quality);
int  __stdcall dx_SetGraphDisplayArea( int  x1, int  y1, int  x2, int  y2);
int  __stdcall dx_SetChangeScreenModeGraphicsSystemResetFlag( int  Flag);
int  __stdcall dx_GetScreenState( int *  SizeX, int *  SizeY, int *  ColorBitDepth);
int  __stdcall dx_GetDrawScreenSize( int *  XBuf, int *  YBuf);
int  __stdcall dx_GetScreenBitDepth( void);
int  __stdcall dx_GetColorBitDepth( void);
int  __stdcall dx_GetChangeDisplayFlag( void);
int  __stdcall dx_GetVideoMemorySize( int *  AllSize, int *  FreeSize);
int  __stdcall dx_GetRefreshRate( void);
int  __stdcall dx_GetDisplayModeNum( void);
DISPLAYMODEDATA  __stdcall dx_GetDisplayMode( int  ModeIndex);
int  __stdcall dx_GetDisplayMaxResolution( int *  SizeX, int *  SizeY);
const COLORDATA * __stdcall dx_GetDispColorData( void );
int  __stdcall dx_GetMultiDrawScreenNum( void);
int  __stdcall dx_SetDisplayRefreshRate( int  RefreshRate);
int  __stdcall dx_SetUseNormalDrawShader( int  Flag);
int  __stdcall dx_SetUseSoftwareRenderModeFlag( int  Flag);
int  __stdcall dx_SetNotUse3DFlag( int  Flag);
int  __stdcall dx_SetUse3DFlag( int  Flag);
int  __stdcall dx_GetUse3DFlag( void);
int  __stdcall dx_SetScreenMemToVramFlag( int  Flag);
int  __stdcall dx_GetScreenMemToSystemMemFlag( void);
int  __stdcall dx_SetWindowDrawRect( const RECT *  DrawRect);
int  __stdcall dx_RestoreGraphSystem( void);
int  __stdcall dx_SetUseHardwareVertexProcessing( int  Flag);
int  __stdcall dx_SetUsePixelLighting( int  Flag);
int  __stdcall dx_SetUseOldDrawModiGraphCodeFlag( int  Flag);
int  __stdcall dx_SetUseVramFlag( int  Flag);
int  __stdcall dx_GetUseVramFlag( void);
int  __stdcall dx_SetBasicBlendFlag( int  Flag);
int  __stdcall dx_SetUseBasicGraphDraw3DDeviceMethodFlag( int  Flag);
int  __stdcall dx_SetMultiThreadFlag( int  Flag);
int  __stdcall dx_SetUseDirectDrawDeviceIndex( int  Index);
int  __stdcall dx_SetAeroDisableFlag( int  Flag);
int  __stdcall dx_SetUseDirect3D9Ex( int  Flag);
int  __stdcall dx_SetUseDirectDrawFlag( int  Flag);
int  __stdcall dx_SetUseGDIFlag( int  Flag);
int  __stdcall dx_GetUseGDIFlag( void);
int __stdcall dx_SetDDrawUseGuid( const GUID * Guid ) ;
const void * __stdcall dx_GetUseDDrawObj( void );
const GUID * __stdcall dx_GetDirectDrawDeviceGUID( int Number ) ;
int  __stdcall dx_GetDirectDrawDeviceDescription( int  Number, char *  StringBuffer);
int  __stdcall dx_GetDirectDrawDeviceNum( void);
//---------------------------------------------------
//const D_IDirect3DDevice9 * __stdcall dx_GetUseDirect3DDevice9( void );
const void * __stdcall dx_GetUseDirect3DDevice9( void );
//const D_IDirect3DSurface9 * __stdcall dx_GetUseDirect3D9BackBufferSurface( void );
const void  * __stdcall dx_GetUseDirect3D9BackBufferSurface( void );
//---------------------------------------------------
int  __stdcall dx_RefreshDxLibDirect3DSetting( void);
int  __stdcall dx_RenderVertex( void);
int  __stdcall dx_SaveDrawScreen( int  x1, int  y1, int  x2, int  y2, const char * FileName, int  SaveType , int  Jpeg_Quality , int  Jpeg_Sample2x1 , int  Png_CompressionLevel );
int  __stdcall dx_SaveDrawScreenToBMP( int  x1, int  y1, int  x2, int  y2, const char * FileName);
int  __stdcall dx_SaveDrawScreenToJPEG( int  x1, int  y1, int  x2, int  y2, const char * FileName, int  Quality , int  Sample2x1 );
int  __stdcall dx_SaveDrawScreenToPNG( int  x1, int  y1, int  x2, int  y2, const char * FileName, int  CompressionLevel );
int  __stdcall dx_CreateVertexBuffer( int  VertexNum, int  VertexType);
int  __stdcall dx_DeleteVertexBuffer( int  VertexBufHandle);
int  __stdcall dx_InitVertexBuffer( void);
int  __stdcall dx_SetVertexBufferData( int  SetIndex, const void * VertexData, int  VertexNum, int  VertexBufHandle);
int  __stdcall dx_CreateIndexBuffer( int  IndexNum, int  IndexType);
int  __stdcall dx_DeleteIndexBuffer( int  IndexBufHandle);
int  __stdcall dx_InitIndexBuffer( void);
int  __stdcall dx_SetIndexBufferData( int  SetIndex, const void * IndexData, int  IndexNum, int  IndexBufHandle);
int  __stdcall dx_GetMaxPrimitiveCount( void);
int  __stdcall dx_GetMaxVertexIndex( void);
int  __stdcall dx_GetValidShaderVersion( void);
int  __stdcall dx_LoadVertexShader( const char * FileName);
int  __stdcall dx_LoadPixelShader( const char * FileName);
int  __stdcall dx_LoadVertexShaderFromMem( const void * ImageAddress, int  ImageSize);
int  __stdcall dx_LoadPixelShaderFromMem( const void * ImageAddress, int  ImageSize);
int  __stdcall dx_DeleteShader( int  ShaderHandle);
int  __stdcall dx_InitShader( void);
int  __stdcall dx_GetConstIndexToShader( const char * ConstantName, int  ShaderHandle);
int  __stdcall dx_GetConstCountToShader( const char * ConstantName, int  ShaderHandle);
const FLOAT4 *  __stdcall dx_GetConstDefaultParamFToShader( const char * ConstantName, int  ShaderHandle);
int  __stdcall dx_SetVSConstSF( int  ConstantIndex, float  Param);
int  __stdcall dx_SetVSConstF( int  ConstantIndex, FLOAT4  Param);
int  __stdcall dx_SetVSConstFMtx( int  ConstantIndex, MATRIX  Param);
int  __stdcall dx_SetVSConstFMtxT( int  ConstantIndex, MATRIX  Param);
int  __stdcall dx_SetVSConstSI( int  ConstantIndex, int  Param);
int  __stdcall dx_SetVSConstI( int  ConstantIndex, INT4  Param);
int  __stdcall dx_SetVSConstB( int  ConstantIndex, BOOL  Param);
int  __stdcall dx_SetVSConstSFArray( int  ConstantIndex, const float *  ParamArray, int  ParamNum);
int  __stdcall dx_SetVSConstFArray( int  ConstantIndex, const FLOAT4 *  ParamArray, int  ParamNum);
int  __stdcall dx_SetVSConstFMtxArray( int  ConstantIndex, const MATRIX *  ParamArray, int  ParamNum);
int  __stdcall dx_SetVSConstFMtxTArray( int  ConstantIndex, const MATRIX *  ParamArray, int  ParamNum);
int  __stdcall dx_SetVSConstSIArray( int  ConstantIndex, const int *  ParamArray, int  ParamNum);
int  __stdcall dx_SetVSConstIArray( int  ConstantIndex, const INT4 *  ParamArray, int  ParamNum);
int  __stdcall dx_SetVSConstBArray( int  ConstantIndex, const BOOL *  ParamArray, int  ParamNum);
int  __stdcall dx_ResetVSConstF( int  ConstantIndex, int  ParamNum);
int  __stdcall dx_ResetVSConstI( int  ConstantIndex, int  ParamNum);
int  __stdcall dx_ResetVSConstB( int  ConstantIndex, int  ParamNum);
int  __stdcall dx_SetPSConstSF( int  ConstantIndex, float  Param);
int  __stdcall dx_SetPSConstF( int  ConstantIndex, FLOAT4  Param);
int  __stdcall dx_SetPSConstFMtx( int  ConstantIndex, MATRIX  Param);
int  __stdcall dx_SetPSConstFMtxT( int  ConstantIndex, MATRIX  Param);
int  __stdcall dx_SetPSConstSI( int  ConstantIndex, int  Param);
int  __stdcall dx_SetPSConstI( int  ConstantIndex, INT4  Param);
int  __stdcall dx_SetPSConstB( int  ConstantIndex, BOOL  Param);
int  __stdcall dx_SetPSConstSFArray( int  ConstantIndex, const float *  ParamArray, int  ParamNum);
int  __stdcall dx_SetPSConstFArray( int  ConstantIndex, const FLOAT4 *  ParamArray, int  ParamNum);
int  __stdcall dx_SetPSConstFMtxArray( int  ConstantIndex, const MATRIX *  ParamArray, int  ParamNum);
int  __stdcall dx_SetPSConstFMtxTArray( int  ConstantIndex, const MATRIX *  ParamArray, int  ParamNum);
int  __stdcall dx_SetPSConstSIArray( int  ConstantIndex, const int *  ParamArray, int  ParamNum);
int  __stdcall dx_SetPSConstIArray( int  ConstantIndex, const INT4 *  ParamArray, int  ParamNum);
int  __stdcall dx_SetPSConstBArray( int  ConstantIndex, const BOOL *  ParamArray, int  ParamNum);
int  __stdcall dx_ResetPSConstF( int  ConstantIndex, int  ParamNum);
int  __stdcall dx_ResetPSConstI( int  ConstantIndex, int  ParamNum);
int  __stdcall dx_ResetPSConstB( int  ConstantIndex, int  ParamNum);
int  __stdcall dx_SetRenderTargetToShader( int  TargetIndex, int  DrawScreen, int  SurfaceIndex );
int  __stdcall dx_SetUseTextureToShader( int  StageIndex, int  GraphHandle);
int  __stdcall dx_SetUseVertexShader( int  ShaderHandle);
int  __stdcall dx_SetUsePixelShader( int  ShaderHandle);
int  __stdcall dx_CalcPolygonBinormalAndTangentsToShader( VERTEX3DSHADER *  Vertex, int  PolygonNum);
int  __stdcall dx_CalcPolygonIndexedBinormalAndTangentsToShader( VERTEX3DSHADER *  Vertex, int  VertexNum, const unsigned short *  Indices, int  PolygonNum);
int  __stdcall dx_DrawPolygon2DToShader( const VERTEX2DSHADER *  Vertex, int  PolygonNum);
int  __stdcall dx_DrawPolygon3DToShader( const VERTEX3DSHADER *  Vertex, int  PolygonNum);
int  __stdcall dx_DrawPolygonIndexed2DToShader( const VERTEX2DSHADER *  Vertex, int  VertexNum, const unsigned short *  Indices, int  PolygonNum);
int  __stdcall dx_DrawPolygonIndexed3DToShader( const VERTEX3DSHADER *  Vertex, int  VertexNum, const unsigned short *  Indices, int  PolygonNum);
int  __stdcall dx_DrawPrimitive2DToShader( const VERTEX2DSHADER *  Vertex, int  VertexNum, int  PrimitiveType);
int  __stdcall dx_DrawPrimitive3DToShader( const VERTEX3DSHADER *  Vertex, int  VertexNum, int  PrimitiveType);
int  __stdcall dx_DrawPrimitiveIndexed2DToShader( const VERTEX2DSHADER *  Vertex, int  VertexNum, const unsigned short *  Indices, int  IndexNum, int  PrimitiveType);
int  __stdcall dx_DrawPrimitiveIndexed3DToShader( const VERTEX3DSHADER *  Vertex, int  VertexNum, const unsigned short *  Indices, int  IndexNum, int  PrimitiveType);
int  __stdcall dx_DrawPolygon3DToShader_UseVertexBuffer( int  VertexBufHandle);
int  __stdcall dx_DrawPolygonIndexed3DToShader_UseVertexBuffer( int  VertexBufHandle, int  IndexBufHandle);
int  __stdcall dx_DrawPrimitive3DToShader_UseVertexBuffer( int  VertexBufHandle, int  PrimitiveType);
int  __stdcall dx_DrawPrimitive3DToShader_UseVertexBuffer2( int  VertexBufHandle, int  PrimitiveType, int  StartVertex, int  UseVertexNum);
int  __stdcall dx_DrawPrimitiveIndexed3DToShader_UseVertexBuffer( int  VertexBufHandle, int  IndexBufHandle, int  PrimitiveType);
int  __stdcall dx_DrawPrimitiveIndexed3DToShader_UseVertexBuffer2( int  VertexBufHandle, int  IndexBufHandle, int  PrimitiveType, int  BaseVertex, int  StartVertex, int  UseVertexNum, int  StartIndex, int  UseIndexNum);
int  __stdcall dx_PlayMovie( const char * FileName, int  ExRate, int  PlayType);
int  __stdcall dx_OpenMovieToGraph( const char * FileName, int  FullColor );
int  __stdcall dx_PlayMovieToGraph( int  GraphHandle, int  PlayType , int  SysPlay );
int  __stdcall dx_PauseMovieToGraph( int  GraphHandle, int  SysPause );
int  __stdcall dx_AddMovieFrameToGraph( int  GraphHandle, unsigned int  FrameNum);
int  __stdcall dx_SeekMovieToGraph( int  GraphHandle, int  Time);
int  __stdcall dx_SetPlaySpeedRateMovieToGraph( int  GraphHandle, double  SpeedRate);
int  __stdcall dx_GetMovieStateToGraph( int  GraphHandle);
int  __stdcall dx_SetMovieVolumeToGraph( int  Volume, int  GraphHandle);
int  __stdcall dx_ChangeMovieVolumeToGraph( int  Volume, int  GraphHandle);
const BASEIMAGE * __stdcall dx_GetMovieBaseImageToGraph( int GraphHandle , int * ImageUpdateFlag ) ;
int  __stdcall dx_GetMovieTotalFrameToGraph( int  GraphHandle);
int  __stdcall dx_TellMovieToGraph( int  GraphHandle);
int  __stdcall dx_TellMovieToGraphToFrame( int  GraphHandle);
int  __stdcall dx_SeekMovieToGraphToFrame( int  GraphHandle, int  Frame);
LONGLONG  __stdcall dx_GetOneFrameTimeMovieToGraph( int  GraphHandle);
int  __stdcall dx_GetLastUpdateTimeMovieToGraph( int  GraphHandle);
int  __stdcall dx_SetMovieRightImageAlphaFlag( int  Flag);
int  __stdcall dx_SetMovieColorA8R8G8B8Flag( int  Flag);
int  __stdcall dx_SetMovieUseYUVFormatSurfaceFlag( int  Flag);
int  __stdcall dx_SetCameraNearFar( float  Near, float  Far);
int  __stdcall dx_SetCameraPositionAndTarget_UpVecY( VECTOR  Position, VECTOR  Target);
int  __stdcall dx_SetCameraPositionAndTargetAndUpVec( VECTOR  Position, VECTOR  TargetPosition, VECTOR  UpVector);
int  __stdcall dx_SetCameraPositionAndAngle( VECTOR  Position, float  VRotate, float  HRotate, float  TRotate);
int  __stdcall dx_SetCameraViewMatrix( MATRIX  ViewMatrix);
int  __stdcall dx_SetCameraScreenCenter( float  x, float  y);
int  __stdcall dx_SetupCamera_Perspective( float  Fov);
int  __stdcall dx_SetupCamera_Ortho( float  Size);
int  __stdcall dx_SetupCamera_ProjectionMatrix( MATRIX  ProjectionMatrix);
int  __stdcall dx_SetCameraDotAspect( float  DotAspect);
int  __stdcall dx_CheckCameraViewClip( VECTOR  CheckPos);
int  __stdcall dx_CheckCameraViewClip_Dir( VECTOR  CheckPos);
int  __stdcall dx_CheckCameraViewClip_Box( VECTOR  BoxPos1, VECTOR  BoxPos2);
float  __stdcall dx_GetCameraNear( void);
float  __stdcall dx_GetCameraFar( void);
VECTOR  __stdcall dx_GetCameraPosition( void);
VECTOR  __stdcall dx_GetCameraTarget( void);
VECTOR  __stdcall dx_GetCameraUpVector( void);
float  __stdcall dx_GetCameraAngleHRotate( void);
float  __stdcall dx_GetCameraAngleVRotate( void);
float  __stdcall dx_GetCameraAngleTRotate( void);
MATRIX  __stdcall dx_GetCameraViewMatrix( void);
MATRIX  __stdcall dx_GetCameraBillboardMatrix( void);
float  __stdcall dx_GetCameraFov( void);
float  __stdcall dx_GetCameraSize( void);
MATRIX  __stdcall dx_GetCameraProjectionMatrix( void);
float  __stdcall dx_GetCameraDotAspect( void);
MATRIX  __stdcall dx_GetCameraViewportMatrix( void);
MATRIX  __stdcall dx_GetCameraAPIViewportMatrix( void);
int  __stdcall dx_SetUseLighting( int  Flag);
int  __stdcall dx_SetMaterialUseVertDifColor( int  UseFlag);
int  __stdcall dx_SetMaterialUseVertSpcColor( int  UseFlag);
int  __stdcall dx_SetMaterialParam( MATERIALPARAM  Material);
int  __stdcall dx_SetUseSpecular( int  UseFlag);
int  __stdcall dx_SetGlobalAmbientLight( COLOR_F  Color);
int  __stdcall dx_ChangeLightTypeDir( VECTOR  Direction);
int  __stdcall dx_ChangeLightTypeSpot( VECTOR  Position, VECTOR  Direction, float  OutAngle, float  InAngle, float  Range, float  Atten0, float  Atten1, float  Atten2);
int  __stdcall dx_ChangeLightTypePoint( VECTOR  Position, float  Range, float  Atten0, float  Atten1, float  Atten2);
int  __stdcall dx_GetLightType( void);
int  __stdcall dx_SetLightEnable( int  EnableFlag);
int  __stdcall dx_GetLightEnable( void);
int  __stdcall dx_SetLightDifColor( COLOR_F  Color);
COLOR_F  __stdcall dx_GetLightDifColor( void);
int  __stdcall dx_SetLightSpcColor( COLOR_F  Color);
COLOR_F  __stdcall dx_GetLightSpcColor( void);
int  __stdcall dx_SetLightAmbColor( COLOR_F  Color);
COLOR_F  __stdcall dx_GetLightAmbColor( void);
int  __stdcall dx_SetLightDirection( VECTOR  Direction);
VECTOR  __stdcall dx_GetLightDirection( void);
int  __stdcall dx_SetLightPosition( VECTOR  Position);
VECTOR  __stdcall dx_GetLightPosition( void);
int  __stdcall dx_SetLightRangeAtten( float  Range, float  Atten0, float  Atten1, float  Atten2);
int  __stdcall dx_GetLightRangeAtten( float *  Range, float *  Atten0, float *  Atten1, float *  Atten2);
int  __stdcall dx_SetLightAngle( float  OutAngle, float  InAngle);
int  __stdcall dx_GetLightAngle( float *  OutAngle, float *  InAngle);
int  __stdcall dx_SetLightUseShadowMap( int  SmSlotIndex, int  UseFlag);
int  __stdcall dx_CreateDirLightHandle( VECTOR  Direction);
int  __stdcall dx_CreateSpotLightHandle( VECTOR  Position, VECTOR  Direction, float  OutAngle, float  InAngle, float  Range, float  Atten0, float  Atten1, float  Atten2);
int  __stdcall dx_CreatePointLightHandle( VECTOR  Position, float  Range, float  Atten0, float  Atten1, float  Atten2);
int  __stdcall dx_DeleteLightHandle( int  LHandle);
int  __stdcall dx_DeleteLightHandleAll( void);
int  __stdcall dx_SetLightTypeHandle( int  LHandle, int  LightType);
int  __stdcall dx_SetLightEnableHandle( int  LHandle, int  EnableFlag);
int  __stdcall dx_SetLightDifColorHandle( int  LHandle, COLOR_F  Color);
int  __stdcall dx_SetLightSpcColorHandle( int  LHandle, COLOR_F  Color);
int  __stdcall dx_SetLightAmbColorHandle( int  LHandle, COLOR_F  Color);
int  __stdcall dx_SetLightDirectionHandle( int  LHandle, VECTOR  Direction);
int  __stdcall dx_SetLightPositionHandle( int  LHandle, VECTOR  Position);
int  __stdcall dx_SetLightRangeAttenHandle( int  LHandle, float  Range, float  Atten0, float  Atten1, float  Atten2);
int  __stdcall dx_SetLightAngleHandle( int  LHandle, float  OutAngle, float  InAngle);
int  __stdcall dx_SetLightUseShadowMapHandle( int  LHandle, int  SmSlotIndex, int  UseFlag);
int  __stdcall dx_GetLightTypeHandle( int  LHandle);
int  __stdcall dx_GetLightEnableHandle( int  LHandle);
COLOR_F  __stdcall dx_GetLightDifColorHandle( int  LHandle);
COLOR_F  __stdcall dx_GetLightSpcColorHandle( int  LHandle);
COLOR_F  __stdcall dx_GetLightAmbColorHandle( int  LHandle);
VECTOR  __stdcall dx_GetLightDirectionHandle( int  LHandle);
VECTOR  __stdcall dx_GetLightPositionHandle( int  LHandle);
int  __stdcall dx_GetLightRangeAttenHandle( int  LHandle, float *  Range, float *  Atten0, float *  Atten1, float *  Atten2);
int  __stdcall dx_GetLightAngleHandle( int  LHandle, float *  OutAngle, float *  InAngle);
int  __stdcall dx_GetEnableLightHandleNum( void);
int  __stdcall dx_GetEnableLightHandle( int  Index);
int  __stdcall dx_GetTexFormatIndex( const IMAGEFORMATDESC *  Format);
int  __stdcall dx_ColorKaiseki( const void * PixelData, COLORDATA *  ColorData);
//---------------------------------------------------
int __stdcall dx_CreatePixelFormat( 
void * PixelFormatBuf , //D_DDPIXELFORMAT * PixelFormatBuf , 
int ColorBitDepth , 
DWORD RedMask , 
DWORD GreenMask , 
DWORD BlueMask , 
DWORD AlphaMask ) ;
//---------------------------------------------------
int  __stdcall dx_CreateMaskScreen( void);
int  __stdcall dx_DeleteMaskScreen( void);
int  __stdcall dx_DrawMaskToDirectData( int  x, int  y, int  Width, int  Height, const void * MaskData, int  TransMode);
int  __stdcall dx_DrawFillMaskToDirectData( int  x1, int  y1, int  x2, int  y2, int  Width, int  Height, const void * MaskData);
int  __stdcall dx_SetUseMaskScreenFlag( int  ValidFlag);
int  __stdcall dx_GetUseMaskScreenFlag( void);
int  __stdcall dx_FillMaskScreen( int  Flag);
int  __stdcall dx_InitMask( void);
int  __stdcall dx_MakeMask( int  Width, int  Height);
int  __stdcall dx_GetMaskSize( int *  WidthBuf, int *  HeightBuf, int  MaskHandle);
int  __stdcall dx_SetDataToMask( int  Width, int  Height, const void * MaskData, int  MaskHandle);
int  __stdcall dx_DeleteMask( int  MaskHandle);
int __stdcall dx_BmpBltToMask( HBITMAP Bmp , int BmpPointX , int BmpPointY , int MaskHandle ) ;
int __stdcall dx_GraphImageBltToMask( const BASEIMAGE * BaseImage , int ImageX , int ImageY , int MaskHandle ) ;
int  __stdcall dx_LoadMask( const char * FileName);
int  __stdcall dx_LoadDivMask( const char * FileName, int  AllNum, int  XNum, int  YNum, int  XSize, int  YSize, int *  HandleBuf);
int  __stdcall dx_CreateMaskFromMem( const void * FileImage, int  FileImageSize);
int  __stdcall dx_CreateDivMaskFromMem( const void * FileImage, int  FileImageSize, int  AllNum, int  XNum, int  YNum, int  XSize, int  YSize, int *  HandleBuf);
int  __stdcall dx_DrawMask( int  x, int  y, int  MaskHandle, int  TransMode);
int  __stdcall dx_DrawStringMask( int  x, int  y, int  Flag, const char * String);
int  __stdcall dx_DrawStringMaskToHandle( int  x, int  y, int  Flag, int  FontHandle, const char * String);
int  __stdcall dx_DrawFillMask( int  x1, int  y1, int  x2, int  y2, int  MaskHandle);
int  __stdcall dx_SetMaskReverseEffectFlag( int  ReverseFlag);
int  __stdcall dx_GetMaskScreenData( int  x1, int  y1, int  x2, int  y2, int  MaskHandle);
int  __stdcall dx_GetMaskUseFlag( void);
int  __stdcall dx_EnumFontName( TCHAR *  NameBuffer, int  NameBufferNum, int  JapanOnlyFlag );
int  __stdcall dx_EnumFontNameEx( TCHAR *  NameBuffer, int  NameBufferNum, int  CharSet );
int  __stdcall dx_EnumFontNameEx2( TCHAR *  NameBuffer, int  NameBufferNum, const char * EnumFontName, int  CharSet );
int  __stdcall dx_CheckFontName( const char * FontName, int  CharSet );
int  __stdcall dx_InitFontToHandle( void);
int  __stdcall dx_CreateFontToHandle( const char * FontName, int  Size, int  Thick, int  FontType , int  CharSet , int  EdgeSize , int  Italic , int  Handle );

int  __stdcall dx_SetFontSpaceToHandle( int  Point, int  FontHandle);
int  __stdcall dx_DeleteFontToHandle( int  FontHandle);
int  __stdcall dx_SetFontLostFlag( int  FontHandle, int *  LostFlag);
int  __stdcall dx_ChangeFont( const char * FontName, int  CharSet );
int  __stdcall dx_ChangeFontType( int  FontType);
int  __stdcall dx_SetFontSize( int  FontSize);
int  __stdcall dx_GetFontSize( void);
int  __stdcall dx_SetFontThickness( int  ThickPal);
int  __stdcall dx_SetFontSpace( int  Point);
int  __stdcall dx_GetFontSpace( void);
int  __stdcall dx_SetDefaultFontState( const char * FontName, int  Size, int  Thick, int  FontType , int  CharSet , int  EdgeSize , int  Italic );
int  __stdcall dx_GetDefaultFontHandle( void);
int  __stdcall dx_GetFontMaxWidth( void);
int  __stdcall dx_GetDrawStringWidth( const char * String, int  StrLen, int  VerticalFlag );
int  __stdcall dx_GetDrawExtendStringWidth( double  ExRateX, const char * String, int  StrLen, int  VerticalFlag );
int  __stdcall dx_GetFontMaxWidthToHandle( int  FontHandle);
int  __stdcall dx_GetFontSizeToHandle( int  FontHandle);
int  __stdcall dx_GetFontSpaceToHandle( int  FontHandle);
int  __stdcall dx_GetFontCharInfo( int  FontHandle, const char * Char, int *  DrawX, int *  DrawY, int *  NextCharX, int *  SizeX, int *  SizeY);
int  __stdcall dx_GetDrawStringWidthToHandle( const char * String, int  StrLen, int  FontHandle, int  VerticalFlag );
int  __stdcall dx_GetDrawExtendStringWidthToHandle( double  ExRateX, const char * String, int  StrLen, int  FontHandle, int  VerticalFlag );
int  __stdcall dx_GetFontStateToHandle( TCHAR *  FontName, int *  Size, int *  Thick, int  FontHandle, int *  FontType, int *  CharSet, int *  EdgeSize, int *  Italic);
int  __stdcall dx_CheckFontCacheToTextureFlag( int  FontHandle);
int  __stdcall dx_CheckFontChacheToTextureFlag( int  FontHandle);
int  __stdcall dx_CheckFontHandleValid( int  FontHandle);
int  __stdcall dx_SetFontCacheToTextureFlag( int  Flag);
int  __stdcall dx_GetFontCacheToTextureFlag( void);
int  __stdcall dx_SetFontChacheToTextureFlag( int  Flag);
int  __stdcall dx_GetFontChacheToTextureFlag( void);
int  __stdcall dx_SetFontCacheTextureColorBitDepth( int  ColorBitDepth);
int  __stdcall dx_GetFontCacheTextureColorBitDepth( void);
int  __stdcall dx_SetFontCacheCharNum( int  CharNum);
int  __stdcall dx_GetFontCacheCharNum( void);
int  __stdcall dx_SetFontCacheUsePremulAlphaFlag( int  Flag);
int  __stdcall dx_GetFontCacheUsePremulAlphaFlag( void);
int __stdcall dx_FontCacheStringDrawToHandle( int x , int y , const TCHAR * StrData , int Color , int EdgeColor , BASEIMAGE * DestImage , const RECT * ClipRect , int FontHandle , int VerticalFlag ) ;
int __stdcall dx_FontBaseImageBlt( int x , int y , const TCHAR * StrData , BASEIMAGE * DestImage , BASEIMAGE * DestEdgeImage , int VerticalFlag ) ;
int __stdcall dx_FontBaseImageBltToHandle( int x , int y , const TCHAR * StrData , BASEIMAGE * DestImage , BASEIMAGE * DestEdgeImage , int FontHandle , int VerticalFlag ) ;
int  __stdcall dx_MultiByteCharCheck( const char * Buf, int  CharSet);
int  __stdcall dx_DrawString( int  x, int  y, const char * String, int  Color, int  EdgeColor );
int  __stdcall dx_DrawVString( int  x, int  y, const char * String, int  Color, int  EdgeColor );
int  __stdcall dx_DrawExtendString( int  x, int  y, double  ExRateX, double  ExRateY, const char * String, int  Color, int  EdgeColor );
int  __stdcall dx_DrawExtendVString( int  x, int  y, double  ExRateX, double  ExRateY, const char * String, int  Color, int  EdgeColor );
int  __stdcall dx_DrawStringF( float  x, float  y, const char * String, int  Color, int  EdgeColor );
int  __stdcall dx_DrawVStringF( float  x, float  y, const char * String, int  Color, int  EdgeColor );
int  __stdcall dx_DrawExtendStringF( float  x, float  y, double  ExRateX, double  ExRateY, const char * String, int  Color, int  EdgeColor );
int  __stdcall dx_DrawExtendVStringF( float  x, float  y, double  ExRateX, double  ExRateY, const char * String, int  Color, int  EdgeColor );
int  __stdcall dx_DrawNumberToI( int  x, int  y, int  Num, int  RisesNum, int  Color, int  EdgeColor );
int  __stdcall dx_DrawNumberToF( int  x, int  y, double  Num, int  Length, int  Color, int  EdgeColor );
int  __stdcall dx_DrawNumberPlusToI( int  x, int  y, const char * NoteString, int  Num, int  RisesNum, int  Color, int  EdgeColor );
int  __stdcall dx_DrawNumberPlusToF( int  x, int  y, const char * NoteString, double  Num, int  Length, int  Color, int  EdgeColor );
int  __stdcall dx_DrawStringToZBuffer( int  x, int  y, const char * String, int  WriteZMode);
int  __stdcall dx_DrawVStringToZBuffer( int  x, int  y, const char * String, int  WriteZMode);
int  __stdcall dx_DrawExtendStringToZBuffer( int  x, int  y, double  ExRateX, double  ExRateY, const char * String, int  WriteZMode);
int  __stdcall dx_DrawExtendVStringToZBuffer( int  x, int  y, double  ExRateX, double  ExRateY, const char * String, int  WriteZMode);
int  __stdcall dx_DrawStringToHandle( int  x, int  y, const char * String, int  Color, int  FontHandle, int  EdgeColor , int  VerticalFlag );
int  __stdcall dx_DrawVStringToHandle( int  x, int  y, const char * String, int  Color, int  FontHandle, int  EdgeColor );
int  __stdcall dx_DrawExtendStringToHandle( int  x, int  y, double  ExRateX, double  ExRateY, const char * String, int  Color, int  FontHandle, int  EdgeColor , int  VerticalFlag );
int  __stdcall dx_DrawExtendVStringToHandle( int  x, int  y, double  ExRateX, double  ExRateY, const char * String, int  Color, int  FontHandle, int  EdgeColor );
int  __stdcall dx_DrawStringFToHandle( float  x, float  y, const char * String, int  Color, int  FontHandle, int  EdgeColor , int  VerticalFlag );
int  __stdcall dx_DrawVStringFToHandle( float  x, float  y, const char * String, int  Color, int  FontHandle, int  EdgeColor );
int  __stdcall dx_DrawExtendStringFToHandle( float  x, float  y, double  ExRateX, double  ExRateY, const char * String, int  Color, int  FontHandle, int  EdgeColor , int  VerticalFlag );
int  __stdcall dx_DrawExtendVStringFToHandle( float  x, float  y, double  ExRateX, double  ExRateY, const char * String, int  Color, int  FontHandle, int  EdgeColor );
int  __stdcall dx_DrawNumberToIToHandle( int  x, int  y, int  Num, int  RisesNum, int  Color, int  FontHandle, int  EdgeColor );
int  __stdcall dx_DrawNumberToFToHandle( int  x, int  y, double  Num, int  Length, int  Color, int  FontHandle, int  EdgeColor );
int  __stdcall dx_DrawNumberPlusToIToHandle( int  x, int  y, const char * NoteString, int  Num, int  RisesNum, int  Color, int  FontHandle, int  EdgeColor );
int  __stdcall dx_DrawNumberPlusToFToHandle( int  x, int  y, const char * NoteString, double  Num, int  Length, int  Color, int  FontHandle, int  EdgeColor );
int  __stdcall dx_DrawStringToHandleToZBuffer( int  x, int  y, const char * String, int  FontHandle, int  WriteZMode, int  VerticalFlag );
int  __stdcall dx_DrawVStringToHandleToZBuffer( int  x, int  y, const char * String, int  FontHandle, int  WriteZMode);
int  __stdcall dx_DrawExtendStringToHandleToZBuffer( int  x, int  y, double  ExRateX, double  ExRateY, const char * String, int  FontHandle, int  WriteZMode, int  VerticalFlag );
int  __stdcall dx_DrawExtendVStringToHandleToZBuffer( int  x, int  y, double  ExRateX, double  ExRateY, const char * String, int  FontHandle, int  WriteZMode);
int  __stdcall dx_CreateIdentityMatrix( MATRIX *  Out);
int  __stdcall dx_CreateLookAtMatrix( MATRIX *  Out, const VECTOR *  Eye, const VECTOR *  At, const VECTOR *  Up);
int  __stdcall dx_CreateLookAtMatrix2( MATRIX *  Out, const VECTOR *  Eye, double  XZAngle, double  Oira);
int  __stdcall dx_CreateLookAtMatrixRH( MATRIX *  Out, const VECTOR *  Eye, const VECTOR *  At, const VECTOR *  Up);
int  __stdcall dx_CreateMultiplyMatrix( MATRIX *  Out, const MATRIX *  In1, const MATRIX *  In2);
int  __stdcall dx_CreatePerspectiveFovMatrix( MATRIX *  Out, float  fov, float  zn, float  zf, float  aspect );
int  __stdcall dx_CreatePerspectiveFovMatrixRH( MATRIX *  Out, float  fov, float  zn, float  zf, float  aspect );
int  __stdcall dx_CreateOrthoMatrix( MATRIX *  Out, float  size, float  zn, float  zf, float  aspect );
int  __stdcall dx_CreateOrthoMatrixRH( MATRIX *  Out, float  size, float  zn, float  zf, float  aspect );
int  __stdcall dx_CreateScalingMatrix( MATRIX *  Out, float  sx, float  sy, float  sz);
int  __stdcall dx_CreateRotationXMatrix( MATRIX *  Out, float  Angle);
int  __stdcall dx_CreateRotationYMatrix( MATRIX *  Out, float  Angle);
int  __stdcall dx_CreateRotationZMatrix( MATRIX *  Out, float  Angle);
int  __stdcall dx_CreateTranslationMatrix( MATRIX *  Out, float  x, float  y, float  z);
int  __stdcall dx_CreateTransposeMatrix( MATRIX *  Out, const MATRIX *  In);
int  __stdcall dx_CreateInverseMatrix( MATRIX *  Out, const MATRIX *  In);
int  __stdcall dx_CreateViewportMatrix( MATRIX *  Out, float  CenterX, float  CenterY, float  Width, float  Height);
int  __stdcall dx_CreateRotationXYZMatrix( MATRIX *  Out, float  XRot, float  YRot, float  ZRot);
int  __stdcall dx_CreateRotationXZYMatrix( MATRIX *  Out, float  XRot, float  YRot, float  ZRot);
int  __stdcall dx_CreateRotationYXZMatrix( MATRIX *  Out, float  XRot, float  YRot, float  ZRot);
int  __stdcall dx_CreateRotationYZXMatrix( MATRIX *  Out, float  XRot, float  YRot, float  ZRot);
int  __stdcall dx_CreateRotationZXYMatrix( MATRIX *  Out, float  XRot, float  YRot, float  ZRot);
int  __stdcall dx_CreateRotationZYXMatrix( MATRIX *  Out, float  XRot, float  YRot, float  ZRot);
int  __stdcall dx_GetMatrixXYZRotation( const MATRIX *  In, float *  OutXRot, float *  OutYRot, float *  OutZRot);
int  __stdcall dx_GetMatrixXZYRotation( const MATRIX *  In, float *  OutXRot, float *  OutYRot, float *  OutZRot);
int  __stdcall dx_GetMatrixYXZRotation( const MATRIX *  In, float *  OutXRot, float *  OutYRot, float *  OutZRot);
int  __stdcall dx_GetMatrixYZXRotation( const MATRIX *  In, float *  OutXRot, float *  OutYRot, float *  OutZRot);
int  __stdcall dx_GetMatrixZXYRotation( const MATRIX *  In, float *  OutXRot, float *  OutYRot, float *  OutZRot);
int  __stdcall dx_GetMatrixZYXRotation( const MATRIX *  In, float *  OutXRot, float *  OutYRot, float *  OutZRot);
int  __stdcall dx_VectorNormalize( VECTOR *  Out, const VECTOR *  In);
int  __stdcall dx_VectorScale( VECTOR *  Out, const VECTOR *  In, float  Scale);
int  __stdcall dx_VectorMultiply( VECTOR *  Out, const VECTOR *  In1, const VECTOR *  In2);
int  __stdcall dx_VectorSub( VECTOR *  Out, const VECTOR *  In1, const VECTOR *  In2);
int  __stdcall dx_VectorAdd( VECTOR *  Out, const VECTOR *  In1, const VECTOR *  In2);
int  __stdcall dx_VectorOuterProduct( VECTOR *  Out, const VECTOR *  In1, const VECTOR *  In2);
float  __stdcall dx_VectorInnerProduct( const VECTOR *  In1, const VECTOR *  In2);
int  __stdcall dx_VectorRotationX( VECTOR *  Out, const VECTOR *  In, double  Angle);
int  __stdcall dx_VectorRotationY( VECTOR *  Out, const VECTOR *  In, double  Angle);
int  __stdcall dx_VectorRotationZ( VECTOR *  Out, const VECTOR *  In, double  Angle);
int  __stdcall dx_VectorTransform( VECTOR *  Out, const VECTOR *  InVec, const MATRIX *  InMatrix);
int  __stdcall dx_VectorTransformSR( VECTOR *  Out, const VECTOR *  InVec, const MATRIX *  InMatrix);
int  __stdcall dx_VectorTransform4( VECTOR *  Out, float *  V4Out, const VECTOR *  InVec, const float *  V4In, const MATRIX *  InMatrix);
int  __stdcall dx_Segment_Segment_Analyse( const VECTOR *  SegmentAPos1, const VECTOR *  SegmentAPos2, const VECTOR *  SegmentBPos1, const VECTOR *  SegmentBPos2, SEGMENT_SEGMENT_RESULT *  Result);
int  __stdcall dx_Segment_Point_Analyse( const VECTOR *  SegmentPos1, const VECTOR *  SegmentPos2, const VECTOR *  PointPos, SEGMENT_POINT_RESULT *  Result);
int  __stdcall dx_Segment_Triangle_Analyse( const VECTOR *  SegmentPos1, const VECTOR *  SegmentPos2, const VECTOR *  TrianglePos1, const VECTOR *  TrianglePos2, const VECTOR *  TrianglePos3, SEGMENT_TRIANGLE_RESULT *  Result);
int  __stdcall dx_Triangle_Point_Analyse( const VECTOR *  TrianglePos1, const VECTOR *  TrianglePos2, const VECTOR *  TrianglePos3, const VECTOR *  PointPos, TRIANGLE_POINT_RESULT *  Result);
int  __stdcall dx_Plane_Point_Analyse( const VECTOR *  PlanePos, const VECTOR *  PlaneNormal, const VECTOR *  PointPos, PLANE_POINT_RESULT *  Result);
void  __stdcall dx_TriangleBarycenter( VECTOR  TrianglePos1, VECTOR  TrianglePos2, VECTOR  TrianglePos3, VECTOR  Position, float *  TrianglePos1Weight, float *  TrianglePos2Weight, float *  TrianglePos3Weight);
float  __stdcall dx_Segment_Segment_MinLength( VECTOR  SegmentAPos1, VECTOR  SegmentAPos2, VECTOR  SegmentBPos1, VECTOR  SegmentBPos2);
float  __stdcall dx_Segment_Segment_MinLength_Square( VECTOR  SegmentAPos1, VECTOR  SegmentAPos2, VECTOR  SegmentBPos1, VECTOR  SegmentBPos2);
float  __stdcall dx_Segment_Triangle_MinLength( VECTOR  SegmentPos1, VECTOR  SegmentPos2, VECTOR  TrianglePos1, VECTOR  TrianglePos2, VECTOR  TrianglePos3);
float  __stdcall dx_Segment_Triangle_MinLength_Square( VECTOR  SegmentPos1, VECTOR  SegmentPos2, VECTOR  TrianglePos1, VECTOR  TrianglePos2, VECTOR  TrianglePos3);
float  __stdcall dx_Segment_Point_MinLength( VECTOR  SegmentPos1, VECTOR  SegmentPos2, VECTOR  PointPos);
float  __stdcall dx_Segment_Point_MinLength_Square( VECTOR  SegmentPos1, VECTOR  SegmentPos2, VECTOR  PointPos);
float  __stdcall dx_Triangle_Point_MinLength( VECTOR  TrianglePos1, VECTOR  TrianglePos2, VECTOR  TrianglePos3, VECTOR  PointPos);
float  __stdcall dx_Triangle_Point_MinLength_Square( VECTOR  TrianglePos1, VECTOR  TrianglePos2, VECTOR  TrianglePos3, VECTOR  PointPos);
float  __stdcall dx_Triangle_Triangle_MinLength( VECTOR  Triangle1Pos1, VECTOR  Triangle1Pos2, VECTOR  Triangle1Pos3, VECTOR  Triangle2Pos1, VECTOR  Triangle2Pos2, VECTOR  Triangle2Pos3);
float  __stdcall dx_Triangle_Triangle_MinLength_Square( VECTOR  Triangle1Pos1, VECTOR  Triangle1Pos2, VECTOR  Triangle1Pos3, VECTOR  Triangle2Pos1, VECTOR  Triangle2Pos2, VECTOR  Triangle2Pos3);
VECTOR  __stdcall dx_Plane_Point_MinLength_Position( VECTOR  PlanePos, VECTOR  PlaneNormal, VECTOR  PointPos);
float  __stdcall dx_Plane_Point_MinLength( VECTOR  PlanePos, VECTOR  PlaneNormal, VECTOR  PointPos);
HITRESULT_LINE  __stdcall dx_HitCheck_Line_Triangle( VECTOR  LinePos1, VECTOR  LinePos2, VECTOR  TrianglePos1, VECTOR  TrianglePos2, VECTOR  TrianglePos3);
int  __stdcall dx_HitCheck_Triangle_Triangle( VECTOR  Triangle1Pos1, VECTOR  Triangle1Pos2, VECTOR  Triangle1Pos3, VECTOR  Triangle2Pos1, VECTOR  Triangle2Pos2, VECTOR  Triangle2Pos3);
HITRESULT_LINE  __stdcall dx_HitCheck_Line_Cube( VECTOR  LinePos1, VECTOR  LinePos2, VECTOR  CubePos1, VECTOR  CubePos2);
int  __stdcall dx_HitCheck_Line_Sphere( VECTOR  LinePos1, VECTOR  LinePos2, VECTOR  SphereCenterPos, float  SphereR);
int  __stdcall dx_HitCheck_Sphere_Sphere( VECTOR  Sphere1CenterPos, float  Sphere1R, VECTOR  Sphere2CenterPos, float  Sphere2R);
int  __stdcall dx_HitCheck_Sphere_Capsule( VECTOR  SphereCenterPos, float  SphereR, VECTOR  CapPos1, VECTOR  CapPos2, float  CapR);
int  __stdcall dx_HitCheck_Sphere_Triangle( VECTOR  SphereCenterPos, float  SphereR, VECTOR  TrianglePos1, VECTOR  TrianglePos2, VECTOR  TrianglePos3);
int  __stdcall dx_HitCheck_Capsule_Capsule( VECTOR  Cap1Pos1, VECTOR  Cap1Pos2, float  Cap1R, VECTOR  Cap2Pos1, VECTOR  Cap2Pos2, float  Cap2R);
int  __stdcall dx_HitCheck_Capsule_Triangle( VECTOR  CapPos1, VECTOR  CapPos2, float  CapR, VECTOR  TrianglePos1, VECTOR  TrianglePos2, VECTOR  TrianglePos3);
int  __stdcall dx_RectClipping( RECT *  Rect, const RECT *  ClippuRect);
int  __stdcall dx_RectAdjust( RECT *  Rect);
int  __stdcall dx_GetRectSize( const RECT *  Rect, int *  Width, int *  Height);
MATRIX  __stdcall dx_MGetIdent( void);
MATRIX  __stdcall dx_MMult( MATRIX  In1, MATRIX  In2);
MATRIX  __stdcall dx_MScale( MATRIX  InM, float  Scale);
MATRIX  __stdcall dx_MAdd( MATRIX  In1, MATRIX  In2);
MATRIX  __stdcall dx_MGetScale( VECTOR  Scale);
MATRIX  __stdcall dx_MGetRotX( float  XAxisRotate);
MATRIX  __stdcall dx_MGetRotY( float  YAxisRotate);
MATRIX  __stdcall dx_MGetRotZ( float  ZAxisRotate);
MATRIX  __stdcall dx_MGetRotAxis( VECTOR  RotateAxis, float  Rotate);
MATRIX  __stdcall dx_MGetRotVec2( VECTOR  In1, VECTOR  In2);
MATRIX  __stdcall dx_MGetTranslate( VECTOR  Trans);
MATRIX  __stdcall dx_MGetAxis1( VECTOR  XAxis, VECTOR  YAxis, VECTOR  ZAxis, VECTOR  Pos);
MATRIX  __stdcall dx_MGetAxis2( VECTOR  XAxis, VECTOR  YAxis, VECTOR  ZAxis, VECTOR  Pos);
MATRIX  __stdcall dx_MTranspose( MATRIX  InM);
MATRIX  __stdcall dx_MInverse( MATRIX  InM);
VECTOR  __stdcall dx_MGetSize( MATRIX  InM);
VECTOR  __stdcall dx_VNorm( VECTOR  In);
float  __stdcall dx_VSize( VECTOR  In);
float  __stdcall dx_VCos( VECTOR  In1, VECTOR  In2);
float  __stdcall dx_VRad( VECTOR  In1, VECTOR  In2);
int __stdcall dx_CreateGraphImageOrDIBGraph( const TCHAR * FileName , const void * DataImage , int DataImageSize , int DataImageType , int BmpFlag , int ReverseFlag , BASEIMAGE * BaseImage , BITMAPINFO * * BmpInfo , void * * GraphData ) ;
int __stdcall dx_CreateGraphImageType2( STREAMDATA * Src , BASEIMAGE * Dest ) ;
int __stdcall dx_CreateBmpInfo( BITMAPINFO * BmpInfo , int Width , int Height , int Pitch , const void * SrcGrData , void * * DestGrData ) ;
DWORD __stdcall dx_GetGraphImageFullColorCode( const BASEIMAGE * GraphImage , int x , int y ) ;
int __stdcall dx_CreateGraphImage_plus_Alpha( const TCHAR * FileName , const void * RgbBaseImage , int RgbImageSize , int RgbImageType , const void * AlphaImage , int AlphaImageSize , int AlphaImageType , BASEIMAGE * RgbGraphImage , BASEIMAGE * AlphaGraphImage , int ReverseFlag ) ;
int __stdcall dx_ReverseGraphImage( BASEIMAGE * GraphImage ) ;
HBITMAP __stdcall dx_CreateDIBGraph( const TCHAR * FileName , int ReverseFlag , COLORDATA * SrcColor ) ;
HBITMAP __stdcall dx_CreateDIBGraphToMem( const BITMAPINFO * BmpInfo , const void * GraphData , int ReverseFlag , COLORDATA * SrcColor ) ;
int __stdcall dx_CreateDIBGraph_plus_Alpha( const TCHAR * FileName , HBITMAP * RGBBmp , HBITMAP * AlphaBmp , int ReverseFlag ) ;
HBITMAP __stdcall dx_CreateDIBGraphVer2( const TCHAR * FileName , const void * MemImage , int MemImageSize , int ImageType , int ReverseFlag , COLORDATA * SrcColor ) ;
int __stdcall dx_CreateDIBGraphVer2_plus_Alpha( const TCHAR * FileName , const void * MemImage , int MemImageSize , const void * AlphaImage , int AlphaImageSize , int ImageType , HBITMAP * RGBBmp , HBITMAP * AlphaBmp , int ReverseFlag , COLORDATA * SrcColor ) ;
int __stdcall dx_ConvBitmapToGraphImage( const BITMAPINFO * BmpInfo , void * GraphData , BASEIMAGE * GraphImage , int CopyFlag ) ;
int __stdcall dx_ConvGraphImageToBitmap( const BASEIMAGE * GraphImage , BITMAPINFO * BmpInfo , void * * GraphData , int CopyFlag , int FullColorConv ) ;
int __stdcall dx_AddUserGraphLoadFunction4( int ( *UserLoadFunc )( STREAMDATA * Src , BASEIMAGE * BaseImage ) ) ;
int __stdcall dx_SubUserGraphLoadFunction4( int ( *UserLoadFunc )( STREAMDATA * Src , BASEIMAGE * BaseImage ) ) ;
int  __stdcall dx_SetUseFastLoadFlag( int  Flag);
int  __stdcall dx_SetGraphDataShavedMode( int  ShavedMode);
int  __stdcall dx_GetGraphDataShavedMode( void);
int  __stdcall dx_SetUsePremulAlphaConvertLoad( int  UseFlag);
int __stdcall dx_CreateBaseImage( const TCHAR * FileName , const void * FileImage , int FileImageSize , int DataType , BASEIMAGE * BaseImage , int ReverseFlag ) ;
int __stdcall dx_CreateGraphImage( const TCHAR * FileName , const void * DataImage , int DataImageSize , int DataImageType , BASEIMAGE * GraphImage , int ReverseFlag ) ;
int __stdcall dx_CreateBaseImageToFile( const TCHAR * FileName , BASEIMAGE * BaseImage , int ReverseFlag ) ;
int __stdcall dx_CreateBaseImageToMem( const void * FileImage , int FileImageSize , BASEIMAGE * BaseImage , int ReverseFlag ) ;
int __stdcall dx_CreateARGB8ColorBaseImage( int SizeX , int SizeY , BASEIMAGE * BaseImage ) ;
int __stdcall dx_CreateXRGB8ColorBaseImage( int SizeX , int SizeY , BASEIMAGE * BaseImage ) ;
int __stdcall dx_CreateRGB8ColorBaseImage( int SizeX , int SizeY , BASEIMAGE * BaseImage ) ;
int __stdcall dx_CreateARGB4ColorBaseImage( int SizeX , int SizeY , BASEIMAGE * BaseImage ) ;
int __stdcall dx_CreatePAL8ColorBaseImage( int SizeX , int SizeY , BASEIMAGE * BaseImage ) ;
int __stdcall dx_CreateColorDataBaseImage( int SizeX , int SizeY , const COLORDATA * ColorData , BASEIMAGE * BaseImage ) ;
int __stdcall dx_GetBaseImageGraphDataSize( const BASEIMAGE * BaseImage ) ;
int __stdcall dx_DerivationBaseImage( const BASEIMAGE * BaseImage , int x1 , int y1 , int x2 , int y2 , BASEIMAGE * NewBaseImage ) ;
int __stdcall dx_ReleaseBaseImage( BASEIMAGE * BaseImage ) ;
int __stdcall dx_ReleaseGraphImage( BASEIMAGE * GraphImage ) ;
int __stdcall dx_ConvertNormalFormatBaseImage( BASEIMAGE * BaseImage ) ;
int __stdcall dx_ConvertPremulAlphaBaseImage( BASEIMAGE * BaseImage ) ;
int __stdcall dx_ConvertInterpAlphaBaseImage( BASEIMAGE * BaseImage ) ;
int __stdcall dx_GetDrawScreenBaseImage( int x1 , int y1 , int x2 , int y2 , BASEIMAGE * BaseImage ) ;
int __stdcall dx_GetDrawScreenBaseImageDestPos( int x1 , int y1 , int x2 , int y2 , BASEIMAGE * BaseImage , int DestX , int DestY ) ;
int __stdcall dx_UpdateLayerdWindowForBaseImage( const BASEIMAGE * BaseImage ) ;
int __stdcall dx_UpdateLayerdWindowForBaseImageRect( const BASEIMAGE * BaseImage , int x1 , int y1 , int x2 , int y2 ) ;
int __stdcall dx_UpdateLayerdWindowForPremultipliedAlphaBaseImage( const BASEIMAGE * BaseImage ) ;
int __stdcall dx_UpdateLayerdWindowForPremultipliedAlphaBaseImageRect( const BASEIMAGE * BaseImage , int x1 , int y1 , int x2 , int y2 ) ;
int __stdcall dx_FillBaseImage( BASEIMAGE * BaseImage , int r , int g , int b , int a ) ;
int __stdcall dx_FillRectBaseImage( BASEIMAGE * BaseImage , int x , int y , int w , int h , int r , int g , int b , int a ) ;
int __stdcall dx_ClearRectBaseImage( BASEIMAGE * BaseImage , int x , int y , int w , int h ) ;
int __stdcall dx_GetPaletteBaseImage( const BASEIMAGE * BaseImage , int PaletteNo , int * r , int * g , int * b , int * a ) ;
int __stdcall dx_SetPaletteBaseImage( BASEIMAGE * BaseImage , int PaletteNo , int r , int g , int b , int a ) ;
int __stdcall dx_SetPixelPalCodeBaseImage( BASEIMAGE * BaseImage , int x , int y , int palNo ) ;
int __stdcall dx_GetPixelPalCodeBaseImage( const BASEIMAGE * BaseImage , int x , int y ) ;
int __stdcall dx_SetPixelBaseImage( BASEIMAGE * BaseImage , int x , int y , int r , int g , int b , int a ) ;
int __stdcall dx_GetPixelBaseImage( BASEIMAGE * BaseImage , int x , int y , int * r , int * g , int * b , int * a ) ;
int __stdcall dx_DrawLineBaseImage( BASEIMAGE * BaseImage , int x1 , int y1 , int x2 , int y2 , int r , int g , int b , int a ) ;
int __stdcall dx_BltBaseImage( int SrcX , int SrcY , int SrcSizeX , int SrcSizeY , int DestX , int DestY , BASEIMAGE * SrcBaseImage , BASEIMAGE * DestBaseImage ) ;
int __stdcall dx_BltBaseImage_2( int DestX , int DestY , BASEIMAGE * SrcBaseImage , BASEIMAGE * DestBaseImage ) ;
int __stdcall dx_BltBaseImageWithTransColor( int SrcX , int SrcY , int SrcSizeX , int SrcSizeY , int DestX , int DestY , BASEIMAGE * SrcBaseImage , BASEIMAGE * DestBaseImage , int Tr , int Tg , int Tb , int Ta ) ;
int __stdcall dx_BltBaseImageWithAlphaBlend( int SrcX , int SrcY , int SrcSizeX , int SrcSizeY , int DestX , int DestY , BASEIMAGE * SrcBaseImage , BASEIMAGE * DestBaseImage , int Opacity ) ;
int __stdcall dx_ReverseBaseImageH( BASEIMAGE * BaseImage ) ;
int __stdcall dx_ReverseBaseImageV( BASEIMAGE * BaseImage ) ;
int __stdcall dx_ReverseBaseImage( BASEIMAGE * BaseImage ) ;
int __stdcall dx_CheckPixelAlphaBaseImage( const BASEIMAGE * BaseImage ) ;
int __stdcall dx_SaveBaseImageToBmp( const TCHAR * FilePath , const BASEIMAGE * BaseImage ) ;
int __stdcall dx_SaveBaseImageToPng( const TCHAR * FilePath , BASEIMAGE * BaseImage , int CompressionLevel ) ;
int __stdcall dx_SaveBaseImageToJpeg( const TCHAR * FilePath , BASEIMAGE * BaseImage , int Quality , int Sample2x1 ) ;
int __stdcall dx_DrawBaseImage( int x , int y , BASEIMAGE * BaseImage ) ;
//-----------------------------------------------------
int __stdcall dx_GraphColorMatchBltVer2( void * DestGraphData , 
int DestPitch , 
const COLORDATA * DestColorData , 
const void * SrcGraphData , 
int SrcPitch , 
const COLORDATA * SrcColorData , 
const void * AlphaMask , 
int AlphaPitch , 
const COLORDATA * AlphaColorData ,
void* DestPoint ,  // void* 型に変更 元はpoint
const RECT * SrcRect , 
int ReverseFlag , 
int TransColorAlphaTestFlag , 
unsigned int TransColor , 
int ImageShavedMode , 
int AlphaOnlyFlag ) ;
//-----------------------------------------------------
COLOR_F  __stdcall dx_GetColorF( float  Red, float  Green, float  Blue, float  Alpha);
COLOR_U8  __stdcall dx_GetColorU8( int  Red, int  Green, int  Blue, int  Alpha);
int __stdcall dx_GetColor( int  Red, int  Green, int  Blue);
int  __stdcall dx_GetColor2( int  Color, int *  Red, int *  Green, int *  Blue);
int  __stdcall dx_GetColor3( const COLORDATA *  ColorData, int  Red, int  Green, int  Blue, int  Alpha );
int  __stdcall dx_GetColor4( const COLORDATA *  DestColorData, const COLORDATA *  SrcColorData, int  SrcColor);
int  __stdcall dx_GetColor5( const COLORDATA *  ColorData, int  Color, int *  Red, int *  Green, int *  Blue, int *  Alpha);
int  __stdcall dx_CreatePaletteColorData( COLORDATA *  ColorDataBuf);
int  __stdcall dx_CreateXRGB8ColorData( COLORDATA *  ColorDataBuf);
int  __stdcall dx_CreateARGB8ColorData( COLORDATA *  ColorDataBuf);
int  __stdcall dx_CreateARGB4ColorData( COLORDATA *  ColorDataBuf);
int  __stdcall dx_CreateFullColorData( COLORDATA *  ColorDataBuf);
int  __stdcall dx_CreateGrayColorData( COLORDATA *  ColorDataBuf);
int  __stdcall dx_CreatePal8ColorData( COLORDATA *  ColorDataBuf);
int  __stdcall dx_CreateColorData( COLORDATA *  ColorDataBuf, int  ColorBitDepth, DWORD  RedMask, DWORD  GreenMask, DWORD  BlueMask, DWORD  AlphaMask, int  ChannelNum , int  ChannelBitDepth , int  FloatTypeFlag );
void  __stdcall dx_SetColorDataNoneMask( COLORDATA *  ColorData);
int  __stdcall dx_CmpColorData( const COLORDATA *  ColorData1, const COLORDATA *  ColorData2);
int  __stdcall dx_InitSoftImage( void);
int  __stdcall dx_LoadSoftImage( const char * FileName);
int  __stdcall dx_LoadSoftImageToMem( const void * FileImage, int  FileImageSize);
int  __stdcall dx_MakeSoftImage( int  SizeX, int  SizeY);
int  __stdcall dx_MakeARGB8ColorSoftImage( int  SizeX, int  SizeY);
int  __stdcall dx_MakeXRGB8ColorSoftImage( int  SizeX, int  SizeY);
int  __stdcall dx_MakeARGB4ColorSoftImage( int  SizeX, int  SizeY);
int  __stdcall dx_MakeRGB8ColorSoftImage( int  SizeX, int  SizeY);
int  __stdcall dx_MakePAL8ColorSoftImage( int  SizeX, int  SizeY);
int  __stdcall dx_DeleteSoftImage( int  SIHandle);
int  __stdcall dx_GetSoftImageSize( int  SIHandle, int *  Width, int *  Height);
int  __stdcall dx_CheckPaletteSoftImage( int  SIHandle);
int  __stdcall dx_CheckAlphaSoftImage( int  SIHandle);
int  __stdcall dx_CheckPixelAlphaSoftImage( int  SIHandle);
int  __stdcall dx_GetDrawScreenSoftImage( int  x1, int  y1, int  x2, int  y2, int  SIHandle);
int  __stdcall dx_GetDrawScreenSoftImageDestPos( int  x1, int  y1, int  x2, int  y2, int  SIHandle, int  DestX, int  DestY);
int  __stdcall dx_UpdateLayerdWindowForSoftImage( int  SIHandle);
int  __stdcall dx_UpdateLayerdWindowForSoftImageRect( int  SIHandle, int  x1, int  y1, int  x2, int  y2);
int  __stdcall dx_UpdateLayerdWindowForPremultipliedAlphaSoftImage( int  SIHandle);
int  __stdcall dx_UpdateLayerdWindowForPremultipliedAlphaSoftImageRect( int  SIHandle, int  x1, int  y1, int  x2, int  y2);
int  __stdcall dx_FillSoftImage( int  SIHandle, int  r, int  g, int  b, int  a);
int  __stdcall dx_ClearRectSoftImage( int  SIHandle, int  x, int  y, int  w, int  h);
int  __stdcall dx_GetPaletteSoftImage( int  SIHandle, int  PaletteNo, int *  r, int *  g, int *  b, int *  a);
int  __stdcall dx_SetPaletteSoftImage( int  SIHandle, int  PaletteNo, int  r, int  g, int  b, int  a);
int  __stdcall dx_DrawPixelPalCodeSoftImage( int  SIHandle, int  x, int  y, int  palNo);
int  __stdcall dx_GetPixelPalCodeSoftImage( int  SIHandle, int  x, int  y);
void *  __stdcall dx_GetImageAddressSoftImage( int  SIHandle);
int  __stdcall dx_GetPitchSoftImage( int  SIHandle);
int  __stdcall dx_DrawPixelSoftImage( int  SIHandle, int  x, int  y, int  r, int  g, int  b, int  a);
void  __stdcall dx_DrawPixelSoftImage_Unsafe_XRGB8( int  SIHandle, int  x, int  y, int  r, int  g, int  b);
void  __stdcall dx_DrawPixelSoftImage_Unsafe_ARGB8( int  SIHandle, int  x, int  y, int  r, int  g, int  b, int  a);
int  __stdcall dx_GetPixelSoftImage( int  SIHandle, int  x, int  y, int *  r, int *  g, int *  b, int *  a);
void  __stdcall dx_GetPixelSoftImage_Unsafe_XRGB8( int  SIHandle, int  x, int  y, int *  r, int *  g, int *  b);
void  __stdcall dx_GetPixelSoftImage_Unsafe_ARGB8( int  SIHandle, int  x, int  y, int *  r, int *  g, int *  b, int *  a);
int  __stdcall dx_DrawLineSoftImage( int  SIHandle, int  x1, int  y1, int  x2, int  y2, int  r, int  g, int  b, int  a);
int  __stdcall dx_BltSoftImage( int  SrcX, int  SrcY, int  SrcSizeX, int  SrcSizeY, int  SrcSIHandle, int  DestX, int  DestY, int  DestSIHandle);
int  __stdcall dx_BltSoftImageWithTransColor( int  SrcX, int  SrcY, int  SrcSizeX, int  SrcSizeY, int  SrcSIHandle, int  DestX, int  DestY, int  DestSIHandle, int  Tr, int  Tg, int  Tb, int  Ta);
int  __stdcall dx_BltSoftImageWithAlphaBlend( int  SrcX, int  SrcY, int  SrcSizeX, int  SrcSizeY, int  SrcSIHandle, int  DestX, int  DestY, int  DestSIHandle, int  Opacity );
int  __stdcall dx_ReverseSoftImageH( int  SIHandle);
int  __stdcall dx_ReverseSoftImageV( int  SIHandle);
int  __stdcall dx_ReverseSoftImage( int  SIHandle);
int  __stdcall dx_BltStringSoftImage( int  x, int  y, const char * StrData, int  DestSIHandle, int  DestEdgeSIHandle , int  VerticalFlag );
int  __stdcall dx_BltStringSoftImageToHandle( int  x, int  y, const char * StrData, int  DestSIHandle, int  DestEdgeSIHandle, int  FontHandle, int  VerticalFlag );
int  __stdcall dx_DrawSoftImage( int  x, int  y, int  SIHandle);
int  __stdcall dx_SaveSoftImageToBmp( const char * FilePath, int  SIHandle);
int  __stdcall dx_SaveSoftImageToPng( const char * FilePath, int  SIHandle, int  CompressionLevel);
int  __stdcall dx_SaveSoftImageToJpeg( const char * FilePath, int  SIHandle, int  Quality, int  Sample2x1);
int  __stdcall dx_InitSoundMem( int  LogOutFlag );
int  __stdcall dx_AddSoundData( int  Handle );
int __stdcall dx_AddStreamSoundMem( STREAMDATA * Stream , int LoopNum , int SoundHandle , int StreamDataType , int * CanStreamCloseFlag , int UnionHandle ) ;
int  __stdcall dx_AddStreamSoundMemToMem( const void * FileImage, int  FileImageSize, int  LoopNum, int  SoundHandle, int  StreamDataType, int  UnionHandle );
int  __stdcall dx_AddStreamSoundMemToFile( const char * WaveFile, int  LoopNum, int  SoundHandle, int  StreamDataType, int  UnionHandle );
int  __stdcall dx_SetupStreamSoundMem( int  SoundHandle);
int  __stdcall dx_PlayStreamSoundMem( int  SoundHandle, int  PlayType , int  TopPositionFlag );
int  __stdcall dx_CheckStreamSoundMem( int  SoundHandle);
int  __stdcall dx_StopStreamSoundMem( int  SoundHandle);
int  __stdcall dx_SetStreamSoundCurrentPosition( int  Byte, int  SoundHandle);
int  __stdcall dx_GetStreamSoundCurrentPosition( int  SoundHandle);
int  __stdcall dx_SetStreamSoundCurrentTime( int  Time, int  SoundHandle);
int  __stdcall dx_GetStreamSoundCurrentTime( int  SoundHandle);
int  __stdcall dx_ProcessStreamSoundMem( int  SoundHandle);
int  __stdcall dx_ProcessStreamSoundMemAll( void);
int  __stdcall dx_LoadSoundMem2( const char * FileName1, const char * FileName2);
int  __stdcall dx_LoadBGM( const char * FileName);
int  __stdcall dx_LoadSoundMemBase( const char * FileName, int  BufferNum, int  UnionHandle );
int  __stdcall dx_LoadSoundMem( const char * FileName, int  BufferNum , int  UnionHandle );
int  __stdcall dx_LoadSoundMemToBufNumSitei( const char * FileName, int  BufferNum);
int  __stdcall dx_LoadSoundMemByResource( const char * ResourceName, const char * ResourceType, int  BufferNum );
int  __stdcall dx_DuplicateSoundMem( int  SrcSoundHandle, int  BufferNum );
int  __stdcall dx_LoadSoundMemByMemImageBase( const void * FileImage, int  FileImageSize, int  BufferNum, int  UnionHandle );
int  __stdcall dx_LoadSoundMemByMemImage( const void * FileImage, int  FileImageSize, int  UnionHandle );
int __stdcall dx_LoadSoundMemByMemImage2( const void * WaveImage , int WaveImageSize , const WAVEFORMATEX * WaveFormat , int WaveHeaderSize ) ;
int  __stdcall dx_LoadSoundMemByMemImageToBufNumSitei( const void * FileImage, int  FileImageSize, int  BufferNum);
int  __stdcall dx_LoadSoundMem2ByMemImage( const void * FileImage1, int  FileImageSize1, const void * FileImage2, int  FileImageSize2);
int  __stdcall dx_LoadSoundMemFromSoftSound( int  SoftSoundHandle, int  BufferNum );
int  __stdcall dx_DeleteSoundMem( int  SoundHandle, int  LogOutFlag );
int  __stdcall dx_PlaySoundMem( int  SoundHandle, int  PlayType, int  TopPositionFlag );
int  __stdcall dx_StopSoundMem( int  SoundHandle);
int  __stdcall dx_CheckSoundMem( int  SoundHandle);
int  __stdcall dx_SetPanSoundMem( int  PanPal, int  SoundHandle);
int  __stdcall dx_ChangePanSoundMem( int  PanPal, int  SoundHandle);
int  __stdcall dx_GetPanSoundMem( int  SoundHandle);
int  __stdcall dx_SetVolumeSoundMem( int  VolumePal, int  SoundHandle);
int  __stdcall dx_ChangeVolumeSoundMem( int  VolumePal, int  SoundHandle);
int  __stdcall dx_GetVolumeSoundMem( int  SoundHandle);
int  __stdcall dx_SetChannelVolumeSoundMem( int  Channel, int  VolumePal, int  SoundHandle);
int  __stdcall dx_ChangeChannelVolumeSoundMem( int  Channel, int  VolumePal, int  SoundHandle);
int  __stdcall dx_GetChannelVolumeSoundMem( int  Channel, int  SoundHandle);
int  __stdcall dx_SetFrequencySoundMem( int  FrequencyPal, int  SoundHandle);
int  __stdcall dx_GetFrequencySoundMem( int  SoundHandle);
int  __stdcall dx_ResetFrequencySoundMem( int  SoundHandle);
int  __stdcall dx_SetNextPlayPanSoundMem( int  PanPal, int  SoundHandle);
int  __stdcall dx_ChangeNextPlayPanSoundMem( int  PanPal, int  SoundHandle);
int  __stdcall dx_SetNextPlayVolumeSoundMem( int  VolumePal, int  SoundHandle);
int  __stdcall dx_ChangeNextPlayVolumeSoundMem( int  VolumePal, int  SoundHandle);
int  __stdcall dx_SetNextPlayChannelVolumeSoundMem( int  Channel, int  VolumePal, int  SoundHandle);
int  __stdcall dx_ChangeNextPlayChannelVolumeSoundMem( int  Channel, int  VolumePal, int  SoundHandle);
int  __stdcall dx_SetNextPlayFrequencySoundMem( int  FrequencyPal, int  SoundHandle);
int  __stdcall dx_SetCurrentPositionSoundMem( int  SamplePosition, int  SoundHandle);
int  __stdcall dx_GetCurrentPositionSoundMem( int  SoundHandle);
int  __stdcall dx_SetSoundCurrentPosition( int  Byte, int  SoundHandle);
int  __stdcall dx_GetSoundCurrentPosition( int  SoundHandle);
int  __stdcall dx_SetSoundCurrentTime( int  Time, int  SoundHandle);
int  __stdcall dx_GetSoundCurrentTime( int  SoundHandle);
int  __stdcall dx_GetSoundTotalSample( int  SoundHandle);
int  __stdcall dx_GetSoundTotalTime( int  SoundHandle);
int  __stdcall dx_SetLoopPosSoundMem( int  LoopTime, int  SoundHandle);
int  __stdcall dx_SetLoopTimePosSoundMem( int  LoopTime, int  SoundHandle);
int  __stdcall dx_SetLoopSamplePosSoundMem( int  LoopSamplePosition, int  SoundHandle);
int  __stdcall dx_SetLoopStartTimePosSoundMem( int  LoopStartTime, int  SoundHandle);
int  __stdcall dx_SetLoopStartSamplePosSoundMem( int  LoopStartSamplePosition, int  SoundHandle);
int  __stdcall dx_SetPlayFinishDeleteSoundMem( int  DeleteFlag, int  SoundHandle);
int  __stdcall dx_Set3DReverbParamSoundMem( const SOUND3D_REVERB_PARAM *  Param, int  SoundHandle);
int  __stdcall dx_Set3DPresetReverbParamSoundMem( int  PresetNo, int  SoundHandle);
int  __stdcall dx_Set3DReverbParamSoundMemAll( const SOUND3D_REVERB_PARAM *  Param, int  PlaySoundOnly );
int  __stdcall dx_Set3DPresetReverbParamSoundMemAll( int  PresetNo, int  PlaySoundOnly );
int  __stdcall dx_Get3DReverbParamSoundMem( SOUND3D_REVERB_PARAM *  ParamBuffer, int  SoundHandle);
int  __stdcall dx_Get3DPresetReverbParamSoundMem( SOUND3D_REVERB_PARAM *  ParamBuffer, int  PresetNo);
int  __stdcall dx_Set3DPositionSoundMem( VECTOR  Position, int  SoundHandle);
int  __stdcall dx_Set3DRadiusSoundMem( float  Radius, int  SoundHandle);
int  __stdcall dx_Set3DVelocitySoundMem( VECTOR  Velocity, int  SoundHandle);
int  __stdcall dx_SetNextPlay3DPositionSoundMem( VECTOR  Position, int  SoundHandle);
int  __stdcall dx_SetNextPlay3DRadiusSoundMem( float  Radius, int  SoundHandle);
int  __stdcall dx_SetNextPlay3DVelocitySoundMem( VECTOR  Velocity, int  SoundHandle);
int  __stdcall dx_SetCreateSoundDataType( int  SoundDataType);
int  __stdcall dx_GetCreateSoundDataType( void);
int  __stdcall dx_SetDisableReadSoundFunctionMask( int  Mask);
int  __stdcall dx_GetDisableReadSoundFunctionMask( void);
int  __stdcall dx_SetEnableSoundCaptureFlag( int  Flag);
int  __stdcall dx_SetUseSoftwareMixingSoundFlag( int  Flag);
int  __stdcall dx_SetEnableXAudioFlag( int  Flag);
int  __stdcall dx_SetUseOldVolumeCalcFlag( int  Flag);
int  __stdcall dx_SetCreate3DSoundFlag( int  Flag);
int  __stdcall dx_Set3DSoundOneMetre( float  Distance);
int  __stdcall dx_Set3DSoundListenerPosAndFrontPos_UpVecY( VECTOR  Position, VECTOR  FrontPosition);
int  __stdcall dx_Set3DSoundListenerPosAndFrontPosAndUpVec( VECTOR  Position, VECTOR  FrontPosition, VECTOR  UpVector);
int  __stdcall dx_Set3DSoundListenerVelocity( VECTOR  Velocity);
int  __stdcall dx_Set3DSoundListenerConeAngle( float  InnerAngle, float  OuterAngle);
int  __stdcall dx_Set3DSoundListenerConeVolume( float  InnerAngleVolume, float  OuterAngleVolume);
const void * __stdcall dx_GetDSoundObj( void);
int  __stdcall dx_PlaySoundFile( const char * FileName, int  PlayType);
int  __stdcall dx_PlaySound( const char * FileName, int  PlayType);
int  __stdcall dx_CheckSoundFile( void);
int  __stdcall dx_CheckSound( void);
int  __stdcall dx_StopSoundFile( void);
int  __stdcall dx_StopSound( void);
int  __stdcall dx_SetVolumeSoundFile( int  VolumePal);
int  __stdcall dx_SetVolumeSound( int  VolumePal);
int  __stdcall dx_InitSoftSound( void);
int  __stdcall dx_LoadSoftSound( const char * FileName);
int  __stdcall dx_LoadSoftSoundFromMemImage( const void * FileImage, int  FileImageSize);
int  __stdcall dx_MakeSoftSound( int  UseFormat_SoftSoundHandle, int  SampleNum);
int  __stdcall dx_MakeSoftSound2Ch16Bit44KHz( int  SampleNum);
int  __stdcall dx_MakeSoftSound2Ch16Bit22KHz( int  SampleNum);
int  __stdcall dx_MakeSoftSound2Ch8Bit44KHz( int  SampleNum);
int  __stdcall dx_MakeSoftSound2Ch8Bit22KHz( int  SampleNum);
int  __stdcall dx_MakeSoftSound1Ch16Bit44KHz( int  SampleNum);
int  __stdcall dx_MakeSoftSound1Ch16Bit22KHz( int  SampleNum);
int  __stdcall dx_MakeSoftSound1Ch8Bit44KHz( int  SampleNum);
int  __stdcall dx_MakeSoftSound1Ch8Bit22KHz( int  SampleNum);
int  __stdcall dx_MakeSoftSoundCustom( int  ChannelNum, int  BitsPerSample, int  SamplesPerSec, int  SampleNum);
int  __stdcall dx_DeleteSoftSound( int  SoftSoundHandle);
int  __stdcall dx_SaveSoftSound( int  SoftSoundHandle, const char * FileName);
int  __stdcall dx_GetSoftSoundSampleNum( int  SoftSoundHandle);
int  __stdcall dx_GetSoftSoundFormat( int  SoftSoundHandle, int *  Channels, int *  BitsPerSample, int *  SamplesPerSec);
int  __stdcall dx_ReadSoftSoundData( int  SoftSoundHandle, int  SamplePosition, int *  Channel1, int *  Channel2);
int  __stdcall dx_WriteSoftSoundData( int  SoftSoundHandle, int  SamplePosition, int  Channel1, int  Channel2);
void *  __stdcall dx_GetSoftSoundDataImage( int  SoftSoundHandle);
int  __stdcall dx_InitSoftSoundPlayer( void);
int  __stdcall dx_MakeSoftSoundPlayer( int  UseFormat_SoftSoundHandle);
int  __stdcall dx_MakeSoftSoundPlayer2Ch16Bit44KHz( void);
int  __stdcall dx_MakeSoftSoundPlayer2Ch16Bit22KHz( void);
int  __stdcall dx_MakeSoftSoundPlayer2Ch8Bit44KHz( void);
int  __stdcall dx_MakeSoftSoundPlayer2Ch8Bit22KHz( void);
int  __stdcall dx_MakeSoftSoundPlayer1Ch16Bit44KHz( void);
int  __stdcall dx_MakeSoftSoundPlayer1Ch16Bit22KHz( void);
int  __stdcall dx_MakeSoftSoundPlayer1Ch8Bit44KHz( void);
int  __stdcall dx_MakeSoftSoundPlayer1Ch8Bit22KHz( void);
int  __stdcall dx_MakeSoftSoundPlayerCustom( int  ChannelNum, int  BitsPerSample, int  SamplesPerSec);
int  __stdcall dx_DeleteSoftSoundPlayer( int  SSoundPlayerHandle);
int  __stdcall dx_AddDataSoftSoundPlayer( int  SSoundPlayerHandle, int  SoftSoundHandle, int  AddSamplePosition, int  AddSampleNum);
int  __stdcall dx_AddDirectDataSoftSoundPlayer( int  SSoundPlayerHandle, const void * SoundData, int  AddSampleNum);
int  __stdcall dx_AddOneDataSoftSoundPlayer( int  SSoundPlayerHandle, int  Channel1, int  Channel2);
int  __stdcall dx_GetSoftSoundPlayerFormat( int  SSoundPlayerHandle, int *  Channels, int *  BitsPerSample, int *  SamplesPerSec);
int  __stdcall dx_StartSoftSoundPlayer( int  SSoundPlayerHandle);
int  __stdcall dx_CheckStartSoftSoundPlayer( int  SSoundPlayerHandle);
int  __stdcall dx_StopSoftSoundPlayer( int  SSoundPlayerHandle);
int  __stdcall dx_ResetSoftSoundPlayer( int  SSoundPlayerHandle);
int  __stdcall dx_GetStockDataLengthSoftSoundPlayer( int  SSoundPlayerHandle);
int  __stdcall dx_CheckSoftSoundPlayerNoneData( int  SSoundPlayerHandle);
int  __stdcall dx_DeleteMusicMem( int  MusicHandle);
int  __stdcall dx_LoadMusicMem( const char * FileName);
int  __stdcall dx_LoadMusicMemByMemImage( const void * FileImage, int  FileImageSize);
int  __stdcall dx_LoadMusicMemByResource( const char * ResourceName, const char * ResourceType);
int  __stdcall dx_PlayMusicMem( int  MusicHandle, int  PlayType);
int  __stdcall dx_StopMusicMem( int  MusicHandle);
int  __stdcall dx_CheckMusicMem( int  MusicHandle);
int  __stdcall dx_SetVolumeMusicMem( int  Volume, int  MusicHandle);
int  __stdcall dx_GetMusicMemPosition( int  MusicHandle);
int  __stdcall dx_InitMusicMem( void);
int  __stdcall dx_ProcessMusicMem( void);
int  __stdcall dx_PlayMusic( const char * FileName, int  PlayType);
int  __stdcall dx_PlayMusicByMemImage( const void * FileImage, int  FileImageSize, int  PlayType);
int  __stdcall dx_PlayMusicByResource( const char * ResourceName, const char * ResourceType, int  PlayType);
int  __stdcall dx_SetVolumeMusic( int  Volume);
int  __stdcall dx_StopMusic( void);
int  __stdcall dx_CheckMusic( void);
int  __stdcall dx_GetMusicPosition( void);
int  __stdcall dx_SelectMidiMode( int  Mode);
int  __stdcall dx_SetUseDXArchiveFlag( int  Flag);
int  __stdcall dx_SetDXArchivePriority( int  Priority );
int  __stdcall dx_SetDXArchiveExtension( const char * Extension );
int  __stdcall dx_SetDXArchiveKeyString( const char * KeyString );
int  __stdcall dx_DXArchivePreLoad( const char * FilePath, int  ASync );
int  __stdcall dx_DXArchiveCheckIdle( const char * FilePath);
int  __stdcall dx_DXArchiveRelease( const char * FilePath);
int  __stdcall dx_DXArchiveCheckFile( const char * FilePath, const char * TargetFilePath);
int  __stdcall dx_DXArchiveSetMemImage( void *  ArchiveImage, int  ArchiveImageSize, const char * EmulateFilePath, int  ArchiveImageCopyFlag , int  ArchiveImageReadOnly );
int  __stdcall dx_DXArchiveReleaseMemImage( void *  ArchiveImage);
int  __stdcall dx_MV1LoadModel( const char * FileName);
int __stdcall dx_MV1LoadModelFromMem( const void * FileImage , int FileSize , int ( *FileReadFunc )( const TCHAR * FilePath , void * * FileImageAddr , int * FileSize , void * FileReadFuncData ) , int ( *FileReleaseFunc )( void * MemoryAddr , void * FileReadFuncData ) , void * FileReadFuncData ) ;
int  __stdcall dx_MV1DuplicateModel( int  SrcMHandle);
int  __stdcall dx_MV1CreateCloneModel( int  SrcMHandle);
int  __stdcall dx_MV1DeleteModel( int  MHandle);
int  __stdcall dx_MV1InitModel( void);
int  __stdcall dx_MV1SetLoadModelReMakeNormal( int  Flag);
int  __stdcall dx_MV1SetLoadModelReMakeNormalSmoothingAngle( float  SmoothingAngle );
int  __stdcall dx_MV1SetLoadModelIgnoreScaling( int  Flag);
int  __stdcall dx_MV1SetLoadModelPositionOptimize( int  Flag);
int  __stdcall dx_MV1SetLoadModelUsePhysicsMode( int  PhysicsMode);
int  __stdcall dx_MV1SetLoadModelPhysicsWorldGravity( float  Gravity);
int  __stdcall dx_MV1SetLoadCalcPhysicsWorldGravity( int  GravityNo, VECTOR  Gravity);
int  __stdcall dx_MV1SetLoadModelAnimFilePath( const char * FileName);
int  __stdcall dx_MV1SetLoadModelUsePackDraw( int  Flag);
int  __stdcall dx_MV1SaveModelToMV1File( int  MHandle, const char * FileName, int  SaveType , int  AnimMHandle , int  AnimNameCheck , int  Normal8BitFlag , int  Position16BitFlag , int  Weight8BitFlag , int  Anim16BitFlag );
int  __stdcall dx_MV1SaveModelToXFile( int  MHandle, const char * FileName, int  SaveType , int  AnimMHandle , int  AnimNameCheck );
int  __stdcall dx_MV1DrawModel( int  MHandle);
int  __stdcall dx_MV1DrawFrame( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1DrawMesh( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1DrawTriangleList( int  MHandle, int  TriangleListIndex);
int  __stdcall dx_MV1DrawModelDebug( int  MHandle, int  Color, int  IsNormalLine, float  NormalLineLength, int  IsPolyLine, int  IsCollisionBox);
int  __stdcall dx_MV1SetUseOrigShader( int  UseFlag);
int  __stdcall dx_MV1SetSemiTransDrawMode( int  DrawMode);
MATRIX  __stdcall dx_MV1GetLocalWorldMatrix( int  MHandle);
int  __stdcall dx_MV1SetPosition( int  MHandle, VECTOR  Position);
VECTOR  __stdcall dx_MV1GetPosition( int  MHandle);
int  __stdcall dx_MV1SetScale( int  MHandle, VECTOR  Scale);
VECTOR  __stdcall dx_MV1GetScale( int  MHandle);
int  __stdcall dx_MV1SetRotationXYZ( int  MHandle, VECTOR  Rotate);
VECTOR  __stdcall dx_MV1GetRotationXYZ( int  MHandle);
int  __stdcall dx_MV1SetRotationZYAxis( int  MHandle, VECTOR  ZAxisDirection, VECTOR  YAxisDirection, float  ZAxisTwistRotate);
int  __stdcall dx_MV1SetRotationMatrix( int  MHandle, MATRIX  Matrix);
MATRIX  __stdcall dx_MV1GetRotationMatrix( int  MHandle);
int  __stdcall dx_MV1SetMatrix( int  MHandle, MATRIX  Matrix);
MATRIX  __stdcall dx_MV1GetMatrix( int  MHandle);
int  __stdcall dx_MV1SetVisible( int  MHandle, int  VisibleFlag);
int  __stdcall dx_MV1GetVisible( int  MHandle);
int  __stdcall dx_MV1SetMeshCategoryVisible( int  MHandle, int  MeshCategory, int  VisibleFlag);
int  __stdcall dx_MV1GetMeshCategoryVisible( int  MHandle, int  MeshCategory);
int  __stdcall dx_MV1SetDifColorScale( int  MHandle, COLOR_F  Scale);
COLOR_F  __stdcall dx_MV1GetDifColorScale( int  MHandle);
int  __stdcall dx_MV1SetSpcColorScale( int  MHandle, COLOR_F  Scale);
COLOR_F  __stdcall dx_MV1GetSpcColorScale( int  MHandle);
int  __stdcall dx_MV1SetEmiColorScale( int  MHandle, COLOR_F  Scale);
COLOR_F  __stdcall dx_MV1GetEmiColorScale( int  MHandle);
int  __stdcall dx_MV1SetAmbColorScale( int  MHandle, COLOR_F  Scale);
COLOR_F  __stdcall dx_MV1GetAmbColorScale( int  MHandle);
int  __stdcall dx_MV1GetSemiTransState( int  MHandle);
int  __stdcall dx_MV1SetOpacityRate( int  MHandle, float  Rate);
float  __stdcall dx_MV1GetOpacityRate( int  MHandle);
int  __stdcall dx_MV1SetUseDrawMulAlphaColor( int  MHandle, int  Flag);
int  __stdcall dx_MV1GetUseDrawMulAlphaColor( int  MHandle);
int  __stdcall dx_MV1SetUseZBuffer( int  MHandle, int  Flag);
int  __stdcall dx_MV1SetWriteZBuffer( int  MHandle, int  Flag);
int  __stdcall dx_MV1SetZBufferCmpType( int  MHandle, int  CmpType);
int  __stdcall dx_MV1SetZBias( int  MHandle, int  Bias);
int  __stdcall dx_MV1SetUseVertDifColor( int  MHandle, int  UseFlag);
int  __stdcall dx_MV1SetUseVertSpcColor( int  MHandle, int  UseFlag);
int  __stdcall dx_MV1SetSampleFilterMode( int  MHandle, int  FilterMode);
int  __stdcall dx_MV1SetMaxAnisotropy( int  MHandle, int  MaxAnisotropy);
int  __stdcall dx_MV1SetWireFrameDrawFlag( int  MHandle, int  Flag);
int  __stdcall dx_MV1RefreshVertColorFromMaterial( int  MHandle);
int  __stdcall dx_MV1SetPhysicsWorldGravity( int  MHandle, VECTOR  Gravity);
int  __stdcall dx_MV1PhysicsCalculation( int  MHandle, float  MillisecondTime);
int  __stdcall dx_MV1PhysicsResetState( int  MHandle);
int  __stdcall dx_MV1SetUseShapeFlag( int  MHandle, int  UseFlag);
int  __stdcall dx_MV1GetMaterialNumberOrderFlag( int  MHandle);
int  __stdcall dx_MV1AttachAnim( int  MHandle, int  AnimIndex, int  AnimSrcMHandle , int  NameCheck );
int  __stdcall dx_MV1DetachAnim( int  MHandle, int  AttachIndex);
int  __stdcall dx_MV1SetAttachAnimTime( int  MHandle, int  AttachIndex, float  Time);
float  __stdcall dx_MV1GetAttachAnimTime( int  MHandle, int  AttachIndex);
float  __stdcall dx_MV1GetAttachAnimTotalTime( int  MHandle, int  AttachIndex);
int  __stdcall dx_MV1SetAttachAnimBlendRate( int  MHandle, int  AttachIndex, float  Rate );
float  __stdcall dx_MV1GetAttachAnimBlendRate( int  MHandle, int  AttachIndex);
int  __stdcall dx_MV1SetAttachAnimBlendRateToFrame( int  MHandle, int  AttachIndex, int  FrameIndex, float  Rate, int  SetChild );
float  __stdcall dx_MV1GetAttachAnimBlendRateToFrame( int  MHandle, int  AttachIndex, int  FrameIndex);
int  __stdcall dx_MV1GetAttachAnim( int  MHandle, int  AttachIndex);
int  __stdcall dx_MV1SetAttachAnimUseShapeFlag( int  MHandle, int  AttachIndex, int  UseFlag);
int  __stdcall dx_MV1GetAttachAnimUseShapeFlag( int  MHandle, int  AttachIndex);
VECTOR  __stdcall dx_MV1GetAttachAnimFrameLocalPosition( int  MHandle, int  AttachIndex, int  FrameIndex);
MATRIX  __stdcall dx_MV1GetAttachAnimFrameLocalMatrix( int  MHandle, int  AttachIndex, int  FrameIndex);
int  __stdcall dx_MV1GetAnimNum( int  MHandle);
const TCHAR * __stdcall dx_MV1GetAnimName( int MHandle , int AnimIndex ) ;
int  __stdcall dx_MV1SetAnimName( int  MHandle, int  AnimIndex, const char * AnimName);
int  __stdcall dx_MV1GetAnimIndex( int  MHandle, const char * AnimName);
float  __stdcall dx_MV1GetAnimTotalTime( int  MHandle, int  AnimIndex);
int  __stdcall dx_MV1GetAnimTargetFrameNum( int  MHandle, int  AnimIndex);
const TCHAR * __stdcall dx_MV1GetAnimTargetFrameName( int MHandle , int AnimIndex , int AnimFrameIndex ) ;
int  __stdcall dx_MV1GetAnimTargetFrame( int  MHandle, int  AnimIndex, int  AnimFrameIndex);
int  __stdcall dx_MV1GetAnimTargetFrameKeySetNum( int  MHandle, int  AnimIndex, int  AnimFrameIndex);
int  __stdcall dx_MV1GetAnimTargetFrameKeySet( int  MHandle, int  AnimIndex, int  AnimFrameIndex, int  Index);
int  __stdcall dx_MV1GetAnimKeySetNum( int  MHandle);
int  __stdcall dx_MV1GetAnimKeySetType( int  MHandle, int  AnimKeySetIndex);
int  __stdcall dx_MV1GetAnimKeySetDataType( int  MHandle, int  AnimKeySetIndex);
int  __stdcall dx_MV1GetAnimKeySetTimeType( int  MHandle, int  AnimKeySetIndex);
int  __stdcall dx_MV1GetAnimKeySetDataNum( int  MHandle, int  AnimKeySetIndex);
float  __stdcall dx_MV1GetAnimKeyDataTime( int  MHandle, int  AnimKeySetIndex, int  Index);
FLOAT4  __stdcall dx_MV1GetAnimKeyDataToQuaternion( int  MHandle, int  AnimKeySetIndex, int  Index);
FLOAT4  __stdcall dx_MV1GetAnimKeyDataToQuaternionFromTime( int  MHandle, int  AnimKeySetIndex, float  Time);
VECTOR  __stdcall dx_MV1GetAnimKeyDataToVector( int  MHandle, int  AnimKeySetIndex, int  Index);
VECTOR  __stdcall dx_MV1GetAnimKeyDataToVectorFromTime( int  MHandle, int  AnimKeySetIndex, float  Time);
MATRIX  __stdcall dx_MV1GetAnimKeyDataToMatrix( int  MHandle, int  AnimKeySetIndex, int  Index);
MATRIX  __stdcall dx_MV1GetAnimKeyDataToMatrixFromTime( int  MHandle, int  AnimKeySetIndex, float  Time);
float  __stdcall dx_MV1GetAnimKeyDataToFlat( int  MHandle, int  AnimKeySetIndex, int  Index);
float  __stdcall dx_MV1GetAnimKeyDataToFlatFromTime( int  MHandle, int  AnimKeySetIndex, float  Time);
float  __stdcall dx_MV1GetAnimKeyDataToLinear( int  MHandle, int  AnimKeySetIndex, int  Index);
float  __stdcall dx_MV1GetAnimKeyDataToLinearFromTime( int  MHandle, int  AnimKeySetIndex, float  Time);
int  __stdcall dx_MV1GetMaterialNum( int  MHandle);
const TCHAR * __stdcall dx_MV1GetMaterialName( int MHandle , int MaterialIndex ) ;
int  __stdcall dx_MV1SetMaterialTypeAll( int  MHandle, int  Type);
int  __stdcall dx_MV1SetMaterialType( int  MHandle, int  MaterialIndex, int  Type);
int  __stdcall dx_MV1GetMaterialType( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialDifColor( int  MHandle, int  MaterialIndex, COLOR_F  Color);
COLOR_F  __stdcall dx_MV1GetMaterialDifColor( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialSpcColor( int  MHandle, int  MaterialIndex, COLOR_F  Color);
COLOR_F  __stdcall dx_MV1GetMaterialSpcColor( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialEmiColor( int  MHandle, int  MaterialIndex, COLOR_F  Color);
COLOR_F  __stdcall dx_MV1GetMaterialEmiColor( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialAmbColor( int  MHandle, int  MaterialIndex, COLOR_F  Color);
COLOR_F  __stdcall dx_MV1GetMaterialAmbColor( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialSpcPower( int  MHandle, int  MaterialIndex, float  Power);
float  __stdcall dx_MV1GetMaterialSpcPower( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialDifMapTexture( int  MHandle, int  MaterialIndex, int  TexIndex);
int  __stdcall dx_MV1GetMaterialDifMapTexture( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialSpcMapTexture( int  MHandle, int  MaterialIndex, int  TexIndex);
int  __stdcall dx_MV1GetMaterialSpcMapTexture( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1GetMaterialNormalMapTexture( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialDifGradTexture( int  MHandle, int  MaterialIndex, int  TexIndex);
int  __stdcall dx_MV1GetMaterialDifGradTexture( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialSpcGradTexture( int  MHandle, int  MaterialIndex, int  TexIndex);
int  __stdcall dx_MV1GetMaterialSpcGradTexture( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialSphereMapTexture( int  MHandle, int  MaterialIndex, int  TexIndex);
int  __stdcall dx_MV1GetMaterialSphereMapTexture( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialDifGradBlendTypeAll( int  MHandle, int  BlendType);
int  __stdcall dx_MV1SetMaterialDifGradBlendType( int  MHandle, int  MaterialIndex, int  BlendType);
int  __stdcall dx_MV1GetMaterialDifGradBlendType( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialSpcGradBlendTypeAll( int  MHandle, int  BlendType);
int  __stdcall dx_MV1SetMaterialSpcGradBlendType( int  MHandle, int  MaterialIndex, int  BlendType);
int  __stdcall dx_MV1GetMaterialSpcGradBlendType( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialSphereMapBlendTypeAll( int  MHandle, int  BlendType);
int  __stdcall dx_MV1SetMaterialSphereMapBlendType( int  MHandle, int  MaterialIndex, int  BlendType);
int  __stdcall dx_MV1GetMaterialSphereMapBlendType( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialOutLineWidthAll( int  MHandle, float  Width);
int  __stdcall dx_MV1SetMaterialOutLineWidth( int  MHandle, int  MaterialIndex, float  Width);
float  __stdcall dx_MV1GetMaterialOutLineWidth( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialOutLineDotWidthAll( int  MHandle, float  Width);
int  __stdcall dx_MV1SetMaterialOutLineDotWidth( int  MHandle, int  MaterialIndex, float  Width);
float  __stdcall dx_MV1GetMaterialOutLineDotWidth( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialOutLineColorAll( int  MHandle, COLOR_F  Color);
int  __stdcall dx_MV1SetMaterialOutLineColor( int  MHandle, int  MaterialIndex, COLOR_F  Color);
COLOR_F  __stdcall dx_MV1GetMaterialOutLineColor( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialDrawBlendModeAll( int  MHandle, int  BlendMode);
int  __stdcall dx_MV1SetMaterialDrawBlendMode( int  MHandle, int  MaterialIndex, int  BlendMode);
int  __stdcall dx_MV1GetMaterialDrawBlendMode( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialDrawBlendParamAll( int  MHandle, int  BlendParam);
int  __stdcall dx_MV1SetMaterialDrawBlendParam( int  MHandle, int  MaterialIndex, int  BlendParam);
int  __stdcall dx_MV1GetMaterialDrawBlendParam( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1SetMaterialDrawAlphaTestAll( int  MHandle, int  Enable, int  Mode, int  Param);
int  __stdcall dx_MV1SetMaterialDrawAlphaTest( int  MHandle, int  MaterialIndex, int  Enable, int  Mode, int  Param);
int  __stdcall dx_MV1GetMaterialDrawAlphaTestEnable( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1GetMaterialDrawAlphaTestMode( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1GetMaterialDrawAlphaTestParam( int  MHandle, int  MaterialIndex);
int  __stdcall dx_MV1GetTextureNum( int  MHandle);
const TCHAR * __stdcall dx_MV1GetTextureName( int MHandle , int TexIndex ) ;
int  __stdcall dx_MV1SetTextureColorFilePath( int  MHandle, int  TexIndex, const char * FilePath);
const TCHAR * __stdcall dx_MV1GetTextureColorFilePath( int MHandle , int TexIndex ) ;
int  __stdcall dx_MV1SetTextureAlphaFilePath( int  MHandle, int  TexIndex, const char * FilePath);
const TCHAR * __stdcall dx_MV1GetTextureAlphaFilePath( int MHandle , int TexIndex ) ;
int  __stdcall dx_MV1SetTextureGraphHandle( int  MHandle, int  TexIndex, int  GrHandle, int  SemiTransFlag);
int  __stdcall dx_MV1GetTextureGraphHandle( int  MHandle, int  TexIndex);
int  __stdcall dx_MV1SetTextureAddressMode( int  MHandle, int  TexIndex, int  AddrUMode, int  AddrVMode);
int  __stdcall dx_MV1GetTextureAddressModeU( int  MHandle, int  TexIndex);
int  __stdcall dx_MV1GetTextureAddressModeV( int  MHandle, int  TexIndex);
int  __stdcall dx_MV1GetTextureWidth( int  MHandle, int  TexIndex);
int  __stdcall dx_MV1GetTextureHeight( int  MHandle, int  TexIndex);
int  __stdcall dx_MV1GetTextureSemiTransState( int  MHandle, int  TexIndex);
int  __stdcall dx_MV1SetTextureBumpImageFlag( int  MHandle, int  TexIndex, int  Flag);
int  __stdcall dx_MV1GetTextureBumpImageFlag( int  MHandle, int  TexIndex);
int  __stdcall dx_MV1SetTextureBumpImageNextPixelLength( int  MHandle, int  TexIndex, float  Length);
float  __stdcall dx_MV1GetTextureBumpImageNextPixelLength( int  MHandle, int  TexIndex);
int  __stdcall dx_MV1SetTextureSampleFilterMode( int  MHandle, int  TexIndex, int  FilterMode);
int  __stdcall dx_MV1GetTextureSampleFilterMode( int  MHandle, int  TexIndex);
int  __stdcall dx_MV1LoadTexture( const char * FilePath);
int  __stdcall dx_MV1GetFrameNum( int  MHandle);
int  __stdcall dx_MV1SearchFrame( int  MHandle, const char * FrameName);
int  __stdcall dx_MV1SearchFrameChild( int  MHandle, int  FrameIndex , const char * ChildName );
const TCHAR * __stdcall dx_MV1GetFrameName( int MHandle , int FrameIndex ) ;
int  __stdcall dx_MV1GetFrameName2( int  MHandle, int  FrameIndex, TCHAR *  StrBuffer);
int  __stdcall dx_MV1GetFrameParent( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1GetFrameChildNum( int  MHandle, int  FrameIndex );
int  __stdcall dx_MV1GetFrameChild( int  MHandle, int  FrameIndex , int  ChildIndex );
VECTOR  __stdcall dx_MV1GetFramePosition( int  MHandle, int  FrameIndex);
MATRIX  __stdcall dx_MV1GetFrameBaseLocalMatrix( int  MHandle, int  FrameIndex);
MATRIX  __stdcall dx_MV1GetFrameLocalMatrix( int  MHandle, int  FrameIndex);
MATRIX  __stdcall dx_MV1GetFrameLocalWorldMatrix( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1SetFrameUserLocalMatrix( int  MHandle, int  FrameIndex, MATRIX  Matrix);
int  __stdcall dx_MV1ResetFrameUserLocalMatrix( int  MHandle, int  FrameIndex);
VECTOR  __stdcall dx_MV1GetFrameMaxVertexLocalPosition( int  MHandle, int  FrameIndex);
VECTOR  __stdcall dx_MV1GetFrameMinVertexLocalPosition( int  MHandle, int  FrameIndex);
VECTOR  __stdcall dx_MV1GetFrameAvgVertexLocalPosition( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1GetFrameTriangleNum( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1GetFrameMeshNum( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1GetFrameMesh( int  MHandle, int  FrameIndex, int  Index);
int  __stdcall dx_MV1SetFrameVisible( int  MHandle, int  FrameIndex, int  VisibleFlag);
int  __stdcall dx_MV1GetFrameVisible( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1SetFrameDifColorScale( int  MHandle, int  FrameIndex, COLOR_F  Scale);
int  __stdcall dx_MV1SetFrameSpcColorScale( int  MHandle, int  FrameIndex, COLOR_F  Scale);
int  __stdcall dx_MV1SetFrameEmiColorScale( int  MHandle, int  FrameIndex, COLOR_F  Scale);
int  __stdcall dx_MV1SetFrameAmbColorScale( int  MHandle, int  FrameIndex, COLOR_F  Scale);
COLOR_F  __stdcall dx_MV1GetFrameDifColorScale( int  MHandle, int  FrameIndex);
COLOR_F  __stdcall dx_MV1GetFrameSpcColorScale( int  MHandle, int  FrameIndex);
COLOR_F  __stdcall dx_MV1GetFrameEmiColorScale( int  MHandle, int  FrameIndex);
COLOR_F  __stdcall dx_MV1GetFrameAmbColorScale( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1GetFrameSemiTransState( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1SetFrameOpacityRate( int  MHandle, int  FrameIndex, float  Rate);
float  __stdcall dx_MV1GetFrameOpacityRate( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1SetFrameBaseVisible( int  MHandle, int  FrameIndex, int  VisibleFlag);
int  __stdcall dx_MV1GetFrameBaseVisible( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1SetFrameTextureAddressTransform( int  MHandle, int  FrameIndex, float  TransU, float  TransV, float  ScaleU, float  ScaleV, float  RotCenterU, float  RotCenterV, float  Rotate);
int  __stdcall dx_MV1SetFrameTextureAddressTransformMatrix( int  MHandle, int  FrameIndex, MATRIX  Matrix);
int  __stdcall dx_MV1ResetFrameTextureAddressTransform( int  MHandle, int  FrameIndex);
int  __stdcall dx_MV1GetMeshNum( int  MHandle);
int  __stdcall dx_MV1GetMeshMaterial( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1GetMeshTriangleNum( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1SetMeshVisible( int  MHandle, int  MeshIndex, int  VisibleFlag);
int  __stdcall dx_MV1GetMeshVisible( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1SetMeshDifColorScale( int  MHandle, int  MeshIndex, COLOR_F  Scale);
int  __stdcall dx_MV1SetMeshSpcColorScale( int  MHandle, int  MeshIndex, COLOR_F  Scale);
int  __stdcall dx_MV1SetMeshEmiColorScale( int  MHandle, int  MeshIndex, COLOR_F  Scale);
int  __stdcall dx_MV1SetMeshAmbColorScale( int  MHandle, int  MeshIndex, COLOR_F  Scale);
COLOR_F  __stdcall dx_MV1GetMeshDifColorScale( int  MHandle, int  MeshIndex);
COLOR_F  __stdcall dx_MV1GetMeshSpcColorScale( int  MHandle, int  MeshIndex);
COLOR_F  __stdcall dx_MV1GetMeshEmiColorScale( int  MHandle, int  MeshIndex);
COLOR_F  __stdcall dx_MV1GetMeshAmbColorScale( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1SetMeshOpacityRate( int  MHandle, int  MeshIndex, float  Rate);
float  __stdcall dx_MV1GetMeshOpacityRate( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1SetMeshDrawBlendMode( int  MHandle, int  MeshIndex, int  BlendMode);
int  __stdcall dx_MV1SetMeshDrawBlendParam( int  MHandle, int  MeshIndex, int  BlendParam);
int  __stdcall dx_MV1GetMeshDrawBlendMode( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1GetMeshDrawBlendParam( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1SetMeshBaseVisible( int  MHandle, int  MeshIndex, int  VisibleFlag);
int  __stdcall dx_MV1GetMeshBaseVisible( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1SetMeshBackCulling( int  MHandle, int  MeshIndex, int  CullingFlag);
int  __stdcall dx_MV1GetMeshBackCulling( int  MHandle, int  MeshIndex);
VECTOR  __stdcall dx_MV1GetMeshMaxPosition( int  MHandle, int  MeshIndex);
VECTOR  __stdcall dx_MV1GetMeshMinPosition( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1GetMeshTListNum( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1GetMeshTList( int  MHandle, int  MeshIndex, int  Index);
int  __stdcall dx_MV1GetMeshSemiTransState( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1SetMeshUseVertDifColor( int  MHandle, int  MeshIndex, int  UseFlag);
int  __stdcall dx_MV1SetMeshUseVertSpcColor( int  MHandle, int  MeshIndex, int  UseFlag);
int  __stdcall dx_MV1GetMeshUseVertDifColor( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1GetMeshUseVertSpcColor( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1GetMeshShapeFlag( int  MHandle, int  MeshIndex);
int  __stdcall dx_MV1GetShapeNum( int  MHandle);
int  __stdcall dx_MV1SearchShape( int  MHandle, const char * ShapeName);
const TCHAR * __stdcall dx_MV1GetShapeName( int MHandle , int ShapeIndex ) ;
int  __stdcall dx_MV1GetShapeTargetMeshNum( int  MHandle, int  ShapeIndex);
int  __stdcall dx_MV1GetShapeTargetMesh( int  MHandle, int  ShapeIndex, int  Index);
int  __stdcall dx_MV1SetShapeRate( int  MHandle, int  ShapeIndex, float  Rate);
float  __stdcall dx_MV1GetShapeRate( int  MHandle, int  ShapeIndex);
int  __stdcall dx_MV1GetTriangleListNum( int  MHandle);
int  __stdcall dx_MV1GetTriangleListVertexType( int  MHandle, int  TListIndex);
int  __stdcall dx_MV1GetTriangleListPolygonNum( int  MHandle, int  TListIndex);
int  __stdcall dx_MV1GetTriangleListVertexNum( int  MHandle, int  TListIndex);
int  __stdcall dx_MV1SetupCollInfo( int  MHandle, int  FrameIndex , int  XDivNum , int  YDivNum , int  ZDivNum );
int  __stdcall dx_MV1TerminateCollInfo( int  MHandle, int  FrameIndex );
int  __stdcall dx_MV1RefreshCollInfo( int  MHandle, int  FrameIndex );
MV1_COLL_RESULT_POLY  __stdcall dx_MV1CollCheck_Line( int  MHandle, int  FrameIndex, VECTOR  PosStart, VECTOR  PosEnd);
MV1_COLL_RESULT_POLY_DIM  __stdcall dx_MV1CollCheck_LineDim( int  MHandle, int  FrameIndex, VECTOR  PosStart, VECTOR  PosEnd);
MV1_COLL_RESULT_POLY_DIM  __stdcall dx_MV1CollCheck_Sphere( int  MHandle, int  FrameIndex, VECTOR  CenterPos, float  r);
MV1_COLL_RESULT_POLY_DIM  __stdcall dx_MV1CollCheck_Capsule( int  MHandle, int  FrameIndex, VECTOR  Pos1, VECTOR  Pos2, float  r);
MV1_COLL_RESULT_POLY_DIM  __stdcall dx_MV1CollCheck_Triangle( int  MHandle, int  FrameIndex, VECTOR  Pos1, VECTOR  Pos2, VECTOR  Pos3);
MV1_COLL_RESULT_POLY  __stdcall dx_MV1CollCheck_GetResultPoly( MV1_COLL_RESULT_POLY_DIM  ResultPolyDim, int  PolyNo);
int  __stdcall dx_MV1CollResultPolyDimTerminate( MV1_COLL_RESULT_POLY_DIM  ResultPolyDim);
int  __stdcall dx_MV1SetupReferenceMesh( int  MHandle, int  FrameIndex, int  IsTransform, int  IsPositionOnly );
int  __stdcall dx_MV1TerminateReferenceMesh( int  MHandle, int  FrameIndex, int  IsTransform, int  IsPositionOnly );
int  __stdcall dx_MV1RefreshReferenceMesh( int  MHandle, int  FrameIndex, int  IsTransform, int  IsPositionOnly );
MV1_REF_POLYGONLIST __stdcall dx_MV1GetReferenceMesh( int MHandle , int FrameIndex , int IsTransform , int IsPositionOnly ) ;
]]
--====================================================================
-- version up
--====================================================================
ffi.cdef
[[
int  __stdcall dx_LoadFontDataToHandle( const char * FileName, int  EdgeSize );
int  __stdcall dx_LoadFontDataFromMemToHandle( const void * FontDataImage, int  FontDataImageSize, int  EdgeSize );
int  __stdcall dx_DrawCircleSoftImage( int  SIHandle, int  x, int  y, int  radius, int  r, int  g, int  b, int  a, int  FillFlag );
int  __stdcall dx_ConvertStringCharCodeFormat( int  SrcCharCodeFormat, const void * SrcString, int  DestCharCodeFormat, void *  DestStringBuffer);
int  __stdcall dx_SetUseCharCodeFormat( int  CharCodeFormat);
int  __stdcall dx_SetFontCharCodeFormat( int  CharCodeFormat);
int  __stdcall dx_SetFontCharCodeFormatToHandle( int  CharCodeFormat, int  FontHandle);
//====================================================================
enum 
{
     DX_CHARCODEFORMAT_SHIFTJIS = 932
    ,DX_CHARCODEFORMAT_GB2312 = 936
    ,DX_CHARCODEFORMAT_UHC = 949
    ,DX_CHARCODEFORMAT_BIG5 = 950
    ,DX_CHARCODEFORMAT_UTF16LE = 1200
    ,DX_CHARCODEFORMAT_UTF16BE = 1201
    ,DX_CHARCODEFORMAT_ASCII = 1252
    ,DX_CHARCODEFORMAT_UTF8 = 65001
    ,DX_CHARCODEFORMAT_UTF32LE = 32766
    ,DX_CHARCODEFORMAT_UTF32BE = 32767
};
]]
--====================================================================
-- load
--====================================================================
if ffi.abi '64bit' 
then
  return ffi.load 'DxLib_x64.dll'
else
  return ffi.load 'DxLib.dll'
end
--====================================================================