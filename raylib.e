--EuRaylib 6
--Written by Andy P.
--OpenEuphoria wrapper for Raylib v 6.0
--Copyright (c) 2026

include std/ffi.e
include std/machine.e
include std/os.e

public atom ray

ifdef WINDOWS then
	ray = open_dll("raylib.dll")
	elsifdef LINUX or FREEBSD then
	ray = open_dll("libraylib.so")
	elsifdef OSX then
	ray = open_dll("libraylib.dylib")
end ifdef

if ray = 0 then
	puts(1,"Failed to load raylib!\n")
	abort(0)
end if

printf(1,"%d",{ray})

public constant RAYLIB_VERSION_MAJOR = 6
public constant RAYLIB_VERSION_MINOR = 0
public constant RAYLIB_VERSION_PATCH = 0
public constant RAYLIB_VERSION = "6.0"

public constant PI = 3.14159265358979323846
public constant DEG2RAD = PI / 180.0
public constant RAD2DEG = 180.0 / PI

--Basic Colors
public constant LIGHTGRAY = {200,200,200,255}
public constant GRAY = {130,130,130,255}
public constant DARKGRAY = {80,80,80,255}
public constant YELLOW = {253,249,0,255}
public constant GOLD = {255,203,0,255}
public constant ORANGE = {255,161,0,255}
public constant PINK = {255,109,194,255}
public constant RED = {230,41,55,255}
public constant MAROON = {190,33,55,255}
public constant GREEN = {0,228,48,255}
public constant LIME = {0,158,47,255}
public constant DARKGREEN = {0,117,44,255}
public constant SKYBLUE = {102,191,255,255}
public constant BLUE = {0,121,241,255}
public constant DARKBLUE = {0,82,172,255}
public constant PURPLE = {200,122,255,255}
public constant VIOLET = {135,60,190,255}
public constant DARKPURPLE = {112,31,126,255}
public constant BEIGE = {211,176,131,255}
public constant BROWN = {127,106,79,255}
public constant DARKBROWN = {76,63,47,255}

public constant WHITE = {255,255,255,255}
public constant BLACK = {0,0,0,255}
public constant BLANK = {0,0,0,0}
public constant MAGENTA = {255,0,255,255}
public constant RAYWHITE = {245,245,245,245}

public constant VECTOR2 = define_c_struct({
	C_FLOAT, --x
	C_FLOAT  --y
})

public constant VECTOR3 = define_c_struct({
	C_FLOAT, --x
	C_FLOAT, --y
	C_FLOAT  --z
})

public constant VECTOR4 = define_c_struct({
	C_FLOAT, --x
	C_FLOAT, --y
	C_FLOAT, --z
	C_FLOAT  --w
})

public constant QUATERNION = VECTOR4 

public constant MATRIX = define_c_struct({
	C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT, --m0,m4,m8,m12
	C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT, --m1,m5,m9,m13
	C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT, --m2,m6,m10,m14
	C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT  --m3,m7,m11,m15
})

public constant COLOR = define_c_struct({
	C_UCHAR, --r
	C_UCHAR, --g
	C_UCHAR, --b
	C_UCHAR  --a
})

public constant RECTANGLE = define_c_struct({
	C_FLOAT, --x
	C_FLOAT, --y
	C_FLOAT, --width
	C_FLOAT  --height
})

public constant IMAGE = define_c_struct({
	C_POINTER, --data
	C_INT, --width
	C_INT, --height
	C_INT, --mipmaps
	C_INT  --format
})

public constant TEXTURE = define_c_struct({
	C_UINT, --id
	C_INT, --width
	C_INT, --height
	C_INT, --mipmaps
	C_INT  --format
})

public constant TEXTURE2D = TEXTURE
public constant TEXTURECUBEMAP = TEXTURE

public constant RENDERTEXTURE = define_c_struct({
	C_UINT, --id
	TEXTURE, --texture
	TEXTURE  --depth
})

public constant RENDERTEXTURE2D = RENDERTEXTURE

public constant NPATCHINFO = define_c_struct({
	RECTANGLE, --source
	C_INT, --left
	C_INT, --top
	C_INT, --right
	C_INT, --bottom
	C_INT --layout
})

public constant GLYPHINFO = define_c_struct({
	C_INT, --value
	C_INT, --offsetX
	C_INT, --offsetY
	C_INT, --advanceX
	IMAGE  --image
})

public constant FONT = define_c_struct({
	C_INT, --baseSize
	C_INT, --glyphCount
	C_INT, --glyphPadding
	TEXTURE2D, --texture
	C_POINTER, --rects (rectangle)
	C_POINTER  --glyphs (GlyphInfo)
})

public constant CAMERA3D = define_c_struct({
	VECTOR3, --position
	VECTOR3, --target
	VECTOR3, --up
	C_FLOAT, --fovy
	C_INT  --projection
})

public constant CAMERA = CAMERA3D

public constant CAMERA2D = define_c_struct({
	VECTOR2, --offset
	VECTOR2, --target
	C_FLOAT, --rotation
	C_FLOAT  --zoom
})

public constant MESH = define_c_struct({
	C_INT, --vertexCount
	C_INT, --triangleCount
	C_POINTER, --vertices
	C_POINTER, --texcoords
	C_POINTER, --texcoords2
	C_POINTER, --normals
	C_POINTER, --tangents
	C_POINTER, --colors
	C_POINTER, --indices
	C_INT, --boneCount
	C_POINTER, --boneIndices
	C_POINTER, --boneWeights
	C_POINTER, --animVertices
	C_POINTER, --animNormals
	C_UINT, --vaoID
	C_POINTER --vboId
})

public constant SHADER = define_c_struct({
	C_UINT, --id
	C_POINTER --locs
})

public constant MATERIALMAP = define_c_struct({
	TEXTURE2D, --texture
	COLOR, --color
	C_FLOAT --value
})

public constant MATERIAL = define_c_struct({
	SHADER, --shader
	C_POINTER, --maps MaterialMap
	{C_FLOAT,4} --params[4]
})

public constant TRANSFORM = define_c_struct({
	VECTOR3, --translation
	QUATERNION, --rotation
	VECTOR3 --scale
})

public constant BONEINFO = define_c_struct({
	{C_CHAR,32}, --name char[32]
	C_INT --parent
})

public constant MODELSKELETON = define_c_struct({
	C_INT, --boneCount
	C_POINTER, --bones BoneInfo
	C_POINTER --bindPose MdelAnimPose (Transform) array/pointer
})

public constant MODEL = define_c_struct({
	MATRIX, --transform
	C_INT, --meshCount
	C_INT, --materialCount
	C_POINTER, --meshes M<esh
	C_POINTER, --materials Material
	C_POINTER, --meshMaterial
	
	MODELSKELETON, --skeleton
	C_POINTER, --currentPose Transform[] pointer
	C_POINTER --bondMatrices Matrix
})

public constant MODELANIMATION = define_c_struct({
	{C_CHAR,32}, --name[32]
	C_INT, --boneCount
	C_INT, --keyframeCount
	C_POINTER --keyframePoses
})

public constant RAY = define_c_struct({
	VECTOR3, --position
	VECTOR3  --direction
})

public constant RAYCOLLISION = define_c_struct({
	C_BOOL, --hit
	C_FLOAT, --distance
	VECTOR3, --point
	VECTOR3 --normal
})

public constant BOUNDINGBOX = define_c_struct({
	VECTOR3, --min
	VECTOR3  --max
})

public constant WAVE = define_c_struct({
	C_UINT, --frameCount
	C_UINT, --sampleRate
	C_UINT, --sampleSize
	C_UINT, --channels
	C_POINTER --data
})

public constant AUDIOSTREAM = define_c_struct({
	C_POINTER, --buffer
	C_POINTER, --processor
	C_UINT, --sampleRate
	C_UINT, --sampleSize
	C_UINT --channels
})

public constant SOUND = define_c_struct({
	AUDIOSTREAM, --stream
	C_UINT --frameCount
})

public constant MUSIC = define_c_struct({
	AUDIOSTREAM, --stream
	C_UINT, --frameCount
	C_BOOL, --looping
	C_INT, --ctxType
	C_POINTER --ctxData
})

public constant VRDEVICEINFO = define_c_struct({
	C_INT, --hResolutin
	C_INT, --vResolutin
	C_FLOAT, --hScreenSize
	C_FLOAT, --vScreenSize
	C_FLOAT, --eyeToScreenDistance
	C_FLOAT, --lensSeparationDistance
	C_FLOAT, --interpupillaryDistance
	{C_FLOAT,4}, --lensDistortionValues[4]
	{C_FLOAT,4}  --chromaAbCorrection[4]
})

public constant VRSTEREOCONFIG = define_c_struct({
	{MATRIX,2}, --projection[2]
	{MATRIX,2}, --viewOffset[2]
	{C_FLOAT,2}, --leftLensCenter[2]
	{C_FLOAT,2}, --rightLensCenter[2]
	{C_FLOAT,2}, --leftScreenCenter[2]
	{C_FLOAT,2}, --rightScreenCenter[2]
	{C_FLOAT,2}, --scale[2]
	{C_FLOAT,2} --scaleIn[2]
})

public constant FILEPATHLIST = define_c_struct({
	C_UINT, --id
	C_POINTER --paths
})

public constant AUTOMATIONEVENT = define_c_struct({
	C_UINT, --frame
	C_UINT, --type
	{C_INT,4} --params[4]
})

public constant AUTOMATIONEVENTLIST = define_c_struct({
	C_UINT, --capacity
	C_UINT, --count
	C_POINTER --events
})

--Enums
public enum type ConfigFlags
	FLAG_VSYNC_HINT         = 0x00000040,   --// Set to try enabling V-Sync on GPU
    FLAG_FULLSCREEN_MODE    = 0x00000002,   --// Set to run program in fullscreen
    FLAG_WINDOW_RESIZABLE   = 0x00000004,   --// Set to allow resizable window
    FLAG_WINDOW_UNDECORATED = 0x00000008,   --// Set to disable window decoration (frame and buttons)
    FLAG_WINDOW_HIDDEN      = 0x00000080,   --// Set to hide window
    FLAG_WINDOW_MINIMIZED   = 0x00000200,   --// Set to minimize window (iconify)
    FLAG_WINDOW_MAXIMIZED   = 0x00000400,   --// Set to maximize window (expanded to monitor)
    FLAG_WINDOW_UNFOCUSED   = 0x00000800,   --// Set to window non focused
    FLAG_WINDOW_TOPMOST     = 0x00001000,   --// Set to window always on top
    FLAG_WINDOW_ALWAYS_RUN  = 0x00000100,   --// Set to allow windows running while minimized
    FLAG_WINDOW_TRANSPARENT = 0x00000010,   --// Set to allow transparent framebuffer
    FLAG_WINDOW_HIGHDPI     = 0x00002000,   --// Set to support HighDPI
    FLAG_WINDOW_MOUSE_PASSTHROUGH = 0x00004000, --// Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
    FLAG_BORDERLESS_WINDOWED_MODE = 0x00008000, --// Set to run program in borderless windowed mode
    FLAG_MSAA_4X_HINT       = 0x00000020,   --// Set to try enabling MSAA 4X
    FLAG_INTERLACED_HINT    = 0x00010000    --// Set to try enabling interlaced video format (for V3D)
end type

public enum type TraceLogLevel
	LOG_ALL = 0,       -- // Display all logs
    LOG_TRACE,          --// Trace logging, intended for internal use only
    LOG_DEBUG,          --// Debug logging, used for internal debugging, it should be disabled on release builds
    LOG_INFO,           --// Info logging, used for program execution info
    LOG_WARNING,        --// Warning logging, used on recoverable failures
    LOG_ERROR,          --// Error logging, used on unrecoverable failures
    LOG_FATAL,          --// Fatal logging, used to abort program: exit(EXIT_FAILURE)
    LOG_NONE            --// Disable logging
end type

public enum type KeyboardKey
	KEY_NULL            = 0,        --// Key: NULL, used for no key pressed
    --// Alphanumeric keys
    KEY_APOSTROPHE      = 39,     --  // Key: '
    KEY_COMMA           = 44,      -- // Key: ,
    KEY_MINUS           = 45,      -- // Key: -
    KEY_PERIOD          = 46,      -- // Key: .
    KEY_SLASH           = 47,      -- // Key: /
    KEY_ZERO            = 48,      -- // Key: 0
    KEY_ONE             = 49,      -- // Key: 1
    KEY_TWO             = 50,      -- // Key: 2
    KEY_THREE           = 51,      -- // Key: 3
    KEY_FOUR            = 52,      -- // Key: 4
    KEY_FIVE            = 53,      -- // Key: 5
    KEY_SIX             = 54,      -- // Key: 6
    KEY_SEVEN           = 55,      -- // Key: 7
    KEY_EIGHT           = 56,       --// Key: 8
    KEY_NINE            = 57,       --// Key: 9
    KEY_SEMICOLON       = 59,       --// Key: ;
    KEY_EQUAL           = 61,       --// Key: =
    KEY_A               = 65,       --// Key: A | a
    KEY_B               = 66,       --// Key: B | b
    KEY_C               = 67,      -- // Key: C | c
    KEY_D               = 68,       --// Key: D | d
    KEY_E               = 69,       --// Key: E | e
    KEY_F               = 70,       --// Key: F | f
    KEY_G               = 71,       --// Key: G | g
    KEY_H               = 72,       --// Key: H | h
    KEY_I               = 73,       --// Key: I | i
    KEY_J               = 74,       --// Key: J | j
    KEY_K               = 75,       --// Key: K | k
    KEY_L               = 76,       --// Key: L | l
    KEY_M               = 77,       --// Key: M | m
    KEY_N               = 78,       --// Key: N | n
    KEY_O               = 79,       --// Key: O | o
    KEY_P               = 80,       --// Key: P | p
    KEY_Q               = 81,       --// Key: Q | q
    KEY_R               = 82,       --// Key: R | r
    KEY_S               = 83,       --// Key: S | s
    KEY_T               = 84,       --// Key: T | t
    KEY_U               = 85,       --// Key: U | u
    KEY_V               = 86,       --// Key: V | v
    KEY_W               = 87,       --// Key: W | w
    KEY_X               = 88,       --// Key: X | x
    KEY_Y               = 89,       --// Key: Y | y
    KEY_Z               = 90,       --// Key: Z | z
    KEY_LEFT_BRACKET    = 91,       --// Key: [
    KEY_BACKSLASH       = 92,       --// Key: '\'
    KEY_RIGHT_BRACKET   = 93,       --// Key: ]
    KEY_GRAVE           = 96,       --// Key: `
    --// Function keys
    KEY_SPACE           = 32,       --// Key: Space
    KEY_ESCAPE          = 256,      --// Key: Esc
    KEY_ENTER           = 257,      --// Key: Enter
    KEY_TAB             = 258,      --// Key: Tab
    KEY_BACKSPACE       = 259,      --// Key: Backspace
    KEY_INSERT          = 260,      --// Key: Ins
    KEY_DELETE          = 261,      --// Key: Del
    KEY_RIGHT           = 262,      --// Key: Cursor right
    KEY_LEFT            = 263,      --// Key: Cursor left
    KEY_DOWN            = 264,      --// Key: Cursor down
    KEY_UP              = 265,      --// Key: Cursor up
    KEY_PAGE_UP         = 266,      --// Key: Page up
    KEY_PAGE_DOWN       = 267,      --// Key: Page down
    KEY_HOME            = 268,      --// Key: Home
    KEY_END             = 269,      --// Key: End
    KEY_CAPS_LOCK       = 280,      --// Key: Caps lock
    KEY_SCROLL_LOCK     = 281,      --// Key: Scroll down
    KEY_NUM_LOCK        = 282,      --// Key: Num lock
    KEY_PRINT_SCREEN    = 283,      --// Key: Print screen
    KEY_PAUSE           = 284,      --// Key: Pause
    KEY_F1              = 290,      --// Key: F1
    KEY_F2              = 291,      --// Key: F2
    KEY_F3              = 292,      --// Key: F3
    KEY_F4              = 293,      --// Key: F4
    KEY_F5              = 294,      --// Key: F5
    KEY_F6              = 295,      --// Key: F6
    KEY_F7              = 296,      --// Key: F7
    KEY_F8              = 297,      --// Key: F8
    KEY_F9              = 298,      --// Key: F9
    KEY_F10             = 299,      --// Key: F10
    KEY_F11             = 300,      --// Key: F11
    KEY_F12             = 301,      --// Key: F12
    KEY_LEFT_SHIFT      = 340,      --// Key: Shift left
    KEY_LEFT_CONTROL    = 341,      --// Key: Control left
    KEY_LEFT_ALT        = 342,      --// Key: Alt left
    KEY_LEFT_SUPER      = 343,      --// Key: Super left
    KEY_RIGHT_SHIFT     = 344,      --// Key: Shift right
    KEY_RIGHT_CONTROL   = 345,      --// Key: Control right
    KEY_RIGHT_ALT       = 346,      --// Key: Alt right
    KEY_RIGHT_SUPER     = 347,      --// Key: Super right
    KEY_KB_MENU         = 348,      --// Key: KB menu
    --// Keypad keys
    KEY_KP_0            = 320,      --// Key: Keypad 0
    KEY_KP_1            = 321,      --// Key: Keypad 1
    KEY_KP_2            = 322,      --// Key: Keypad 2
    KEY_KP_3            = 323,      --// Key: Keypad 3
    KEY_KP_4            = 324,      --// Key: Keypad 4
    KEY_KP_5            = 325,      --// Key: Keypad 5
    KEY_KP_6            = 326,      --// Key: Keypad 6
    KEY_KP_7            = 327,      --// Key: Keypad 7
    KEY_KP_8            = 328,      --// Key: Keypad 8
    KEY_KP_9            = 329,      --// Key: Keypad 9
    KEY_KP_DECIMAL      = 330,      --// Key: Keypad .
    KEY_KP_DIVIDE       = 331,      --// Key: Keypad /
    KEY_KP_MULTIPLY     = 332,      --// Key: Keypad *
    KEY_KP_SUBTRACT     = 333,      --// Key: Keypad -
    KEY_KP_ADD          = 334,      --// Key: Keypad +
    KEY_KP_ENTER        = 335,      --// Key: Keypad Enter
    KEY_KP_EQUAL        = 336,      --// Key: Keypad =
    --// Android key buttons
    KEY_BACK            = 4,        --// Key: Android back button
    KEY_MENU            = 5,        --// Key: Android menu button
    KEY_VOLUME_UP       = 24,       --// Key: Android volume up button
    KEY_VOLUME_DOWN     = 25        --// Key: Android volume down button
end type

public enum type MOUSEBUTTON
	MOUSE_BUTTON_LEFT    = 0,       --// Mouse button left
    MOUSE_BUTTON_RIGHT   = 1,       --// Mouse button right
    MOUSE_BUTTON_MIDDLE  = 2,       --// Mouse button middle (pressed wheel)
    MOUSE_BUTTON_SIDE    = 3,       --// Mouse button side (advanced mouse device)
    MOUSE_BUTTON_EXTRA   = 4,       --// Mouse button extra (advanced mouse device)
    MOUSE_BUTTON_FORWARD = 5,       --// Mouse button forward (advanced mouse device)
    MOUSE_BUTTON_BACK    = 6       --// Mouse button back (advanced mouse device)
end type

public enum type MOUSECURSOR
	MOUSE_CURSOR_DEFAULT       = 0,    -- // Default pointer shape
    MOUSE_CURSOR_ARROW         = 1,    -- // Arrow shape
    MOUSE_CURSOR_IBEAM         = 2,    -- // Text writing cursor shape
    MOUSE_CURSOR_CROSSHAIR     = 3,    -- // Cross shape
    MOUSE_CURSOR_POINTING_HAND = 4,    -- // Pointing hand cursor
    MOUSE_CURSOR_RESIZE_EW     = 5,    -- // Horizontal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NS     = 6,    -- // Vertical resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NWSE   = 7,    -- // Top-left to bottom-right diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NESW   = 8,    -- // The top-right to bottom-left diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_ALL    = 9,    -- // The omnidirectional resize/move cursor shape
    MOUSE_CURSOR_NOT_ALLOWED   = 10    -- // The operation-not-allowed shape
end type

public enum type GAMEPADBUTTON
	GAMEPAD_BUTTON_UNKNOWN = 0,        -- // Unknown button, for error checking
    GAMEPAD_BUTTON_LEFT_FACE_UP,       -- // Gamepad left DPAD up button
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT,     --// Gamepad left DPAD right button
    GAMEPAD_BUTTON_LEFT_FACE_DOWN,      --// Gamepad left DPAD down button
    GAMEPAD_BUTTON_LEFT_FACE_LEFT,      --// Gamepad left DPAD left button
    GAMEPAD_BUTTON_RIGHT_FACE_UP,       --// Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT,    --// Gamepad right button right (i.e. PS3: Circle, Xbox: B)
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN,     --// Gamepad right button down (i.e. PS3: Cross, Xbox: A)
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT,     --// Gamepad right button left (i.e. PS3: Square, Xbox: X)
    GAMEPAD_BUTTON_LEFT_TRIGGER_1,      --// Gamepad top/back trigger left (first), it could be a trailing button
    GAMEPAD_BUTTON_LEFT_TRIGGER_2,      --// Gamepad top/back trigger left (second), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1,     --// Gamepad top/back trigger right (first), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2,     --// Gamepad top/back trigger right (second), it could be a trailing button
    GAMEPAD_BUTTON_MIDDLE_LEFT,         --// Gamepad center buttons, left one (i.e. PS3: Select)
    GAMEPAD_BUTTON_MIDDLE,              --// Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
    GAMEPAD_BUTTON_MIDDLE_RIGHT,        --// Gamepad center buttons, right one (i.e. PS3: Start)
    GAMEPAD_BUTTON_LEFT_THUMB,          --// Gamepad joystick pressed button left
    GAMEPAD_BUTTON_RIGHT_THUMB          --// Gamepad joystick pressed button right
end type

public enum type GAMEPADAXIS
	GAMEPAD_AXIS_LEFT_X        = 0,    -- // Gamepad left stick X axis
    GAMEPAD_AXIS_LEFT_Y        = 1,    -- // Gamepad left stick Y axis
    GAMEPAD_AXIS_RIGHT_X       = 2,    -- // Gamepad right stick X axis
    GAMEPAD_AXIS_RIGHT_Y       = 3,    -- // Gamepad right stick Y axis
    GAMEPAD_AXIS_LEFT_TRIGGER  = 4,    -- // Gamepad back trigger left, pressure level: [1..-1]
    GAMEPAD_AXIS_RIGHT_TRIGGER = 5     -- // Gamepad back trigger right, pressure level: [1..-1]
end type

public enum type MATERIALMAPINDEX
	MATERIAL_MAP_ALBEDO = 0,      --  // Albedo material (same as: MATERIAL_MAP_DIFFUSE)
    MATERIAL_MAP_METALNESS,       --  // Metalness material (same as: MATERIAL_MAP_SPECULAR)
    MATERIAL_MAP_NORMAL,          --  // Normal material
    MATERIAL_MAP_ROUGHNESS,        -- // Roughness material
    MATERIAL_MAP_OCCLUSION,        -- // Ambient occlusion material
    MATERIAL_MAP_EMISSION,         -- // Emission material
    MATERIAL_MAP_HEIGHT,           -- // Heightmap material
    MATERIAL_MAP_CUBEMAP,          -- // Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_IRRADIANCE,       -- // Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_PREFILTER,        -- // Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_BRDF              -- // Brdf material
end type

public constant MATERIAL_MAP_DIFFUSE = MATERIAL_MAP_ALBEDO
public constant MATERIAL_MAP_SPECULAR = MATERIAL_MAP_METALNESS

public enum type SHADERLOCATIONINDEX
	 SHADER_LOC_VERTEX_POSITION = 0, --// Shader location: vertex attribute: position
    SHADER_LOC_VERTEX_TEXCOORD01,  -- // Shader location: vertex attribute: texcoord01
    SHADER_LOC_VERTEX_TEXCOORD02,  -- // Shader location: vertex attribute: texcoord02
    SHADER_LOC_VERTEX_NORMAL,      -- // Shader location: vertex attribute: normal
    SHADER_LOC_VERTEX_TANGENT,     -- // Shader location: vertex attribute: tangent
    SHADER_LOC_VERTEX_COLOR,       -- // Shader location: vertex attribute: color
    SHADER_LOC_MATRIX_MVP,         -- // Shader location: matrix uniform: model-view-projection
    SHADER_LOC_MATRIX_VIEW,         --// Shader location: matrix uniform: view (camera transform)
    SHADER_LOC_MATRIX_PROJECTION,   --// Shader location: matrix uniform: projection
    SHADER_LOC_MATRIX_MODEL,        --// Shader location: matrix uniform: model (transform)
    SHADER_LOC_MATRIX_NORMAL,       --// Shader location: matrix uniform: normal
    SHADER_LOC_VECTOR_VIEW,         --// Shader location: vector uniform: view
    SHADER_LOC_COLOR_DIFFUSE,       --// Shader location: vector uniform: diffuse color
    SHADER_LOC_COLOR_SPECULAR,      --// Shader location: vector uniform: specular color
    SHADER_LOC_COLOR_AMBIENT,       --// Shader location: vector uniform: ambient color
    SHADER_LOC_MAP_ALBEDO,          --// Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
    SHADER_LOC_MAP_METALNESS,       --// Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
    SHADER_LOC_MAP_NORMAL,          --// Shader location: sampler2d texture: normal
    SHADER_LOC_MAP_ROUGHNESS,       --// Shader location: sampler2d texture: roughness
    SHADER_LOC_MAP_OCCLUSION,       --// Shader location: sampler2d texture: occlusion
    SHADER_LOC_MAP_EMISSION,        --// Shader location: sampler2d texture: emission
    SHADER_LOC_MAP_HEIGHT,          --// Shader location: sampler2d texture: heightmap
    SHADER_LOC_MAP_CUBEMAP,         --// Shader location: samplerCube texture: cubemap
    SHADER_LOC_MAP_IRRADIANCE,      --// Shader location: samplerCube texture: irradiance
    SHADER_LOC_MAP_PREFILTER,       --// Shader location: samplerCube texture: prefilter
    SHADER_LOC_MAP_BRDF,            --// Shader location: sampler2d texture: brdf
    SHADER_LOC_VERTEX_BONEIDS,      --// Shader location: vertex attribute: bone indices
    SHADER_LOC_VERTEX_BONEWEIGHTS,  --// Shader location: vertex attribute: bone weights
    SHADER_LOC_MATRIX_BONETRANSFORMS, --// Shader location: matrix attribute: bone transforms (animation)
    SHADER_LOC_VERTEX_INSTANCETRANSFORM --// Shader location: vertex attribute: instance transforms
end type

public constant SHADER_LOC_MAP_DIFFUSE = SHADER_LOC_MAP_ALBEDO
public constant SHADER_LOC_MAP_SPECULAR = SHADER_LOC_MAP_METALNESS

public enum type SHADERUNIFORMDATATYPE
	SHADER_UNIFORM_FLOAT = 0,      -- // Shader uniform type: float
    SHADER_UNIFORM_VEC2,           -- // Shader uniform type: vec2 (2 float)
    SHADER_UNIFORM_VEC3,           -- // Shader uniform type: vec3 (3 float)
    SHADER_UNIFORM_VEC4,           -- // Shader uniform type: vec4 (4 float)
    SHADER_UNIFORM_INT,            -- // Shader uniform type: int
    SHADER_UNIFORM_IVEC2,          -- // Shader uniform type: ivec2 (2 int)
    SHADER_UNIFORM_IVEC3,          -- // Shader uniform type: ivec3 (3 int)
    SHADER_UNIFORM_IVEC4,           --// Shader uniform type: ivec4 (4 int)
    SHADER_UNIFORM_UINT,            --// Shader uniform type: unsigned int
    SHADER_UNIFORM_UIVEC2,          --// Shader uniform type: uivec2 (2 unsigned int)
    SHADER_UNIFORM_UIVEC3,          --// Shader uniform type: uivec3 (3 unsigned int)
    SHADER_UNIFORM_UIVEC4,          --// Shader uniform type: uivec4 (4 unsigned int)
    SHADER_UNIFORM_SAMPLER2D        --// Shader uniform type: sampler2d
end type

public enum type SHADERATTRIBUTEDATATYPE
	SHADER_ATTRIB_FLOAT = 0,      --  // Shader attribute type: float
    SHADER_ATTRIB_VEC2,            -- // Shader attribute type: vec2 (2 float)
    SHADER_ATTRIB_VEC3,             --// Shader attribute type: vec3 (3 float)
    SHADER_ATTRIB_VEC4              --// Shader attribute type: vec4 (4 float)
end type

public enum type PIXELFORMAT
	PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1, --// 8 bit per pixel (no alpha)
    PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,    --// 8*2 bpp (2 channels)
    PIXELFORMAT_UNCOMPRESSED_R5G6B5,        --// 16 bpp
    PIXELFORMAT_UNCOMPRESSED_R8G8B8,        --// 24 bpp
    PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,      --// 16 bpp (1 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,      --// 16 bpp (4 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,      --// 32 bpp
    PIXELFORMAT_UNCOMPRESSED_R32,           --// 32 bpp (1 channel - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32,     --// 32*3 bpp (3 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,  --// 32*4 bpp (4 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R16,           --// 16 bpp (1 channel - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16,     --// 16*3 bpp (3 channels - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16A16,  --// 16*4 bpp (4 channels - half float)
    PIXELFORMAT_COMPRESSED_DXT1_RGB,        --// 4 bpp (no alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGBA,       --// 4 bpp (1 bit alpha)
    PIXELFORMAT_COMPRESSED_DXT3_RGBA,       --// 8 bpp
    PIXELFORMAT_COMPRESSED_DXT5_RGBA,       --// 8 bpp
    PIXELFORMAT_COMPRESSED_ETC1_RGB,        --// 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_RGB,        --// 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,   --// 8 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGB,        --// 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGBA,       --// 4 bpp
    PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA,   --// 8 bpp
    PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA    --// 2 bpp
end type

public enum type TEXTUREFILTER
	 TEXTURE_FILTER_POINT = 0,          --     // No filter, pixel approximation
    TEXTURE_FILTER_BILINEAR,            --    // Linear filtering
    TEXTURE_FILTER_TRILINEAR,             --  // Trilinear filtering (linear with mipmaps)
    TEXTURE_FILTER_ANISOTROPIC_4X,         -- // Anisotropic filtering 4x
    TEXTURE_FILTER_ANISOTROPIC_8X,          --// Anisotropic filtering 8x
    TEXTURE_FILTER_ANISOTROPIC_16X        -- // Anisotropic filtering 16x
end type

public enum type TEXTUREWRAP
	 TEXTURE_WRAP_REPEAT = 0,            --    // Repeats texture in tiled mode
    TEXTURE_WRAP_CLAMP,                   --  // Clamps texture to edge pixel in tiled mode
    TEXTURE_WRAP_MIRROR_REPEAT,          --   // Mirrors and repeats the texture in tiled mode
    TEXTURE_WRAP_MIRROR_CLAMP            --   // Mirrors and clamps to border the texture in tiled mode
end type

public enum type CUBEMAPLAYOUT
	 CUBEMAP_LAYOUT_AUTO_DETECT = 0,       --  // Automatically detect layout type
    CUBEMAP_LAYOUT_LINE_VERTICAL,          -- // Layout is defined by a vertical line with faces
    CUBEMAP_LAYOUT_LINE_HORIZONTAL,        -- // Layout is defined by a horizontal line with faces
    CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR,    -- // Layout is defined by a 3x4 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE     --// Layout is defined by a 4x3 cross with cubemap faces
end type

public enum type FONTTYPE
	 FONT_DEFAULT = 0,        --       // Default font generation, anti-aliased
    FONT_BITMAP,               --     // Bitmap font generation, no anti-aliasing
    FONT_SDF                    --    // SDF font generation, requires external shader
end type

public enum type BLENDMODE
	BLEND_ALPHA = 0,              --  // Blend textures considering alpha (default)
    BLEND_ADDITIVE,                -- // Blend textures adding colors
    BLEND_MULTIPLIED,               --// Blend textures multiplying colors
    BLEND_ADD_COLORS,               --// Blend textures adding colors (alternative)
    BLEND_SUBTRACT_COLORS,          --// Blend textures subtracting colors (alternative)
    BLEND_ALPHA_PREMULTIPLY,        --// Blend premultiplied textures considering alpha
    BLEND_CUSTOM,                   --// Blend textures using custom src/dst factors (use rlSetBlendFactors())
    BLEND_CUSTOM_SEPARATE           --// Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate())
end type

public enum type GESTURE
	 GESTURE_NONE        = 0,     --   // No gesture
    GESTURE_TAP         = 1,       -- // Tap gesture
    GESTURE_DOUBLETAP   = 2,       -- // Double tap gesture
    GESTURE_HOLD        = 4,       -- // Hold gesture
    GESTURE_DRAG        = 8,        --// Drag gesture
    GESTURE_SWIPE_RIGHT = 16,       --// Swipe right gesture
    GESTURE_SWIPE_LEFT  = 32,       --// Swipe left gesture
    GESTURE_SWIPE_UP    = 64,       --// Swipe up gesture
    GESTURE_SWIPE_DOWN  = 128,      --// Swipe down gesture
    GESTURE_PINCH_IN    = 256,      --// Pinch in gesture
    GESTURE_PINCH_OUT   = 512       --// Pinch out gesture
end type

public enum type CAMERAMODE
	 CAMERA_CUSTOM = 0,            --  // Camera custom, controlled by user (UpdateCamera() does nothing)
    CAMERA_FREE,                   -- // Camera free mode
    CAMERA_ORBITAL,                -- // Camera orbital, around target, zoom supported
    CAMERA_FIRST_PERSON,            --// Camera first person
    CAMERA_THIRD_PERSON             --// Camera third person
end type

public enum type CAMERAPROJECTION
	  CAMERA_PERSPECTIVE = 0,     --    // Perspective projection
    CAMERA_ORTHOGRAPHIC            -- // Orthographic projection
end type

public enum type NPATCHLAYOUT
	NPATCH_NINE_PATCH = 0,          --// Npatch layout: 3x3 tiles
    NPATCH_THREE_PATCH_VERTICAL,    --// Npatch layout: 1x3 tiles
    NPATCH_THREE_PATCH_HORIZONTAL   --// Npatch layout: 3x1 tiles
end type

--Window Functions
public constant xInitWindow = define_c_proc(ray,"+InitWindow",{C_INT,C_INT,C_STRING}),
				xCloseWindow = define_c_proc(ray,"+CloseWindow",{}),
				xWindowShouldClose = define_c_func(ray,"+WindowShouldClose",{},C_BOOL),
				xIsWindowReady = define_c_func(ray,"+IsWindowReady",{},C_BOOL),
				xIsWindowFullscreen = define_c_func(ray,"+IsWindowFullscreen",{},C_BOOL),
				xIsWindowHidden = define_c_func(ray,"+IsWindowHidden",{},C_BOOL),
				xIsWindowMinimized = define_c_func(ray,"+IsWindowMinimized",{},C_BOOL),
				xIsWindowMaximized = define_c_func(ray,"+IsWindowMaximized",{},C_BOOL),
				xIsWindowFocused = define_c_func(ray,"+IsWindowFocused",{},C_BOOL),
				xIsWindowResized = define_c_func(ray,"+IsWindowResized",{},C_BOOL),
				xIsWindowState = define_c_func(ray,"+IsWindowState",{C_UINT},C_BOOL),
				xSetWindowState = define_c_proc(ray,"+SetWindowState",{C_UINT}),
				xClearWindowState = define_c_proc(ray,"+ClearWindowState",{C_UINT}),
				xToggleFullscreen = define_c_proc(ray,"+ToggleFullscreen",{}),
				xToggleBorderlessWindowed = define_c_proc(ray,"+ToggleBorderlessWindowed",{}),
				xMaximizeWindow = define_c_proc(ray,"+MaximizeWindow",{}),
				xMinimizeWindow = define_c_proc(ray,"+MinimizeWindow",{}),
				xRestoreWindow = define_c_proc(ray,"+RestoreWindow",{}),
				xSetWindowIcon = define_c_proc(ray,"+SetWindowIcon",{IMAGE}),
				xSetWindowIcons = define_c_proc(ray,"+SetWindowIcons",{C_POINTER,C_INT}),
				xSetWindowTitle = define_c_proc(ray,"+SetWindowTitle",{C_STRING}),
				xSetWindowPosition = define_c_proc(ray,"+SetWindowPosition",{C_INT,C_INT}),
				xSetWindowMonitor = define_c_proc(ray,"+SetWindowMonitor",{C_INT}),
				xSetWindowMinSize = define_c_proc(ray,"+SetWindowMinSize",{C_INT,C_INT}),
				xSetWindowMaxSize = define_c_proc(ray,"+SetWindowMaxSize",{C_INT,C_INT}),
				xSetWindowSize = define_c_proc(ray,"+SetWindowSize",{C_INT,C_INT}),
				xSetWindowOpacity = define_c_proc(ray,"+SetWindowOpacity",{C_FLOAT}),
				xSetWindowFocused = define_c_proc(ray,"+SetWindowFocused",{}),
				xGetWindowHandle = define_c_func(ray,"+GetWindowHandle",{},C_POINTER),
				xGetScreenWidth = define_c_func(ray,"+GetScreenWidth",{},C_INT),
				xGetScreenHeight = define_c_func(ray,"+GetScreenHeight",{},C_INT),
				xGetRenderWidth = define_c_func(ray,"+GetRenderWidth",{},C_INT),
				xGetRenderHeight = define_c_func(ray,"+GetRenderHeight",{},C_INT),
				xGetMonitorCount = define_c_func(ray,"+GetMonitorCount",{},C_INT),
				xGetCurrentMonitor = define_c_func(ray,"+GetCurrentMonitor",{},C_INT),
				xGetMonitorPosition = define_c_func(ray,"+GetMonitorPosition",{C_INT},VECTOR2),
				xGetMonitorWidth = define_c_func(ray,"+GetMonitorWidth",{C_INT},C_INT),
				xGetMonitorHeight = define_c_func(ray,"+GetMonitorHeight",{C_INT},C_INT),
				xGetMonitorPhysicalWidth = define_c_func(ray,"+GetMonitorPhysicalWidth",{C_INT},C_INT),
				xGetMonitorPhysicalHeight = define_c_func(ray,"+GetMonitorPhysicalHeight",{C_INT},C_INT),
				xGetMonitorRefreshRate = define_c_func(ray,"+GetMonitorRefreshRate",{C_INT},C_INT),
				xGetWindowPosition = define_c_func(ray,"+GetWindowPosition",{},VECTOR2),
				xGetWindowScaleDPI = define_c_func(ray,"+GetWindowScaleDPI",{},VECTOR2),
				xGetMonitorName = define_c_func(ray,"+GetMonitorName",{C_INT},C_STRING),
				xSetClipboardText = define_c_proc(ray,"+SetClipboardText",{C_STRING}),
				xGetClipboardText = define_c_func(ray,"+GetClipboardText",{},C_STRING),
				xGetClipboardImage = define_c_func(ray,"+GetClipboardImage",{},IMAGE),
				xEnableEventWaiting = define_c_proc(ray,"+EnableEventWaiting",{}),
				xDisableEventWaiting = define_c_proc(ray,"+DisableEventWaiting",{})

public procedure InitWindow(atom width,atom height,sequence title)
	c_proc(xInitWindow,{width,height,title})
end procedure

public procedure CloseWindow()
	c_proc(xCloseWindow,{})
end procedure

public function WindowShouldClose()
	return c_func(xWindowShouldClose,{})	
end function

public function IsWindowReady()
	return c_func(xIsWindowReady,{})
end function

public function IsWindowFullscreen()
	return c_func(xIsWindowFullscreen,{})
end function

public function IsWindowHidden()
	return c_func(xIsWindowHidden,{})
end function

public function IsWindowMinimized()
	return c_func(xIsWindowMinimized,{})
end function

public function IsWindowMaximized()
	return c_func(xIsWindowMaximized,{})
end function

public function IsWindowFocused()
	return c_func(xIsWindowFocused,{})
end function

public function IsWindowResized()
	return c_func(xIsWindowResized,{})
end function

public function IsWindowState(atom flag)
        return c_func(xIsWindowState,{flag})
end function

public procedure SetWindowState(atom flag)
	c_proc(xSetWindowState,{flag})
end procedure

public procedure ClearWindowState(atom flag)
	c_proc(xClearWindowState,{flag})
end procedure

public procedure ToggleFullscreen()
	c_proc(xToggleFullscreen,{})
end procedure

public procedure ToggleBorderlessWindowed()
	c_proc(xToggleBorderlessWindowed,{})
end procedure

public procedure MaximizeWindow()
        c_proc(xMaximizeWindow,{})
end procedure

public procedure MinimizeWindow()
        c_proc(xMinimizeWindow,{})
end procedure

public procedure RestoreWindow()
        c_proc(xRestoreWindow,{})
end procedure

public procedure SetWindowIcon(sequence image)
        c_proc(xSetWindowIcon,{image})
end procedure

public procedure SetWindowIcons(atom images,atom count)
        c_proc(xSetWindowIcons,{images,count})
end procedure

public procedure SetWindowTitle(sequence title)
        c_proc(xSetWindowTitle,{title})
end procedure

public procedure SetWindowPosition(atom x,atom y)
        c_proc(xSetWindowPosition,{x,y})
end procedure

public procedure SetWindowMonitor(atom monitor)
        c_proc(xSetWindowMonitor,{monitor})
end procedure

public procedure SetWindowMinSize(atom width,atom height)
        c_proc(xSetWindowMinSize,{width,height})
end procedure

public procedure SetWindowMaxSize(atom width,atom height)
        c_proc(xSetWindowMaxSize,{width,height})
end procedure

public procedure SetWindowSize(atom width,atom height)
        c_proc(xSetWindowSize,{width,height})
end procedure

public procedure SetWindowOpacity(atom opacity)
        c_proc(xSetWindowOpacity,{opacity})
end procedure

public procedure SetWindowFocused()
        c_proc(xSetWindowFocused,{})
end procedure

public function GetWindowHandle()
        return c_func(xGetWindowHandle,{})
end function

public function GetScreenWidth()
	return c_func(xGetScreenWidth,{})
end function

public function GetScreenHeight()
	return c_func(xGetScreenHeight,{})
end function

public function GetRenderWidth()
	return c_func(xGetRenderWidth,{})
end function

public function GetRenderHeight()
	return c_func(xGetRenderHeight,{})
end function

public function GetMonitorCount()
	return c_func(xGetMonitorCount,{})
end function

public function GetCurrentMonitor()
	return c_func(xGetCurrentMonitor,{})
end function

public function GetMonitorPosition(atom monitor)
	return c_func(xGetMonitorPosition,{monitor})
end function

public function GetMonitorWidth(atom monitor)
	return c_func(xGetMonitorWidth,{monitor})
end function

public function GetMonitorHeight(atom monitor)
	return c_func(xGetMonitorHeight,{monitor})
end function

public function GetMonitorPhysicalWidth(atom monitor)
	return c_func(xGetMonitorPhysicalWidth,{monitor})
end function

public function GetMonitorPhysicalHeight(atom monitor)
	return c_func(xGetMonitorPhysicalHeight,{monitor})
end function

public function GetMonitorRefreshRate(atom monitor)
	return c_func(xGetMonitorRefreshRate,{monitor})
end function

public function GetWindowPosition()
	return c_func(xGetWindowPosition,{})
end function

public function GetWindowScaleDPI()
	return c_func(xGetWindowScaleDPI,{})
end function

public function GetMonitorName(atom monitor)
	return c_func(xGetMonitorName,{monitor})
end function

public procedure SetClipboardText(sequence text)
	c_proc(xSetClipboardText,{text})
end procedure

public function GetClipboardText()
	return c_func(xGetClipboardText,{})
end function

public function GetClipboardImage()
	return c_func(xGetClipboardImage,{})
end function

public procedure EnableEventWaiting()
	c_proc(xEnableEventWaiting,{})
end procedure

public procedure DisableEventWaiting()
	c_proc(xDisableEventWaiting,{})
end procedure

--Cursor Functions

public constant xShowCursor = define_c_proc(ray,"+ShowCursor",{}),
				xHideCursor = define_c_proc(ray,"+HideCursor",{}),
				xIsCursorHidden = define_c_func(ray,"+IsCursorHidden",{},C_BOOL),
				xEnableCursor = define_c_proc(ray,"+EnableCursor",{}),
				xDisableCursor = define_c_proc(ray,"+DisableCursor",{}),
				xIsCursorOnScreen = define_c_func(ray,"+IsCursorOnScreen",{},C_BOOL)
				
public procedure ShowCursor()
	c_proc(xShowCursor,{})
end procedure

public procedure HideCursor()
	c_proc(xHideCursor,{})
end procedure

public function IsCursorHidden()
	return c_func(xIsCursorHidden,{})
end function

public procedure EnableCursor()
	c_proc(xEnableCursor,{})
end procedure

public procedure DisableCursor()
	c_proc(xDisableCursor,{})
end procedure

public function IsCursorOnScreen()
	return c_func(xIsCursorOnScreen,{})
end function

--Drawing Functions

public constant xClearBackground = define_c_proc(ray,"+ClearBackground",{COLOR}),
				xBeginDrawing = define_c_proc(ray,"+BeginDrawing",{}),
				xEndDrawing = define_c_proc(ray,"+EndDrawing",{}),
				xBeginMode2D = define_c_proc(ray,"+BeginMode2D",{CAMERA2D}),
				xEndMode2D = define_c_proc(ray,"+EndMode2D",{}),
				xBeginMode3D = define_c_proc(ray,"+BeginMode3D",{CAMERA3D}),
				xEndMode3D = define_c_proc(ray,"+EndMode3D",{}),
				xBeginTextureMode = define_c_proc(ray,"+BeginTextureMode",{RENDERTEXTURE2D}),
				xEndTextureMode = define_c_proc(ray,"+EndTextureMode",{}),
				xBeginShaderMode = define_c_proc(ray,"+BeginShaderMode",{SHADER}),
				xEndShaderMode = define_c_proc(ray,"+EndShaderMode",{}),
				xBeginBlendMode = define_c_proc(ray,"+BeginBlendMode",{C_INT}),
				xEndBlendMode = define_c_proc(ray,"+EndBlendMode",{}),
				xBeginScissorMode = define_c_proc(ray,"+BeginScissorMode",{C_INT,C_INT,C_INT,C_INT}),
				xEndScissorMode = define_c_proc(ray,"+EndScissorMode",{}),
				xBeginVrStereoMode = define_c_proc(ray,"+BeginVrStereoMode",{VRSTEREOCONFIG}),
				xEndVrStereoMode = define_c_proc(ray,"+EndVrStereoMode",{})
				
public procedure ClearBackground(sequence color)
	c_proc(xClearBackground,{color})
end procedure

public procedure BeginDrawing()
	c_proc(xBeginDrawing,{})
end procedure

public procedure EndDrawing()
	c_proc(xEndDrawing,{})
end procedure

public procedure BeginMode2D(sequence camera)
	c_proc(xBeginMode2D,{camera})
end procedure

public procedure EndMode2D()
	c_proc(xEndMode2D,{})
end procedure

public procedure BeginMode3D(sequence camera)
	c_proc(xBeginMode3D,{camera})
end procedure

public procedure EndMode3D()
	c_proc(xEndMode3D,{})
end procedure

public procedure BeginTextureMode(sequence target)
	c_proc(xBeginTextureMode,{target})
end procedure

public procedure EndTextureMode()
	c_proc(xEndTextureMode,{})
end procedure

public procedure BeginShaderMode(sequence shader)
	c_proc(xBeginShaderMode,{shader})
end procedure

public procedure EndShaderMode()
	c_proc(xEndShaderMode,{})
end procedure

public procedure BeginBlendMode(atom mode)
	c_proc(xBeginBlendMode,{mode})
end procedure

public procedure EndBlendMode()
	c_proc(xEndBlendMode,{})
end procedure

public procedure BeginScissorMode(atom x,atom y,atom width,atom height)
	c_proc(xBeginScissorMode,{x,y,width,height})
end procedure

public procedure EndScissorMode()
	c_proc(xEndScissorMode,{})
end procedure

public procedure BeginVrStereoMode(sequence config)
	c_proc(xBeginVrStereoMode,{config})
end procedure

public procedure EndVrStereoMode()
	c_proc(xEndVrStereoMode,{})
end procedure

--VR Stereo Config Functions
public constant xLoadVrStereoConfig = define_c_func(ray,"+LoadVrStereoConfig",{VRDEVICEINFO},VRSTEREOCONFIG),
				xUnloadVrStereoConfig = define_c_proc(ray,"+UnloadVrStereoConfig",{VRSTEREOCONFIG})
				
public function LoadVrStereoConfig(sequence device)
	return c_func(xLoadVrStereoConfig,{device})
end function

public procedure UnloadVrStereoConfig(sequence config)
	c_proc(xUnloadVrStereoConfig,{config})
end procedure

--Shader Management Functions
public constant xLoadShader = define_c_func(ray,"+LoadShader",{C_STRING,C_STRING},SHADER),
                xLoadShaderFromMemory = define_c_func(ray,"+LoadShaderFromMemory",{C_STRING,C_STRING},SHADER),
                xIsShaderValid = define_c_func(ray,"+IsShaderValid",{SHADER},C_BOOL),
                xGetShaderLocation = define_c_func(ray,"+GetShaderLocation",{SHADER,C_STRING},C_INT),
                xGetShaderLocationAttrib = define_c_func(ray,"+GetShaderLocationAttrib",{SHADER,C_STRING},C_INT),
                xSetShaderValue = define_c_proc(ray,"+SetShaderValue",{SHADER,C_INT,C_POINTER,C_INT}),
                xSetShaderValueV = define_c_proc(ray,"+SetShaderValueV",{SHADER,C_INT,C_POINTER,C_INT,C_INT}),
                xSetShaderValueMatrix = define_c_proc(ray,"+SetShaderValueMatrix",{SHADER,C_INT,MATRIX}),
                xSetShaderValueTexture = define_c_proc(ray,"+SetShaderValueTexture",{SHADER,C_INT,TEXTURE2D}),
                xUnloadShader = define_c_proc(ray,"+UnloadShader",{SHADER})
                
public function LoadShader(sequence vsFileName, sequence fsFileName)
    return c_func(xLoadShader,{vsFileName,fsFileName})
end function

public function LoadShaderFromMemory(sequence vsCode, sequence fsCode)
    return c_func(xLoadShaderFromMemory,{vsCode,fsCode})
end function

public function IsShaderValid(sequence shader)
    return c_func(xIsShaderValid,{shader})
end function

public function GetShaderLocation(sequence shader, sequence uniformName)
    return c_func(xGetShaderLocation,{shader,uniformName})
end function

public function GetShaderLocationAttrib(sequence shader, sequence attribName)
    return c_func(xGetShaderLocationAttrib,{shader,attribName})
end function

public procedure SetShaderValue(sequence shader,atom locIndex,atom val,atom uniformType)
	c_proc(xSetShaderValue,{shader,locIndex,val,uniformType})
end procedure

public procedure SetShaderValueV(sequence shader,atom locIndex,atom val,atom uniformType,atom count)
	c_proc(xSetShaderValueV,{shader,locIndex,val,uniformType,count})
end procedure

public procedure SetShaderValueMatrix(sequence shader,atom locIndex,sequence mat)
	c_proc(xSetShaderValueMatrix,{shader,locIndex,mat})
end procedure

public procedure SetShaderValueTexture(sequence shader,atom locIndex,sequence texture)
	c_proc(xSetShaderValueTexture,{shader,locIndex,texture})
end procedure

public procedure UnloadShader(sequence shader)
	c_proc(xUnloadShader,{shader})
end procedure

--Screen-Space Functions
public constant xGetScreenToWorldRay = define_c_func(ray,"+GetScreenToWorldRay",{VECTOR2,CAMERA},RAY),
                xGetScreenToWorldRayEx = define_c_func(ray,"+GetScreenToWorldRayEx",{VECTOR2,CAMERA,C_INT,C_INT},RAY),
                xGetWorldToScreen = define_c_func(ray,"+GetWorldToScreen",{VECTOR3,CAMERA},VECTOR2),
                xGetWorldToScreenEx = define_c_func(ray,"+GetWorldToScreenEx",{VECTOR3,CAMERA,C_INT,C_INT},VECTOR2),
                xGetWorldToScreen2D = define_c_func(ray,"+GetWorldToScreen2D",{VECTOR2,CAMERA2D},VECTOR2),
                xGetScreenToWorld2D = define_c_func(ray,"+GetScreenToWorld2D",{VECTOR2,CAMERA2D},VECTOR2),
                xGetCameraMatrix = define_c_func(ray,"+GetCameraMatrix",{CAMERA},MATRIX),
                xGetCameraMatrix2D = define_c_func(ray,"+GetCameraMatrix2D",{CAMERA2D},MATRIX)
                
public function GetScreenToWorldRay(sequence position, sequence camera)
    return c_func(xGetScreenToWorldRay,{position,camera})
end function

public function GetScreenToWorldRayEx(sequence position, sequence camera, atom width, atom height)
    return c_func(xGetScreenToWorldRayEx,{position,camera,width,height})
end function

public function GetWorldToScreen(sequence position, sequence camera)
    return c_func(xGetWorldToScreen,{position,camera})
end function

public function GetWorldToScreenEx(sequence position, sequence camera, atom width, atom height)
    return c_func(xGetWorldToScreenEx,{position,camera,width,height})
end function

public function GetWorldToScreen2D(sequence position, sequence camera)
    return c_func(xGetWorldToScreen2D,{position,camera})
end function

public function GetScreenToWorld2D(sequence position, sequence camera)
    return c_func(xGetScreenToWorld2D,{position,camera})
end function

public function GetCameraMatrix(sequence camera)
    return c_func(xGetCameraMatrix,{camera})
end function

public function GetCameraMatrix2D(sequence camera)
    return c_func(xGetCameraMatrix2D,{camera})
end function

--Timing Functions
public constant xSetTargetFPS = define_c_proc(ray,"+SetTargetFPS",{C_INT}),
                xGetFPS = define_c_func(ray,"+GetFPS",{},C_INT),
                xGetFrameTime = define_c_func(ray,"+GetFrameTime",{},C_FLOAT),
                xGetTime = define_c_func(ray,"+GetTime",{},C_DOUBLE)

public procedure SetTargetFPS(atom fps)
    c_proc(xSetTargetFPS,{fps})
end procedure

public function GetFPS()
    return c_func(xGetFPS,{})
end function

public function GetFrameTime()
    return c_func(xGetFrameTime,{})
end function

public function GetTime()
    return c_func(xGetTime,{})
end function

public constant xSwapScreenBuffer = define_c_proc(ray,"+SwapScreenBuffer",{}),
				xPollInputEvents = define_c_proc(ray,"+PollInputEvents",{}),
				xWaitTime = define_c_proc(ray,"+WaitTime",{C_DOUBLE})
				
public procedure SwapScreenBuffer()
	c_proc(xSwapScreenBuffer,{})
end procedure

public procedure PollInputEvents()
	c_proc(xSwapScreenBuffer,{})
end procedure

public procedure WaitTime(atom seconds)
	c_proc(xWaitTime,{seconds})
end procedure

--Random Values
public constant xSetRandomSeed = define_c_proc(ray,"+SetRandomSeed",{C_UINT}),
                xGetRandomValue = define_c_func(ray,"+GetRandomValue",{C_INT,C_INT},C_INT),
                xLoadRandomSequence = define_c_func(ray,"+LoadRandomSequence",{C_UINT,C_INT,C_INT},C_POINTER),
                xUnloadRandomSequence = define_c_proc(ray,"+UnloadRandomSequence",{C_POINTER})

public procedure SetRandomSeed(atom seed)
    c_proc(xSetRandomSeed,{seed})
end procedure

public function GetRandomValue(atom min, atom max)
    return c_func(xGetRandomValue,{min,max})
end function

-- returns pointer to int array (no duplicates)
public function LoadRandomSequence(atom count, atom min, atom max)
    return c_func(xLoadRandomSequence,{count,min,max})
end function

public procedure UnloadRandomSequence(atom sequence)
    c_proc(xUnloadRandomSequence,{sequence})
end procedure

--Misc functions 
public constant xTakeScreenshot = define_c_proc(ray,"+TakeScreenshot",{C_STRING}),
                xSetConfigFlags = define_c_proc(ray,"+SetConfigFlags",{C_UINT}),
                xOpenURL = define_c_proc(ray,"+OpenURL",{C_STRING})

public procedure TakeScreenshot(sequence fileName)
    c_proc(xTakeScreenshot,{fileName})
end procedure

public procedure SetConfigFlags(atom flags)
    c_proc(xSetConfigFlags,{flags})
end procedure

public procedure OpenURL(sequence url)
    c_proc(xOpenURL,{url})
end procedure

--Logging system
public constant xSetTraceLogLevel = define_c_proc(ray,"+SetTraceLogLevel",{C_INT}),
                xTraceLog = define_c_proc(ray,"+TraceLog",{C_INT,C_STRING}),
                xSetTraceLogCallback = define_c_proc(ray,"+SetTraceLogCallback",{C_POINTER})

public procedure SetTraceLogLevel(atom logLevel)
    c_proc(xSetTraceLogLevel,{logLevel})
end procedure

-- simplified (no varargs support)
public procedure TraceLog(atom logLevel, sequence text)
    c_proc(xTraceLog,{logLevel,text})
end procedure

--  advanced: requires C callback function pointer
public procedure SetTraceLogCallback(atom callback)
    c_proc(xSetTraceLogCallback,{callback})
end procedure

--Memory Management
public constant xMemAlloc = define_c_func(ray,"+MemAlloc",{C_UINT},C_POINTER),
                xMemRealloc = define_c_func(ray,"+MemRealloc",{C_POINTER,C_UINT},C_POINTER),
                xMemFree = define_c_proc(ray,"+MemFree",{C_POINTER})

public function MemAlloc(atom size)
    return c_func(xMemAlloc,{size})
end function

public function MemRealloc(atom ptr, atom size)
    return c_func(xMemRealloc,{ptr,size})
end function

public procedure MemFree(atom ptr)
    c_proc(xMemFree,{ptr})
end procedure

--File Management
public constant xLoadFileData = define_c_func(ray,"+LoadFileData",{C_STRING,C_POINTER},C_POINTER),
				xUnloadFileData = define_c_proc(ray,"+UnloadFileData",{C_POINTER}),
				xSaveFileData = define_c_func(ray,"+SaveFileData",{C_STRING,C_POINTER,C_INT},C_BOOL),
				xExportDataAsCode = define_c_func(ray,"+ExportDataAsCode",{C_POINTER,C_INT,C_STRING},C_BOOL),
				xLoadFileText = define_c_func(ray,"+LoadFileText",{C_STRING},C_STRING),
				xUnloadFileText = define_c_proc(ray,"+UnloadFileText",{C_STRING}),
				xSaveFileText = define_c_func(ray,"+SaveFileText",{C_STRING,C_STRING},C_BOOL)
				
public function LoadFileData(sequence fName,atom dataSize)
	return c_func(xLoadFileData,{fName,dataSize})
end function

public procedure UnloadFileData(atom data)
	c_proc(xUnloadFileData,{data})
end procedure

public function SaveFileData(sequence fName,atom data,atom dataSize)
	return c_func(xSaveFileData,{fName,data,dataSize})
end function

public function ExportDataAsCode(atom data,atom dataSize,sequence fName)
	return c_func(xExportDataAsCode,{data,dataSize,fName})
end function

public function LoadFileText(sequence fName)
	return c_func(xLoadFileText,{fName})
end function

public procedure UnloadFileText(sequence text)
	c_proc(xUnloadFileText,{text})
end procedure

public function SaveFileText(sequence fName,sequence text)
	return c_func(xSaveFileText,{fName,text})
end function

--File access callbacks
public constant xSetLoadFileDataCallback = define_c_proc(ray,"+SetLoadFileDataCallback",{C_POINTER}),
				xSetSaveFileDataCallback = define_c_proc(ray,"+SetSaveFileDataCallback",{C_POINTER}),
				xSetLoadFileTextCallback = define_c_proc(ray,"+SetLoadFileTextCallback",{C_POINTER}),
				xSetSaveFileTextCallback = define_c_proc(ray,"+SetSaveFileTextCallback",{C_POINTER})
				
public procedure SetLoadFileDataCallback(object cb)
	c_proc(xSetLoadFileDataCallback,{cb})
end procedure

public procedure SetSaveFileDataCallback(object cb)
	c_proc(xSetSaveFileDataCallback,{cb})
end procedure

public procedure SetLoadFileTextCallback(object cb)
	c_proc(xSetLoadFileTextCallback,{cb})
end procedure
				
public procedure SetSaveFileTextCallback(object cb)
	c_proc(xSetSaveFileTextCallback,{cb})
end procedure

public constant xFileRename = define_c_func(ray,"+FileRename",{C_STRING,C_STRING},C_INT),
				xFileRemove = define_c_func(ray,"+FileRemove",{C_STRING},C_INT),
				xFileCopy = define_c_func(ray,"+FileCopy",{C_STRING,C_STRING},C_INT),
				xFileMove = define_c_func(ray,"+FileMove",{C_STRING,C_STRING},C_INT),
				xFileTextReplace = define_c_func(ray,"+FileTextReplace",{C_STRING,C_STRING,C_STRING},C_INT),
				xFileTextFindIndex = define_c_func(ray,"+FileTextFindIndex",{C_STRING,C_STRING},C_INT),
				xFileExists = define_c_func(ray,"+FileExists",{C_STRING},C_BOOL),
				xDirectoryExists = define_c_func(ray,"+DirectoryExists",{C_STRING},C_BOOL),
				xIsFileExtension = define_c_func(ray,"+IsFileExtension",{C_STRING,C_STRING},C_BOOL),
				xGetFileLength = define_c_func(ray,"+GetFileLength",{C_STRING},C_INT),
				xGetFileModTime = define_c_func(ray,"+GetFileModTime",{C_STRING},C_LONG),
				xGetFileExtension = define_c_func(ray,"+GetFileExtension",{C_STRING},C_STRING),
				xGetFileName = define_c_func(ray,"+GetFileName",{C_STRING},C_STRING),
				xGetFileNameWithoutExt = define_c_func(ray,"+GetFileNameWithoutExt",{C_STRING},C_STRING),
				xGetDirectoryPath = define_c_func(ray,"+GetDirectoryPath",{C_STRING},C_STRING),
				xGetPrevDirectoryPath = define_c_func(ray,"+GetPrevDirectoryPath",{C_STRING},C_STRING),
				xGetWorkingDirectory = define_c_func(ray,"+GetWorkingDirectory",{},C_STRING),
				xGetApplicationDirectory = define_c_func(ray,"+GetApplicationDirectory",{},C_STRING),
				xMakeDirectory = define_c_func(ray,"+MakeDirectory",{C_STRING},C_INT),
				xChangeDirectory = define_c_func(ray,"+ChangeDirectory",{C_STRING},C_BOOL),
				xIsPathFile = define_c_func(ray,"+IsPathFile",{C_STRING},C_BOOL),
				xIsFileNameValid = define_c_func(ray,"+IsFileNameValid",{C_STRING},C_BOOL),
				xLoadDirectoryFiles = define_c_func(ray,"+LoadDirectoryFiles",{C_STRING},FILEPATHLIST),
				xLoadDirectoryFilesEx = define_c_func(ray,"+LoadDirectoryFilesEx",{C_STRING,C_STRING,C_BOOL},FILEPATHLIST),
				xUnloadDirectoryFiles = define_c_proc(ray,"+UnloadDirectoryFiles",{C_INT}),
				xIsFileDropped = define_c_func(ray,"+IsFileDropped",{},C_BOOL),
				xLoadDroppedFiles = define_c_func(ray,"+LoadDroppedFiles",{},C_INT),
				xUnloadDroppedFiles = define_c_proc(ray,"+UnloadDroppedFiles",{FILEPATHLIST}),
				xGetDirectoryFileCount = define_c_func(ray,"+GetDirectoryFileCount",{C_STRING},C_UINT),
				xGetDirectoryFileCountEx = define_c_func(ray,"+GetDirectoryFileCountEx",{C_STRING,C_STRING,C_BOOL},C_UINT)
				
public function FileRename(sequence fName,sequence fReName)
	return c_func(xFileRename,{fName,fReName})
end function

public function FileRemove(sequence fName)
	return c_func(xFileRemove,{fName})
end function

public function FileCopy(sequence srcPath,sequence dstPath)
	return c_func(xFileCopy,{srcPath,dstPath})
end function

public function FileMove(sequence srcPath,sequence dstPath)
	return c_func(xFileMove,{srcPath,dstPath})
end function

public function FileTextReplace(sequence fName,sequence srch,sequence replace)
	return c_func(xFileTextReplace,{fName,srch,replace})
end function

public function FileTextFindIndex(sequence fName,sequence srch)
	return c_func(xFileTextFindIndex,{fName,srch})
end function

public function FileExists(sequence fName)
	return c_func(xFileExists,{fName})
end function

public function DirectoryExists(sequence dirPath)
	return c_func(xDirectoryExists,{dirPath})
end function

public function IsFileExtension(sequence fName,sequence ext)
	return c_func(xIsFileExtension,{fName,ext})
end function

public function GetFileLength(sequence fName)
	return c_func(xGetFileLength,{fName})
end function

public function GetFileExtension(sequence fName)
	return c_func(xGetFileExtension,{fName})
end function

public function GetFileName(sequence filePath)
	return c_func(xGetFileName,{filePath})
end function

public function GetFileNameWithoutExt(sequence filePath)
	return c_func(xGetFileNameWithoutExt,{filePath})
end function

public function GetDirectoryPath(sequence filePath)
	return c_func(xGetDirectoryPath,{filePath})
end function

public function GetPrevDirectoryPath(sequence dirPath)
	return c_func(xGetPrevDirectoryPath,{dirPath})
end function

public function GetWorkingDirectory()
	return c_func(xGetWorkingDirectory,{})
end function

public function GetApplicationDirectory()
	return c_func(xGetApplicationDirectory,{})
end function

public function MakeDirectory(sequence dirPath)
	return c_func(xMakeDirectory,{dirPath})
end function

public function ChangeDirectory(sequence dirPath)
	return c_func(xChangeDirectory,{dirPath})
end function

public function IsPathFile(sequence path)
	return c_func(xIsPathFile,{path})
end function

public function IsFileNameValid(sequence fName)
	return c_func(xIsFileNameValid,{fName})
end function

public function LoadDirectoryFiles(sequence dirPath)
	return c_func(xLoadDirectoryFiles,{dirPath})
end function

public function LoadDirectoryFilesEx(sequence basePath,sequence filter,atom scan)
	return c_func(xLoadDirectoryFilesEx,{basePath,filter,scan})
end function

public procedure UnloadDirectoryFiles(sequence files)
	c_proc(xUnloadDirectoryFiles,{files})
end procedure

public function IsFileDropped()
	return c_func(xIsFileDropped,{})
end function

public function LoadDroppedFiles()
	return c_func(xLoadDroppedFiles,{})
end function

public procedure UnloadDroppedFiles(atom files)
	c_proc(xUnloadDroppedFiles,{files})
end procedure

public function GetDirectoryFileCount(sequence dirPath)
	return c_func(xGetDirectoryFileCount,{dirPath})
end function

public function GetDirectoryFileCountEx(sequence basePath,sequence filter,atom scan)
	return c_func(xGetDirectoryFileCountEx,{basePath,filter,scan})
end function

--Compression
public constant xCompressData = define_c_func(ray,"+CompressData",{C_POINTER,C_INT,C_POINTER},C_POINTER),
				xDecompressData = define_c_func(ray,"+DecompressData",{C_POINTER,C_INT,C_POINTER},C_POINTER),
				xEncodeDataBase64 = define_c_func(ray,"+EncodeDataBase64",{C_POINTER,C_INT,C_POINTER},C_POINTER),
				xDecodeDataBase64 = define_c_func(ray,"+DecodeDataBase64",{C_STRING,C_POINTER},C_POINTER),
				xComputeCRC32 = define_c_func(ray,"+ComputeCRC32",{C_POINTER,C_INT},C_UINT),
				xComputeMD5 = define_c_func(ray,"+ComputeMD5",{C_POINTER,C_INT},C_POINTER),
				xComputeSHA1 = define_c_func(ray,"+ComputeSHA1",{C_POINTER,C_INT},C_POINTER),
				xComputeSHA256 = define_c_func(ray,"+ComputeSHA256",{C_POINTER,C_INT},C_POINTER)
				
public function CompressData(atom data,atom dataSize,atom compDataSize)
	return c_func(xCompressData,{data,dataSize,compDataSize})
end function

public function DecompressData(atom compData,atom compDataSize,atom dataSize)
	return c_func(xDecompressData,{compData,compDataSize,dataSize})
end function

public function EncodeDataBase64(atom data,atom dataSize,atom outputSize)
	return c_func(xEncodeDataBase64,{data,dataSize,outputSize})
end function

public function DecodeDataBase64(sequence text,atom outputSize)
	return c_func(xDecodeDataBase64,{text,outputSize})
end function

public function ComputeCRC32(atom data,atom dataSize)
	return c_func(xComputeCRC32,{data,dataSize})
end function

public function ComputeMD5(atom data,atom dataSize)
	return c_func(xComputeMD5,{data,dataSize})
end function

public function ComputeSHA1(atom data,atom dataSize)
	return c_func(xComputeSHA1,{data,dataSize})
end function

public function ComputeSHA256(atom data,atom dataSize)
	return c_func(xComputeSHA256,{data,dataSize})
end function

--Automation Functions

public constant xLoadAutomationEventList = define_c_func(ray,"+LoadAutomationEventList",{C_STRING},AUTOMATIONEVENTLIST),
				xUnloadAutomationEventList = define_c_proc(ray,"+UnloadAutomationEventList",{AUTOMATIONEVENTLIST}),
				xExportAutomationEventList = define_c_func(ray,"+ExportAutomationEventList",{AUTOMATIONEVENTLIST,C_STRING},C_BOOL),
				xSetAutomationEventList = define_c_proc(ray,"+SetAutomationEventList",{C_POINTER}),
				xSetAutomationEventBaseFrame = define_c_proc(ray,"+SetAutomationEventBaseFrame",{C_INT}),
				xStartAutomationEventRecording = define_c_proc(ray,"+StartAutomationEventRecording",{}),
				xStopAutomationEventRecording = define_c_proc(ray,"+StopAutomationEventRecording",{}),
				xPlayAutomationEvent = define_c_proc(ray,"+PlayAutomationEvent",{AUTOMATIONEVENTLIST})
				
public function LoadAutomationEventList(sequence fName)
	return c_func(xLoadAutomationEventList,{fName})
end function

public procedure UnloadAutomationEventList(atom list)
	c_proc(xUnloadAutomationEventList,{list})
end procedure

public function ExportAutomationEventList(atom list,sequence fName)
	return c_func(xExportAutomationEventList,{list,fName})
end function

public procedure SetAutomationEventList(atom list)
	c_proc(xSetAutomationEventList,{list})
end procedure

public procedure SetAutomationEventBaseFrame(atom frame)
	c_proc(xSetAutomationEventBaseFrame,{frame})
end procedure

public procedure StartAutomationEventRecording()
	c_proc(xStartAutomationEventRecording,{})
end procedure

public procedure StopAutomationEventRecording()
	c_proc(xStopAutomationEventRecording,{})
end procedure

public procedure PlayAutomationEvent(atom event)
	c_proc(xPlayAutomationEvent,{event})
end procedure

--Keyboard
public constant xIsKeyPressed = define_c_func(ray,"+IsKeyPressed",{C_INT},C_BOOL),
				xIsKeyPressedRepeat = define_c_func(ray,"+IsKeyPressedRepeat",{C_INT},C_BOOL),
				xIsKeyDown = define_c_func(ray,"+IsKeyDown",{C_INT},C_BOOL),
				xIsKeyReleased = define_c_func(ray,"+IsKeyReleased",{C_INT},C_BOOL),
				xIsKeyUp = define_c_func(ray,"+IsKeyUp",{C_INT},C_BOOL),
				xGetKeyPressed = define_c_func(ray,"+GetKeyPressed",{},C_INT),
				xGetCharPressed = define_c_func(ray,"+GetCharPressed",{},C_INT),
				xGetKeyName = define_c_func(ray,"+GetKeyName",{C_INT},C_STRING),
				xSetExitKey = define_c_proc(ray,"+SetExitKey",{C_INT})
				
public function IsKeyPressed(atom key)
	return c_func(xIsKeyPressed,{key})
end function

public function IsKeyPressedRepeat(atom key)
	return c_func(xIsKeyPressedRepeat,{key})
end function

public function IsKeyDown(atom key)
	return c_func(xIsKeyDown,{key})
end function

public function IsKeyReleased(atom key)
	return c_func(xIsKeyReleased,{key})
end function

public function IsKeyUp(atom key)
	return c_func(xIsKeyUp,{key})
end function

public function GetKeyPressed()
	return c_func(xGetKeyPressed,{})
end function

public function GetCharPressed()
	return c_func(xGetCharPressed,{})
end function

public function GetKeyName(atom key)
	return c_func(xGetKeyName,{key})
end function

public procedure SetExitKey(atom key)
	c_proc(xSetExitKey,{key})
end procedure

--Gamepad
public constant xIsGamepadAvailable = define_c_func(ray,"+IsGamepadAvailable",{C_INT},C_BOOL),
				xGetGamepadName = define_c_func(ray,"+GetGamepadName",{C_INT},C_STRING),
				xIsGamepadButtonPressed = define_c_func(ray,"+IsGamepadButtonPressed",{C_INT,C_INT},C_BOOL),
				xIsGamepadButtonDown = define_c_func(ray,"+IsGamepadButtonDown",{C_INT,C_INT},C_BOOL),
				xIsGamepadButtonReleased = define_c_func(ray,"+IsGamepadButtonReleased",{C_INT,C_INT},C_BOOL),
				xIsGamepadButtonUp = define_c_func(ray,"+IsGamepadButtonUp",{C_INT,C_INT},C_BOOL),
				xGetGamepadButtonPressed = define_c_func(ray,"+GetGamepadButtonPressed",{},C_INT),
				xGetGamepadAxisCount = define_c_func(ray,"+GetGamepadAxisCount",{C_INT},C_INT),
				xGetGamepadAxisMovement = define_c_func(ray,"+GetGamepadAxisMovement",{C_INT,C_INT},C_FLOAT),
				xSetGamepadMappings = define_c_func(ray,"+SetGamepadMappings",{C_STRING},C_INT),
				xSetGamepadVibration = define_c_proc(ray,"+SetGamepadVibration",{C_INT,C_FLOAT,C_FLOAT,C_FLOAT})
				
public function IsGamepadAvailable(atom gamepad)
	return c_func(xIsGamepadAvailable,{gamepad})
end function

public function GetGamepadName(atom gamepad)
	return c_func(xGetGamepadName,{gamepad})
end function

public function IsGamepadButtonPressed(atom gamepad,atom button)
	return c_func(xIsGamepadButtonPressed,{gamepad,button})
end function

public function IsGamepadButtonDown(atom gamepad,atom button)
	return c_func(xIsGamepadButtonDown,{gamepad,button})
end function

public function IsGamepadButtonReleased(atom gamepad,atom button)
	return c_func(xIsGamepadButtonReleased,{gamepad,button})
end function

public function IsGamepadButtonUp(atom gamepad,atom button)
	return c_func(xIsGamepadButtonUp,{gamepad,button})
end function

public function GetGamepadButtonPressed()
	return c_func(xGetGamepadButtonPressed,{})
end function

public function GetGamepadAxisCount(atom gamepad)
	return c_func(xGetGamepadAxisCount,{gamepad})
end function

public function GetGamepadAxisMovement(atom gamepad,atom axis)
	return c_func(xGetGamepadAxisMovement,{gamepad,axis})
end function

public function SetGamepadMappings(sequence mappings)
	return c_func(xSetGamepadMappings,{mappings})
end function

public procedure SetGamepadVibration(atom gamepad,atom leftMotor,atom rightMotor,atom duration)
	c_proc(xSetGamepadVibration,{gamepad,leftMotor,rightMotor,duration})
end procedure

--Mouse
public constant    xIsMouseButtonPressed  = define_c_func(ray, "+IsMouseButtonPressed",  {C_INT}, C_BOOL),
    xIsMouseButtonDown     = define_c_func(ray, "+IsMouseButtonDown",     {C_INT}, C_BOOL),
    xIsMouseButtonReleased = define_c_func(ray, "+IsMouseButtonReleased", {C_INT}, C_BOOL),
    xIsMouseButtonUp       = define_c_func(ray, "+IsMouseButtonUp",       {C_INT}, C_BOOL),

    xGetMouseX             = define_c_func(ray, "+GetMouseX", {}, C_INT),
    xGetMouseY             = define_c_func(ray, "+GetMouseY", {}, C_INT),
    xGetMousePosition      = define_c_func(ray, "+GetMousePosition", {}, VECTOR2),

    xGetMouseDelta         = define_c_func(ray, "+GetMouseDelta", {}, VECTOR2),

    xSetMousePosition      = define_c_proc(ray, "+SetMousePosition", {C_INT, C_INT}),
    xSetMouseOffset        = define_c_proc(ray, "+SetMouseOffset",   {C_INT, C_INT}),
    xSetMouseScale         = define_c_proc(ray, "+SetMouseScale",    {C_FLOAT, C_FLOAT}),

    xGetMouseWheelMove     = define_c_func(ray, "+GetMouseWheelMove", {}, C_FLOAT),
    xGetMouseWheelMoveV    = define_c_func(ray, "+GetMouseWheelMoveV", {}, VECTOR2),

    xSetMouseCursor        = define_c_proc(ray, "+SetMouseCursor", {C_INT})
    
public function IsMouseButtonPressed(atom button)
    return c_func(xIsMouseButtonPressed, {button})
end function

public function IsMouseButtonDown(atom button)
	return c_func(xIsMouseButtonDown,{button})
end function

public function IsMouseButtonReleased(atom button)
	return c_func(xIsMouseButtonReleased,{button})
end function

public function IsMouseButtonUp(atom button)
	return c_func(xIsMouseButtonUp,{button})
end function

public function GetMouseX()
	return c_func(xGetMouseX,{})
end function

public function GetMouseY()
	return c_func(xGetMouseY,{})
end function

public function GetMousePosition()
    return c_func(xGetMousePosition, {})
end function

public function GetMouseDelta()
	return c_func(xGetMouseDelta,{})
end function

public procedure SetMousePosition(atom x, atom y)
    c_proc(xSetMousePosition, {x, y})
end procedure

public procedure SetMouseOffset(atom offsetX,atom offsetY)
	c_proc(xSetMouseOffset,{offsetX,offsetY})
end procedure

public procedure SetMouseScale(atom scaleX,atom scaleY)
	c_proc(xSetMouseScale,{scaleX,scaleY})
end procedure

public function GetMouseWheelMove()
	return c_func(xGetMouseWheelMove,{})
end function

public function GetMouseWheelMoveV()
	return c_func(xGetMouseWheelMoveV,{})
end function

public procedure SetMouseCursor(atom cursor)
	c_proc(xSetMouseCursor,{cursor})
end procedure

--Touch

public constant xGetTouchX = define_c_func(ray,"+GetTouchX",{},C_INT),
				xGetTouchY = define_c_func(ray,"+GetTouchY",{},C_INT),
				xGetTouchPosition = define_c_func(ray,"+GetTouchPosition",{C_INT},VECTOR2),
				xGetTouchPointId = define_c_func(ray,"+GetTouchPointId",{C_INT},C_INT),
				xGetTouchPointCount = define_c_func(ray,"+GetTouchPointCount",{},C_INT)
				
public function GetTouchX()
	return c_func(xGetTouchX,{})
end function

public function GetTouchY()
	return c_func(xGetTouchY,{})
end function

public function GetTouchPosition(atom index)
	return c_func(xGetTouchPosition,{index})
end function

public function GetTouchPointId(atom index)
	return c_func(xGetTouchPointId,{index})
end function

public function GetTouchPointCount()
	return c_func(xGetTouchPointCount,{})
end function

--Gestures

public constant xSetGesturesEnabled = define_c_proc(ray,"+SetGesturesEnabled",{C_UINT}),
				xIsGestureDetected = define_c_func(ray,"+IsGestureDetected",{C_UINT},C_BOOL),
				xGetGestureDetected = define_c_func(ray,"+GetGestureDetected",{},C_INT),
				xGetGestureHoldDuration = define_c_func(ray,"+GetGestureHoldDuration",{},C_FLOAT),
				xGetGestureDragVector = define_c_func(ray,"+GetGestureDragVector",{},VECTOR2),
				xGetGestureDragAngle = define_c_func(ray,"+GetGestureDragAngle",{},C_FLOAT),
				xGetGesturePinchVector = define_c_func(ray,"+GetGesturePinchVector",{},VECTOR2),
				xGetGesturePinchAngle = define_c_func(ray,"+GetGesturePinchAngle",{},C_FLOAT)
				
public procedure SetGesturesEnabled(atom flags)
	c_proc(xSetGesturesEnabled,{flags})
end procedure

public function IsGestureDetected(atom gesture)
	return c_func(xIsGestureDetected,{gesture})
end function

public function GetGestureDetected()
	return c_func(xGetGestureDetected,{})
end function

public function GetGestureHoldDuration()
	return c_func(xGetGestureHoldDuration,{})
end function

public function GetGestureDragVector()
	return c_func(xGetGestureDragVector,{})
end function

public function GetGestureDragAngle()
	return c_func(xGetGestureDragAngle,{})
end function

public function GetGesturePinchVector()
	return c_func(xGetGesturePinchVector,{})
end function

public function GetGesturePinchAngle()
	return c_func(xGetGesturePinchAngle,{})
end function

--Camera
public constant xUpdateCamera = define_c_proc(ray,"+UpdateCamera",{C_POINTER,C_INT}),
				xUpdateCameraPro = define_c_proc(ray,"+UpdateCameraPro",{C_POINTER,VECTOR3,VECTOR3,C_FLOAT})
				
public procedure UpdateCamera(atom camera,atom mode)
	c_proc(xUpdateCamera,{camera,mode})
end procedure

public procedure UpdateCameraPro(atom camera,sequence movement,sequence rotation,atom zoom)
	c_proc(xUpdateCameraPro,{camera,movement,rotation,zoom})
end procedure

--Basic Shapes
public constant xSetShapesTexture = define_c_proc(ray,"+SetShapesTexture",{TEXTURE2D,RECTANGLE}),
				xGetShapesTexture = define_c_func(ray,"+GetShapesTexture",{},TEXTURE2D),
				xGetShapesTextureRectangle = define_c_func(ray,"+GetShapesTextureRectangle",{},RECTANGLE)
				
public procedure SetShapesTexture(sequence texture,sequence source)
	c_proc(xSetShapesTexture,{texture,source})
end procedure

public function GetShapesTexture()
	return c_func(xGetShapesTexture,{})
end function

public function GetShapesTextureRectangle()
	return c_func(xGetShapesTextureRectangle,{})
end function

--Basic Shapes Cont.
public constant xDrawPixel = define_c_proc(ray,"+DrawPixel",{C_INT,C_INT,COLOR})

public procedure DrawPixel(atom x,atom y,sequence color)
	c_proc(xDrawPixel,{x,y,color})
end procedure

public constant xDrawPixelV = define_c_proc(ray,"+DrawPixelV",{VECTOR2,COLOR})

public procedure DrawPixelV(sequence pos,sequence color)
	c_proc(xDrawPixelV,{pos,color})
end procedure

public constant xDrawLine = define_c_proc(ray,"+DrawLine",{C_INT,C_INT,C_INT,C_INT,COLOR})

public procedure DrawLine(atom x,atom y,atom endX,atom endY,sequence color)
	c_proc(xDrawLine,{x,y,endX,endY,color})
end procedure

public constant xDrawLineV = define_c_proc(ray,"+DrawLineV",{VECTOR2,VECTOR2,COLOR})

public procedure DrawLineV(sequence startPos,sequence endPos,sequence color)
	c_proc(xDrawLineV,{startPos,endPos,color})
end procedure

public constant xDrawLineEx = define_c_proc(ray,"+DrawLineEx",{VECTOR2,VECTOR2,C_FLOAT,COLOR})

public procedure DrawLineEx(sequence startPos,sequence endPos,atom thick,sequence color)
	c_proc(xDrawLineEx,{startPos,endPos,thick,color})
end procedure

public constant xDrawLineStrip = define_c_proc(ray,"+DrawLineStrip",{C_POINTER,C_INT,COLOR})

public procedure DrawLineStrip(atom points,atom count,sequence color)
	c_proc(xDrawLineStrip,{points,count,color})
end procedure

public constant xDrawLineBezier = define_c_proc(ray,"+DrawLineBezier",{VECTOR2,VECTOR2,C_FLOAT,COLOR})

public procedure DrawLineBezier(sequence startPos,sequence endPos,atom thick,sequence color)
	c_proc(xDrawLineBezier,{startPos,endPos,thick,color})
end procedure

public constant xDrawLineDashed = define_c_proc(ray,"+DrawLineDashed",{VECTOR2,VECTOR2,C_INT,C_INT,COLOR})

public procedure DrawLineDashed(sequence startPos,sequence endPos,atom dashSize,atom spaceSize,sequence color)
	c_proc(xDrawLineDashed,{startPos,endPos,dashSize,spaceSize,color})
end procedure

public constant xDrawCircle = define_c_proc(ray,"+DrawCircle",{C_INT,C_INT,C_FLOAT,COLOR})

public procedure DrawCircle(atom x,atom y,atom radius,sequence color)
	c_proc(xDrawCircle,{x,y,radius,color})
end procedure

public constant xDrawCircleV = define_c_proc(ray,"+DrawCircleV",{VECTOR2,C_FLOAT,COLOR})

public procedure DrawCircleV(sequence center,atom radius,sequence color)
	c_proc(xDrawCircleV,{center,radius,color})
end procedure

public constant xDrawCircleGradient = define_c_proc(ray,"+DrawCircleGradient",{VECTOR2,C_FLOAT,COLOR,COLOR})

public procedure DrawCircleGradient(sequence center,atom radius,sequence inner,sequence outer)
	c_proc(xDrawCircleGradient,{center,radius,inner,outer})
end procedure

public constant xDrawCircleSector = define_c_proc(ray,"+DrawCircleSector",{VECTOR2,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,COLOR})

public procedure DrawCircleSector(sequence center,atom radius,atom startAngle,atom endAngle,atom segments,sequence color)
	c_proc(xDrawCircleSector,{center,radius,startAngle,endAngle,segments,color})
end procedure

public constant xDrawCircleSectorLines = define_c_proc(ray,"+DrawCircleSectorLines",{VECTOR2,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,COLOR})

public procedure DrawCircleSectorLines(sequence center,atom radius,atom startAngle,atom endAngle,atom segments,sequence color)
	c_proc(xDrawCircleSectorLines,{center,radius,startAngle,endAngle,segments,color})
end procedure

public constant xDrawCircleLines = define_c_proc(ray,"+DrawCircleLines",{C_INT,C_INT,C_FLOAT,COLOR})

public procedure DrawCircleLines(atom x,atom y,atom radius,sequence color)
	c_proc(xDrawCircleLines,{x,y,radius,color})
end procedure

public constant xDrawCircleLinesV = define_c_proc(ray,"+DrawCircleLinesV",{VECTOR2,C_FLOAT,COLOR})

public procedure DrawCircleLinesV(sequence center,atom radius,sequence color)
	c_proc(xDrawCircleLinesV,{center,radius,color})
end procedure

public constant xDrawEllipse = define_c_proc(ray,"+DrawEllipse",{C_INT,C_INT,C_FLOAT,C_FLOAT,COLOR})

public procedure DrawEllipse(atom x,atom y,atom radiusH,atom radiusV,sequence color)
	c_proc(xDrawEllipse,{x,y,radiusH,radiusV,color})
end procedure

public constant xDrawEllipseV = define_c_proc(ray,"+DrawEllipseV",{VECTOR2,C_FLOAT,C_FLOAT,COLOR})

public procedure DrawEllipseV(sequence center,atom radiusH,atom radiusV,sequence color)
	c_proc(xDrawEllipseV,{center,radiusH,radiusV,color})
end procedure

public constant xDrawEllipseLines = define_c_proc(ray,"+DrawEllipseLines",{C_INT,C_INT,C_FLOAT,C_FLOAT,COLOR})

public procedure DrawEllipseLines(atom x,atom y,atom radiusH,atom radiusV,sequence color)
	c_proc(xDrawEllipseLines,{x,y,radiusH,radiusV,color})
end procedure

public constant xDrawEllipseLinesV = define_c_proc(ray,"+DrawEllipseLinesV",{VECTOR2,C_FLOAT,C_FLOAT,COLOR})

public procedure DrawEllipseLinesV(sequence center,atom radiusH,atom radiusV,sequence color)
	c_proc(xDrawEllipseLinesV,{center,radiusH,radiusV,color})
end procedure

public constant xDrawRing = define_c_proc(ray,"+DrawRing",{VECTOR2,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,COLOR})

public procedure DrawRing(sequence center,atom innerRadius,atom outerRadius,atom startAngle,atom endAngle,atom segments,sequence color)
	c_proc(xDrawRing,{center,innerRadius,outerRadius,startAngle,endAngle,segments,color})
end procedure

public constant xDrawRingLines = define_c_proc(ray,"+DrawRingLines",{VECTOR2,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,COLOR})

public procedure DrawRingLines(sequence center,atom innerRadius,atom outerRadius,atom startAngle,atom endAngle,atom segments,sequence color)
	c_proc(xDrawRingLines,{center,innerRadius,outerRadius,startAngle,endAngle,segments,color})
end procedure

public constant xDrawRectangle = define_c_proc(ray,"+DrawRectangle",{C_INT,C_INT,C_INT,C_INT,COLOR})

public procedure DrawRectangle(atom x,atom y,atom width,atom height,sequence color)
	c_proc(xDrawRectangle,{x,y,width,height,color})
end procedure

public constant xDrawRectangleV = define_c_proc(ray,"+DrawRectangleV",{VECTOR2,VECTOR2,COLOR})

public procedure DrawRectangleV(sequence pos,sequence size,sequence color)
	c_proc(xDrawRectangleV,{pos,size,color})
end procedure

public constant xDrawRectangleRec = define_c_proc(ray,"+DrawRectangleRec",{RECTANGLE,COLOR})

public procedure DrawRectangleRec(sequence rec,sequence color)
	c_proc(xDrawRectangleRec,{rec,color})
end procedure

public constant xDrawRectanglePro = define_c_proc(ray,"+DrawRectanglePro",{RECTANGLE,VECTOR2,C_FLOAT,COLOR})

public procedure DrawRectanglePro(sequence rec,sequence origin,atom rotation,sequence color)
	c_proc(xDrawRectanglePro,{rec,origin,rotation,color})
end procedure

public constant xDrawRectangleGradientV = define_c_proc(ray,"+DrawRectangleGradientV",{C_INT,C_INT,C_INT,C_INT,COLOR,COLOR})

public procedure DrawRectangleGradientV(atom x,atom y,atom width,atom height,sequence top,sequence bottom)
	c_proc(xDrawRectangleGradientV,{x,y,width,height,top,bottom})
end procedure

public constant xDrawRectangleGradientH = define_c_proc(ray,"+DrawRectangleGradientH",{C_INT,C_INT,C_INT,C_INT,COLOR,COLOR})

public procedure DrawRectangleGradientH(atom x,atom y,atom width,atom height,sequence top,sequence bottom)
	c_proc(xDrawRectangleGradientH,{x,y,width,height,top,bottom})
end procedure

public constant xDrawRectangleGradientEx = define_c_proc(ray,"+DrawRectangleGradientEx",{RECTANGLE,COLOR,COLOR,COLOR,COLOR})

public procedure DrawRectangleGradientEx(sequence rec,sequence topLeft,sequence bottomLeft,sequence bottomRight,sequence topRight)
	c_proc(xDrawRectangleGradientEx,{rec,topLeft,bottomLeft,bottomRight,topRight})
end procedure

public constant xDrawRectangleLines = define_c_proc(ray,"+DrawRectangleLines",{C_INT,C_INT,C_INT,C_INT,COLOR})

public procedure DrawRectangleLines(atom x,atom y,atom width,atom height,sequence color)
	c_proc(xDrawRectangleLines,{x,y,width,height,color})
end procedure

public constant xDrawRectangleLinesEx = define_c_proc(ray,"+DrawRectangleLinesEx",{RECTANGLE,C_FLOAT,COLOR})

public procedure DrawRectangleLinesEx(sequence rec,atom lineThick,sequence color)
	c_proc(xDrawRectangleLinesEx,{rec,lineThick,color})
end procedure

public constant xDrawRectangleRounded = define_c_proc(ray,"+DrawRectangleRounded",{RECTANGLE,C_FLOAT,C_INT,COLOR})

public procedure DrawRectangleRounded(sequence rect,atom roundness,atom segments,sequence color)
	c_proc(xDrawRectangleRounded,{rect,roundness,segments,color})
end procedure

public constant xDrawRectangleRoundedLines = define_c_proc(ray,"+DrawRectangleRoundedLines",{RECTANGLE,C_FLOAT,C_INT,COLOR})

public procedure DrawRectangleRoundedLines(sequence rec,atom roundness,atom segments,sequence color)
	c_proc(xDrawRectangleRoundedLines,{rec,roundness,segments,color})
end procedure

public constant xDrawRectangleRoundedLinesEx = define_c_proc(ray,"+DrawRectangleRoundedLinesEx",{RECTANGLE,C_FLOAT,C_INT,C_FLOAT,COLOR})

public procedure DrawRectangleRoundedLinesEx(sequence rec,atom roundness,atom segments,atom thick,sequence color)
	c_proc(xDrawRectangleRoundedLinesEx,{rec,roundness,segments,thick,color})
end procedure

public constant xDrawTriangle = define_c_proc(ray,"+DrawTriangle",{VECTOR2,VECTOR2,VECTOR2,COLOR})

public procedure DrawTriangle(sequence v1,sequence v2,sequence v3,sequence color)
	c_proc(xDrawTriangle,{v1,v2,v3,color})
end procedure

public constant xDrawTriangleLines = define_c_proc(ray,"+DrawTriangleLines",{VECTOR2,VECTOR2,VECTOR2,COLOR})

public procedure DrawTriangleLines(sequence v1,sequence v2,sequence v3,sequence color)
	c_proc(xDrawTriangleLines,{v1,v2,v3,color})
end procedure

public constant xDrawTriangleFan = define_c_proc(ray,"+DrawTriangleFan",{C_POINTER,C_INT,COLOR})

public procedure DrawTriangleFan(atom points,atom count,sequence color)
	c_proc(xDrawTriangleFan,{points,count,color})
end procedure

public constant xDrawTriangleStrip = define_c_proc(ray,"+DrawTriangleStrip",{C_POINTER,C_INT,COLOR})

public procedure DrawTriangleStrip(atom points,atom count,sequence color)
	c_proc(xDrawTriangleStrip,{points,count,color})
end procedure

public constant xDrawPoly = define_c_proc(ray,"+DrawPoly",{VECTOR2,C_INT,C_FLOAT,C_FLOAT,COLOR})

public procedure DrawPoly(sequence center,atom sides,atom radius,atom rotation,sequence color)
	c_proc(xDrawPoly,{center,sides,radius,rotation,color})
end procedure

public constant xDrawPolyLines = define_c_proc(ray,"+DrawPolyLines",{VECTOR2,C_INT,C_FLOAT,C_FLOAT,COLOR})

public procedure DrawPolyLines(sequence center,atom sides,atom radius,atom rotation,sequence color)
	c_proc(xDrawPolyLines,{center,sides,radius,rotation,color})
end procedure

public constant xDrawPolyLinesEx = define_c_proc(ray,"+DrawPolyLinesEx",{VECTOR2,C_INT,C_FLOAT,C_FLOAT,C_FLOAT,COLOR})

public procedure DrawPolyLinesEx(sequence center,atom sides,atom radius,atom rotation,atom thick,sequence color)
	c_proc(xDrawPolyLinesEx,{center,sides,radius,rotation,thick,color})
end procedure

--Splines

public constant xDrawSplineLinear = define_c_proc(ray,"+DrawSplineLinear",{C_POINTER,C_INT,C_FLOAT,COLOR})

public procedure DrawSplineLinear(atom points,atom count,atom thick,sequence color)
	c_proc(xDrawSplineLinear,{points,count,thick,color})
end procedure

public constant xDrawSplineBasis = define_c_proc(ray,"+DrawSplineBasis",{C_POINTER,C_INT,C_FLOAT,COLOR})

public procedure DrawSplineBasis(atom points,atom count,atom thick,sequence color)
	c_proc(xDrawSplineBasis,{points,count,thick,color})
end procedure

public constant xDrawSplineCatmullRom = define_c_proc(ray,"+DrawSplineCatmullRom",{C_POINTER,C_INT,C_FLOAT,COLOR})

public procedure DrawSplineCatmullRom(atom points,atom count,atom thick,sequence color)
	c_proc(xDrawSplineCatmullRom,{points,count,thick,color})
end procedure

public constant xDrawSplineBezierQuadratic = define_c_proc(ray,"+DrawSplineBezierQuadratic",{C_POINTER,C_INT,C_FLOAT,COLOR})

public procedure DrawSplineBezierQuadratic(atom points,atom count,atom thick,sequence color)
	c_proc(xDrawSplineBezierQuadratic,{points,count,thick,color})
end procedure

public constant xDrawSplineBezierCubic = define_c_proc(ray,"+DrawSplineBezierCubic",{C_POINTER,C_INT,C_FLOAT,COLOR})

public procedure DrawSplineBezierCubic(atom points,atom count,atom thick,sequence color)
	c_proc(xDrawSplineBezierCubic,{points,count,thick,color})
end procedure

public constant xDrawSplineSegmentLinear = define_c_proc(ray,"+DrawSplineSegmentLinear",{VECTOR2,VECTOR2,C_FLOAT,COLOR})

public procedure DrawSplineSegmentLinear(sequence p1,sequence p2,atom thick,sequence color)
	c_proc(xDrawSplineSegmentLinear,{p1,p2,thick,color})
end procedure

public constant xDrawSplineSegmentBasis = define_c_proc(ray,"+DrawSplineSegmentBasis",{VECTOR2,VECTOR2,VECTOR2,VECTOR2,C_FLOAT,COLOR})

public procedure DrawSplineSegmentBasis(sequence p1,sequence p2,sequence p3,sequence p4,atom thick,sequence color)
	c_proc(xDrawSplineSegmentBasis,{p1,p2,p3,p4,thick,color})
end procedure

public constant xDrawSplineSegmentCatmullRom = define_c_proc(ray,"+DrawSplineSegmentCatmullRom",{VECTOR2,VECTOR2,VECTOR2,VECTOR2,C_FLOAT,COLOR})

public procedure DrawSplineSegmentCatmullRom(sequence p1,sequence p2,sequence p3,sequence p4,atom thick,sequence color)
	c_proc(xDrawSplineSegmentCatmullRom,{p1,p2,p3,p4,thick,color})
end procedure

public constant xDrawSplineSegmentBezierQuadratic = define_c_proc(ray,"+DrawSplineSegmentBezierQuadratic",{VECTOR2,VECTOR2,VECTOR2,C_FLOAT,COLOR})

public procedure DrawSplineSegmentBezierQuadratic(sequence p1,sequence c2,sequence p3,atom thick,sequence color)
	c_proc(xDrawSplineSegmentBezierQuadratic,{p1,c2,p3,thick,color})
end procedure

public constant xDrawSplineSegmentBezierCubic = define_c_proc(ray,"+DrawSplineSegmentBezierCubic",{VECTOR2,VECTOR2,VECTOR2,VECTOR2,C_FLOAT,COLOR})

public procedure DrawSplineSegmentBezierCubic(sequence p1,sequence c2,sequence c3,sequence p4,atom thick,sequence color)
	c_proc(xDrawSplineSegmentBezierCubic,{p1,c2,c3,p4,thick,color})
end procedure

--Spline segment
public constant xGetSplinePointLinear = define_c_func(ray,"+GetSplinePointLinear",{VECTOR2,VECTOR2,C_FLOAT},VECTOR2)

public function GetSplinePointLinear(sequence startPos,sequence endPos,atom t)
	return c_func(xGetSplinePointLinear,{startPos,endPos,t})
end function

public constant xGetSplinePointBasis = define_c_func(ray,"+GetSplinePointBasis",{VECTOR2,VECTOR2,VECTOR2,VECTOR2,C_FLOAT},VECTOR2)

public function GetSplinePointBasis(sequence p1,sequence p2,sequence p3,sequence p4,atom t)
	return c_func(xGetSplinePointBasis,{p1,p2,p3,4,t})
end function

public constant xGetSplinePointCatmullRom = define_c_func(ray,"+GetSplinePointCatmullRom",{VECTOR2,VECTOR2,VECTOR2,VECTOR2,C_FLOAT},VECTOR2)

public function GetSplinePointCatmullRom(sequence p1,sequence p2,sequence p3,sequence p4,atom t)
	return c_func(xGetSplinePointCatmullRom,{p1,p2,p3,p4,t})
end function

public constant xGetSplinePointBezierQuad = define_c_func(ray,"+GetSplinePointBezierQuad",{VECTOR2,VECTOR2,VECTOR2,C_FLOAT},VECTOR2)

public function GetSplinePointBezierQuad(sequence p1,sequence c2,sequence p3,atom t)
	return c_func(xGetSplinePointBezierQuad,{p1,c2,p3,t})
end function

public constant xGetSplinePointBezierCubic = define_c_func(ray,"+GetSplinePointBezierCubic",{VECTOR2,VECTOR2,VECTOR2,VECTOR2,C_FLOAT},VECTOR2)

public function GetSplinePointBezierCubic(sequence p1,sequence c2,sequence c3,sequence p4,atom t)
	return c_func(xGetSplinePointBezierCubic,{p1,c2,c3,p4,t})
end function

--Basic shape collision
public constant xCheckCollisionRecs = define_c_func(ray,"+CheckCollisionRecs",{RECTANGLE,RECTANGLE},C_BOOL)

public function CheckCollisionRecs(sequence rec,sequence rec2)
	return c_func(xCheckCollisionRecs,{rec,rec2})
end function

public constant xCheckCollisionCircles = define_c_func(ray,"+CheckCollisionCircles",{VECTOR2,C_FLOAT,VECTOR2,C_FLOAT},C_BOOL)

public function CheckCollisionCircles(sequence center,atom radius,sequence center2,atom radius2)
	return c_func(xCheckCollisionCircles,{center,radius,center2,radius2})
end function

public constant xCheckCollisionCircleRec = define_c_func(ray,"+CheckCollisionCircleRec",{VECTOR2,C_FLOAT,RECTANGLE},C_BOOL)

public function CheckCollisionCircleRec(sequence center,atom radius,sequence rec)
	return c_func(xCheckCollisionCircleRec,{center,radius,rec})
end function

public constant xCheckCollisionCircleLine = define_c_func(ray,"+CheckCollisionCircleLine",{VECTOR2,C_FLOAT,VECTOR2,VECTOR2},C_BOOL)

public function CheckCollisionCircleLine(sequence center,atom radius,sequence p1,sequence p2)
	return c_func(xCheckCollisionCircleLine,{center,radius,p1,p2})
end function

public constant xCheckCollisionPointRec = define_c_func(ray,"+CheckCollisionPointRec",{VECTOR2,RECTANGLE},C_BOOL)

public function CheckCollisionPointRec(sequence point,sequence rec)
	return c_func(xCheckCollisionPointRec,{point,rec})
end function

public constant xCheckCollisionPointCircle = define_c_func(ray,"+CheckCollisionPointCircle",{VECTOR2,VECTOR2,C_FLOAT},C_BOOL)

public function CheckCollisionPointCircle(sequence point,sequence center,atom radius)
	return c_func(xCheckCollisionPointCircle,{point,center,radius})
end function

public constant xCheckCollisionPointTriangle = define_c_func(ray,"+CheckCollisionPointTriangle",{VECTOR2,VECTOR2,VECTOR2,VECTOR2},C_BOOL)

public function CheckCollisionPointTriangle(sequence point,sequence p1,sequence p2,sequence p3)
	return c_func(xCheckCollisionPointTriangle,{point,p1,p2,p3})
end function

public constant xCheckCollisionPointLine = define_c_func(ray,"+CheckCollisionPointLine",{VECTOR2,VECTOR2,VECTOR2,C_INT},C_BOOL)

public function CheckCollisionPointLine(sequence point,sequence p1,sequence p2,atom threshold)
	return c_func(xCheckCollisionPointLine,{point,p1,p2,threshold})
end function

public constant xCheckCollisionPointPoly = define_c_func(ray,"+CheckCollisionPointPoly",{VECTOR2,C_POINTER,C_INT},C_BOOL)

public function CheckCollisionPointPoly(sequence point,atom points,atom count)
	return c_func(xCheckCollisionPointPoly,{point,points,count})
end function

public constant xCheckCollisionLines = define_c_func(ray,"+CheckCollisionLines",{VECTOR2,VECTOR2,VECTOR2,VECTOR2,C_POINTER},C_BOOL)

public function CheckCollisionLines(sequence startPos,sequence endPos,sequence startPos2,sequence endPos2,atom collisionPoint)
	return c_func(xCheckCollisionLines,{startPos,endPos,startPos2,endPos2,collisionPoint})
end function

public constant xGetCollisionRec = define_c_func(ray,"+GetCollisionRec",{RECTANGLE,RECTANGLE},RECTANGLE)

public function GetCollisionRec(sequence rec,sequence rec2)
	return c_func(xGetCollisionRec,{rec,rec2})
end function

--Texture loading
public constant xLoadImage = define_c_func(ray,"+LoadImage",{C_STRING},IMAGE)

public function LoadImage(sequence fName)
	return c_func(xLoadImage,{fName})
end function

public constant xLoadImageRaw = define_c_func(ray,"+LoadImageRaw",{C_STRING,C_INT,C_INT,C_INT,C_INT},IMAGE)

public function LoadImageRaw(sequence fName,atom width,atom height,atom format,atom headerSize)
	return c_func(xLoadImageRaw,{fName,width,height,format,headerSize})
end function

public constant xLoadImageAnim = define_c_func(ray,"+LoadImageAnim",{C_STRING,C_POINTER},IMAGE)

public function LoadImageAnim(sequence fName,atom frames)
	return c_func(xLoadImageAnim,{fName,frames})
end function

public constant xLoadImageAnimFromMemory = define_c_func(ray,"+LoadImageAnimFromMemory",{C_STRING,C_POINTER,C_INT,C_POINTER},IMAGE)

public function LoadImageAnimFromMemory(sequence fType,atom fileData,atom dataSize,atom frames)
	return c_func(xLoadImageAnimFromMemory,{fType,fileData,dataSize,frames})
end function

public constant xLoadImageFromMemory = define_c_func(ray,"+LoadImageFromMemory",{C_STRING,C_POINTER,C_INT},IMAGE)

public function LoadImageFromMemory(sequence fType,atom fileData,atom dataSize)
	return c_func(xLoadImageFromMemory,{fType,fileData,dataSize})
end function

public constant xLoadImageFromTexture = define_c_func(ray,"+LoadImageFromTexture",{TEXTURE2D},IMAGE)

public function LoadImageFromTexture(sequence texture)
	return c_func(xLoadImageFromTexture,{texture})
end function

public constant xLoadImageFromScreen = define_c_func(ray,"+LoadImageFromScreen",{},IMAGE)

public function LoadImageFromScreen()
	return c_func(xLoadImageFromScreen,{})
end function

public constant xIsImageValid = define_c_func(ray,"+IsImageValid",{IMAGE},C_BOOL)

public function IsImageValid(sequence image)
	return c_func(xIsImageValid,{image})
end function

public constant xUnloadImage = define_c_proc(ray,"+UnloadImage",{IMAGE})

public procedure UnloadImage(sequence image)
	c_proc(xUnloadImage,{image})
end procedure

public constant xExportImage = define_c_func(ray,"+ExportImage",{IMAGE,C_STRING},C_BOOL)

public function ExportImage(sequence image,sequence fName)
	return c_func(xExportImage,{image,fName})
end function

public constant xExportImageToMemory = define_c_func(ray,"+ExportImageToMemory",{IMAGE,C_STRING,C_POINTER},C_POINTER)

public function ExportImageToMemory(sequence image,sequence fType,atom fileSize)
	return c_func(xExportImageToMemory,{image,fType,fileSize})
end function

public constant xExportImageAsCode = define_c_func(ray,"+ExportImageAsCode",{IMAGE,C_STRING},C_BOOL)

public function ExportImageAsCode(sequence image,sequence fName)
	return c_func(xExportImageAsCode,{image,fName})
end function

--Image generation
public constant xGenImageColor = define_c_func(ray,"+GenImageColor",{C_INT,C_INT,COLOR},IMAGE)

public function GenImageColor(atom width,atom height,sequence color)
	return c_func(xGenImageColor,{width,height,color})
end function

public constant xGenImageGradientLinear = define_c_func(ray,"+GenImageGradientLinear",{C_INT,C_INT,C_INT,COLOR,COLOR},IMAGE)

public function GenImageGradientLinear(atom width,atom height,atom direction,sequence start,sequence xend)
	return c_func(xGenImageGradientLinear,{width,height,direction,start,xend})
end function

public constant xGenImageGradientRadial = define_c_func(ray,"+GenImageGradientRadial",{C_INT,C_INT,C_FLOAT,COLOR,COLOR},IMAGE)

public function GenImageGradientRadial(atom width,atom height,atom density,sequence inner,sequence outer)
	return c_func(xGenImageGradientRadial,{width,height,density,inner,outer})
end function

public constant xGenImageGradientSquare = define_c_func(ray,"+GenImageGradientSquare",{C_INT,C_INT,C_FLOAT,COLOR,COLOR},IMAGE)

public function GenImageGradientSquare(atom width,atom height,atom density,sequence inner,sequence outer)
	return c_func(xGenImageGradientSquare,{width,height,density,inner,outer})
end function

public constant xGenImageChecked = define_c_func(ray,"+GenImageChecked",{C_INT,C_INT,C_INT,C_INT,COLOR,COLOR},IMAGE)

public function GenImageChecked(atom width,atom height,atom x,atom y,sequence col,sequence col2)
	return c_func(xGenImageChecked,{width,height,x,y,col,col2})
end function

public constant xGenImageWhiteNoise = define_c_func(ray,"+GenImageWhiteNoise",{C_INT,C_INT,C_FLOAT},IMAGE)

public function GenImageWhiteNoise(atom width,atom height,atom factor)
	return c_func(xGenImageWhiteNoise,{width,height,factor})
end function

public constant xGenImagePerlinNoise = define_c_func(ray,"+GenImagePerlinNoise",{C_INT,C_INT,C_INT,C_INT,C_FLOAT},IMAGE)

public function GenImagePerlinNoise(atom width,atom height,atom x,atom y,atom scale)
	return c_func(xGenImagePerlinNoise,{width,height,x,y,scale})
end function

public constant xGenImageCellular = define_c_func(ray,"+GenImageCellular",{C_INT,C_INT,C_INT},IMAGE)

public function GenImageCellular(atom width,atom height,atom tileSize)
	return c_func(xGenImageCellular,{width,height,tileSize})
end function

public constant xGenImageText = define_c_func(ray,"+GenImageText",{C_INT,C_INT,C_STRING},IMAGE)

public function GenImageText(atom width,atom height,sequence text)
	return c_func(xGenImageText,{width,height,text})
end function

--Image Manipulation
public constant xImageCopy = define_c_func(ray,"+ImageCopy",{IMAGE},IMAGE)

public function ImageCopy(sequence image)
	return c_func(xImageCopy,{image})
end function

public constant xImageFromImage = define_c_func(ray,"+ImageFromImage",{IMAGE,RECTANGLE},IMAGE)

public function ImageFromImage(sequence image,sequence rec)
	return c_func(xImageFromImage,{image,rec})
end function

public constant xImageFromChannel = define_c_func(ray,"+ImageFromChannel",{IMAGE,C_INT},IMAGE)

public function ImageFromChannel(sequence image,atom selectedChannel)
	return c_func(xImageFromChannel,{image,selectedChannel})
end function

public constant xImageText = define_c_func(ray,"+ImageText",{C_STRING,C_INT,COLOR},IMAGE)

public function ImageText(sequence text,atom fontSize,sequence color)
	return c_func(xImageText,{text,fontSize,color})
end function

public constant xImageTextEx = define_c_func(ray,"+ImageTextEx",{FONT,C_STRING,C_FLOAT,C_FLOAT,COLOR},IMAGE)

public function ImageTextEx(sequence font,sequence text,atom fontSize,atom spacing,sequence tint)
	return c_func(xImageTextEx,{font,text,fontSize,spacing,tint})
end function

public constant xImageFormat = define_c_proc(ray,"+ImageFormat",{C_POINTER,C_INT})

public procedure ImageFormat(atom image,atom newFormat)
	c_proc(xImageFormat,{image,newFormat})
end procedure

public constant xImageToPOT = define_c_proc(ray,"+ImageToPOT",{C_POINTER,COLOR})

public procedure ImageToPOT(atom image,sequence fill)
	c_proc(xImageToPOT,{image,fill})
end procedure

public constant xImageCrop = define_c_proc(ray,"+ImageCrop",{C_POINTER,RECTANGLE})

public procedure ImageCrop(atom image,sequence crop)
	c_proc(xImageCrop,{image,crop})
end procedure

public constant xImageAlphaCrop = define_c_proc(ray,"+ImageAlphaCrop",{C_POINTER,C_FLOAT})

public procedure ImageAlphaCrop(atom image,atom threshold)
	c_proc(xImageAlphaCrop,{image,threshold})
end procedure

public constant xImageAlphaClear = define_c_proc(ray,"+ImageAlphaClear",{C_POINTER,COLOR,C_FLOAT})

public procedure ImageAlphaClear(atom image,sequence color,atom threshold)
	c_proc(xImageAlphaClear,{image,color,threshold})
end procedure

public constant xImageAlphaMask = define_c_proc(ray,"+ImageAlphaMask",{C_POINTER,IMAGE})

public procedure ImageAlphaMask(atom image,sequence alphaMask)
	c_proc(xImageAlphaMask,{image,alphaMask})
end procedure

public constant xImageAlphaPremultiply = define_c_proc(ray,"+ImageAlphaPremultiply",{C_POINTER})

public procedure ImageAlphaPremultiply(atom image)
	c_proc(xImageAlphaPremultiply,{image})
end procedure

public constant xImageBlurGaussian = define_c_proc(ray,"+ImageBlurGaussian",{C_POINTER,C_INT})

public procedure ImageBlurGaussian(atom image,atom blurSize)
	c_proc(xImageBlurGaussian,{image,blurSize})
end procedure

public constant xImageKernelConvolution = define_c_proc(ray,"+ImageKernelConvolution",{C_POINTER,C_POINTER,C_INT})

public procedure ImageKernelConvolution(atom image,atom kernel,atom kernelSize)
	c_proc(xImageKernelConvolution,{image,kernel,kernelSize})
end procedure

public constant xImageResize = define_c_proc(ray,"+ImageResize",{C_POINTER,C_INT,C_INT})

public procedure ImageResize(atom image,atom newWidth,atom newHeight)
	c_proc(xImageResize,{image,newWidth,newHeight})
end procedure

public constant xImageResizeNN = define_c_proc(ray,"+ImageResizeNN",{C_POINTER,C_INT,C_INT})

public procedure ImageResizeNN(atom image,atom newWidth,atom newHeight)
	c_proc(xImageResizeNN,{image,newWidth,newHeight})
end procedure

public constant xImageResizeCanvas = define_c_proc(ray,"+ImageResizeCanvas",{C_POINTER,C_INT,C_INT,C_INT,C_INT,COLOR})

public procedure ImageResizeCanvas(atom image,atom newWidth,atom newHeight,atom x,atom y,sequence fill)
	c_proc(xImageResizeCanvas,{image,newWidth,newHeight,x,y,fill})
end procedure

public constant xImageMipmaps = define_c_proc(ray,"+ImageMipmaps",{C_POINTER})

public procedure ImageMipmaps(atom image)
	c_proc(xImageMipmaps,{image})
end procedure

public constant xImageDither = define_c_proc(ray,"+ImageDither",{C_POINTER,C_INT,C_INT,C_INT,C_INT})

public procedure ImageDither(atom image,atom r,atom g,atom b,atom a)
	c_proc(xImageDither,{image,r,g,b,a})
end procedure

public constant xImageFlipVertical = define_c_proc(ray,"+ImageFlipVertical",{C_POINTER})

public procedure ImageFlipVertical(atom image)
	c_proc(xImageFlipVertical,{image})
end procedure

public constant xImageFlipHorizontal = define_c_proc(ray,"+ImageFlipHorizontal",{C_POINTER})

public procedure ImageFlipHorizontal(atom image)
	c_proc(xImageFlipHorizontal,{image})
end procedure

public constant xImageRotate = define_c_proc(ray,"+ImageRotate",{C_POINTER,C_INT})

public procedure ImageRotate(atom image,atom degrees)
	c_proc(xImageRotate,{image,degrees})
end procedure

public constant xImageRotateCW = define_c_proc(ray,"+ImageRotateCW",{C_POINTER})

public procedure ImageRotateCW(atom image)
	c_proc(xImageRotateCW,{image})
end procedure

public constant xImageRotateCCW = define_c_proc(ray,"+ImageRotateCCW",{C_POINTER})

public procedure ImageRotateCCW(atom image)
	c_proc(xImageRotateCCW,{image})
end procedure

public constant xImageColorTint = define_c_proc(ray,"+ImageColorTint",{C_POINTER,COLOR})

public procedure ImageColorTint(atom image,sequence color)
	c_proc(xImageColorTint,{image,color})
end procedure

public constant xImageColorInvert = define_c_proc(ray,"+ImageColorInvert",{C_POINTER})

public procedure ImageColorInvert(atom image)
	c_proc(xImageColorInvert,{image})
end procedure

public constant xImageColorGrayscale = define_c_proc(ray,"+ImageColorGrayscale",{C_POINTER})

public procedure ImageColorGrayscale(atom image)
	c_proc(xImageColorGrayscale,{image})
end procedure

public constant xImageColorContrast = define_c_proc(ray,"+ImageColorContrast",{C_POINTER,C_FLOAT})

public procedure ImageColorContrast(atom image,atom contrast)
	c_proc(xImageColorContrast,{image,contrast})
end procedure

public constant xImageColorBrightness = define_c_proc(ray,"+ImageColorBrightness",{C_POINTER,C_INT})

public procedure ImageColorBrightness(atom image,atom brightness)
	c_proc(xImageColorBrightness,{image,brightness})
end procedure

public constant xImageColorReplace = define_c_proc(ray,"+ImageColorReplace",{C_POINTER,COLOR,COLOR})

public procedure ImageColorReplace(atom image,sequence color,sequence replace)
	c_proc(xImageColorReplace,{image,color,replace})
end procedure

public constant xLoadImageColors = define_c_func(ray,"+LoadImageColors",{IMAGE},C_POINTER)

public function LoadImageColors(sequence image)
	return c_func(xLoadImageColors,{image})
end function

public constant xLoadImagePalette = define_c_func(ray,"+LoadImagePalette",{IMAGE,C_INT,C_POINTER},C_POINTER)

public function LoadImagePalette(sequence image,atom maxPaletteSize,atom colorCount)
	return c_func(xLoadImagePalette,{image,maxPaletteSize,colorCount})
end function

public constant xUnloadImageColors = define_c_proc(ray,"+UnloadImageColors",{C_POINTER})

public procedure UnloadImageColors(atom colors)
	c_proc(xUnloadImageColors,{colors})
end procedure

public constant xUnloadImagePalette = define_c_proc(ray,"+UnloadImagePalette",{C_POINTER})

public procedure UnloadImagePalette(atom colors)
	c_proc(xUnloadImagePalette,{colors})
end procedure

public constant xGetImageAlphaBorder = define_c_func(ray,"+GetImageAlphaBorder",{IMAGE,C_FLOAT},RECTANGLE)

public function GetImageAlphaBorder(sequence image,atom threshold)
	return c_func(xGetImageAlphaBorder,{image,threshold})
end function

public constant xGetImageColor = define_c_func(ray,"+GetImageColor",{IMAGE,C_INT,C_INT},COLOR)

public function GetImageColor(sequence image,atom x,atom y)
	return c_func(xGetImageColor,{image,x,y})
end function

--Image drawing

public constant xImageClearBackground = define_c_proc(ray,"+ImageClearBackground",{C_POINTER,COLOR})

public procedure ImageClearBackground(atom image,sequence color)
	c_proc(xImageClearBackground,{image,color})
end procedure

public constant xImageDrawPixel = define_c_proc(ray,"+ImageDrawPixel",{C_POINTER,C_INT,C_INT,COLOR})

public procedure ImageDrawPixel(atom dst,atom x,atom y,sequence color)
	c_proc(xImageDrawPixel,{dst,x,y,color})
end procedure

public constant xImageDrawPixelV = define_c_proc(ray,"+ImageDrawPixelV",{C_POINTER,VECTOR2,COLOR})

public procedure ImageDrawPixelV(atom dst,sequence pos,sequence color)
	c_proc(xImageDrawPixelV,{dst,pos,color})
end procedure

public constant xImageDrawLine = define_c_proc(ray,"+ImageDrawLine",{C_POINTER,C_INT,C_INT,C_INT,C_INT,COLOR})

public procedure ImageDrawLine(atom dst,atom x,atom y,atom ex,atom ey,sequence color)
	c_proc(xImageDrawLine,{dst,x,y,ex,ey,color})
end procedure

public constant xImageDrawLineV = define_c_proc(ray,"+ImageDrawLineV",{C_POINTER,VECTOR2,VECTOR2,COLOR})

public procedure ImageDrawLineV(atom dst,sequence start,sequence xend,sequence color)
	c_proc(xImageDrawLineV,{dst,start,xend,color})
end procedure

public constant xImageDrawLineEx = define_c_proc(ray,"+ImageDrawLineEx",{C_POINTER,VECTOR2,VECTOR2,C_INT,COLOR})

public procedure ImageDrawLineEx(atom dst,sequence start,sequence xend,atom thick,sequence color)
	c_proc(xImageDrawLineEx,{dst,start,xend,thick,color})
end procedure

public constant xImageDrawCircle = define_c_proc(ray,"+ImageDrawCircle",{C_POINTER,C_INT,C_INT,C_INT,COLOR})

public procedure ImageDrawCircle(atom dst,atom x,atom y,atom radius,sequence color)
	c_proc(xImageDrawCircle,{dst,x,y,radius,color})
end procedure

public constant xImageDrawCircleV = define_c_proc(ray,"+ImageDrawCircleV",{C_POINTER,VECTOR2,C_INT,COLOR})

public procedure ImageDrawCircleV(atom dst,sequence center,atom radius,sequence color)
	c_proc(xImageDrawCircleV,{dst,center,radius,color})
end procedure

public constant xImageDrawCircleLines = define_c_proc(ray,"+ImageDrawCircleLines",{C_POINTER,C_INT,C_INT,C_INT,COLOR})

public procedure ImageDrawCircleLines(atom dst,atom x,atom y,atom radius,sequence color)
	c_proc(xImageDrawCircleLines,{dst,x,y,radius,color})
end procedure

public constant xImageDrawCircleLinesV = define_c_proc(ray,"+ImageDrawCircleLinesV",{C_POINTER,VECTOR2,C_INT,COLOR})

public procedure ImageDrawCircleLinesV(atom dst,sequence center,atom radius,sequence color)
	c_proc(xImageDrawCircleLinesV,{dst,center,radius,color})
end procedure

public constant xImageDrawRectangle = define_c_proc(ray,"+ImageDrawRectangle",{C_POINTER,C_INT,C_INT,C_INT,C_INT,COLOR})

public procedure ImageDrawRectangle(atom dst,atom x,atom y,atom width,atom height,sequence color)
	c_proc(xImageDrawRectangle,{dst,x,y,width,height,color})
end procedure

public constant xImageDrawRectangleV = define_c_proc(ray,"+ImageDrawRectangleV",{C_POINTER,VECTOR2,VECTOR2,COLOR})

public procedure ImageDrawRectangleV(atom dst,sequence pos,sequence size,sequence color)
	c_proc(xImageDrawRectangleV,{dst,pos,size,color})
end procedure

public constant xImageDrawRectangleRec = define_c_proc(ray,"+ImageDrawRectangleRec",{C_POINTER,RECTANGLE,COLOR})

public procedure ImageDrawRectangleRec(atom dst,sequence rec,sequence color)
	c_proc(xImageDrawRectangleRec,{dst,rec,color})
end procedure

public constant xImageDrawRectangleLines = define_c_proc(ray,"+ImageDrawRectangleLines",{C_POINTER,RECTANGLE,C_INT,COLOR})

public procedure ImageDrawRectangleLines(atom dst,sequence rec,atom thick,sequence color)
	c_proc(xImageDrawRectangleLines,{dst,rec,thick,color})
end procedure

public constant xImageDrawTriangle = define_c_proc(ray,"+ImageDrawTriangle",{C_POINTER,VECTOR2,VECTOR2,VECTOR2,COLOR})

public procedure ImageDrawTriangle(atom dst,sequence v,sequence v2,sequence v3,sequence color)
	c_proc(xImageDrawTriangle,{dst,v,v2,v3,color})
end procedure

public constant xImageDrawTriangleEx = define_c_proc(ray,"+ImageDrawTriangleEx",{C_POINTER,VECTOR2,VECTOR2,VECTOR2,COLOR,COLOR,COLOR})

public procedure ImageDrawTriangleEx(atom dst,sequence v,sequence v2,sequence v3,sequence c,sequence c2,sequence c3)
	c_proc(xImageDrawTriangleEx,{dst,v,v2,v3,c,c2,c3})
end procedure

public constant xImageDrawTriangleLines = define_c_proc(ray,"+ImageDrawTriangleLines",{C_POINTER,VECTOR2,VECTOR2,VECTOR2,COLOR})

public procedure ImageDrawTriangleLines(atom dst,sequence v,sequence v2,sequence v3,sequence color)
	c_proc(xImageDrawTriangleLines,{dst,v,v2,v3,color})
end procedure

public constant xImageDrawTriangleFan = define_c_proc(ray,"+ImageDrawTriangleFan",{C_POINTER,C_POINTER,C_INT,COLOR})

public procedure ImageDrawTriangleFan(atom dst,atom points,atom count,sequence color)
	c_proc(xImageDrawTriangleFan,{dst,points,count,color})
end procedure

public constant xImageDrawTriangleStrip = define_c_proc(ray,"+ImageDrawTriangleStrip",{C_POINTER,C_POINTER,C_INT,COLOR})

public procedure ImageDrawTriangleStrip(atom dst,atom points,atom count,sequence color)
	c_proc(xImageDrawTriangleStrip,{dst,points,count,color})
end procedure

public constant xImageDraw = define_c_proc(ray,"+ImageDraw",{C_POINTER,IMAGE,RECTANGLE,RECTANGLE,COLOR})

public procedure ImageDraw(atom dst,sequence src,sequence srcRec,sequence dstRec,sequence tint)
	c_proc(xImageDraw,{dst,src,srcRec,dstRec,tint})
end procedure

public constant xImageDrawText = define_c_proc(ray,"+ImageDrawText",{C_POINTER,C_STRING,C_INT,C_INT,C_INT,COLOR})

public procedure ImageDrawText(atom dst,sequence text,atom x,atom y,atom fontSize,sequence color)
	c_proc(xImageDrawText,{dst,text,x,y,fontSize,color})
end procedure

public constant xImageDrawTextEx = define_c_proc(ray,"+ImageDrawTextEx",{C_POINTER,FONT,C_STRING,VECTOR2,C_FLOAT,C_FLOAT,COLOR})

public procedure ImageDrawTextEx(atom dst,sequence font,sequence text,sequence pos,atom fontSize,atom spacing,sequence tint)
	c_proc(xImageDrawTextEx,{dst,font,text,pos,fontSize,spacing,tint})
end procedure

--Texture2D loading
public constant xLoadTexture = define_c_func(ray,"+LoadTexture",{C_STRING},TEXTURE2D)

public function LoadTexture(sequence fname)
	return c_func(xLoadTexture,{fname})
end function

public constant xLoadTextureFromImage = define_c_func(ray,"+LoadTextureFromImage",{IMAGE},TEXTURE2D)

public function LoadTextureFromImage(sequence image)
	return c_func(xLoadTextureFromImage,{image})
end function

public constant xLoadTextureCubemap = define_c_func(ray,"+LoadTextureCubemap",{IMAGE,C_INT},TEXTURECUBEMAP)

public function LoadTextureCubemap(sequence image,atom layout)
	return c_func(xLoadTextureCubemap,{image,layout})
end function

public constant xLoadRenderTexture = define_c_func(ray,"+LoadRenderTexture",{C_INT,C_INT},RENDERTEXTURE2D)

public function LoadRenderTexture(atom width,atom height)
	return c_func(xLoadRenderTexture,{width,height})
end function

public constant xIsTextureValid = define_c_func(ray,"+IsTextureValid",{TEXTURE2D},C_BOOL)

public function IsTextureValid(sequence texture)
	return c_func(xIsTextureValid,{texture})
end function

public constant xUnloadTexture = define_c_proc(ray,"+UnloadTexture",{TEXTURE2D})

public procedure UnloadTexture(sequence texture)
	c_proc(xUnloadTexture,{texture})
end procedure

public constant xIsRenderTextureValid = define_c_func(ray,"+IsRenderTextureValid",{RENDERTEXTURE2D},C_BOOL)

public function IsRenderTextureValid(sequence target)
	return c_func(xIsRenderTextureValid,{target})
end function

public constant xUnloadRenderTexture = define_c_proc(ray,"+UnloadRenderTexture",{RENDERTEXTURE2D})

public procedure UnloadRenderTexture(sequence target)
	c_proc(xUnloadRenderTexture,{target})
end procedure

public constant xUpdateTexture = define_c_proc(ray,"+UpdateTexture",{TEXTURE2D,C_POINTER})

public procedure UpdateTexture(sequence texture,atom pixels)
	c_proc(xUpdateTexture,{texture,pixels})
end procedure

public constant xUpdateTextureRec = define_c_proc(ray,"+UpdateTextureRec",{TEXTURE2D,RECTANGLE,C_POINTER})

public procedure UpdateTextureRec(sequence texture,sequence rec,atom pixels)
	c_proc(xUpdateTextureRec,{texture,rec,pixels})
end procedure

--Texture config
public constant xGenTextureMipmaps = define_c_proc(ray,"+GenTextureMipmaps",{C_POINTER})

public procedure GenTextureMipmaps(atom texture)
	c_proc(xGenTextureMipmaps,{texture})
end procedure

public constant xSetTextureFilter = define_c_proc(ray,"+SetTextureFilter",{TEXTURE2D,C_INT})

public procedure SetTextureFilter(sequence texture,atom filter)
	c_proc(xSetTextureFilter,{texture,filter})
end procedure

public constant xSetTextureWrap = define_c_proc(ray,"+SetTextureWrap",{TEXTURE2D,C_INT})

public procedure SetTextureWrap(sequence texture,atom wrap)
	c_proc(xSetTextureWrap,{texture,wrap})
end procedure

--Texture drawing
public constant xDrawTexture = define_c_proc(ray,"+DrawTexture",{TEXTURE2D,C_INT,C_INT,COLOR})

public procedure DrawTexture(sequence texture,atom x,atom y,sequence tint)
	c_proc(xDrawTexture,{texture,x,y,tint})
end procedure

public constant xDrawTextureV = define_c_proc(ray,"+DrawTextureV",{TEXTURE2D,VECTOR2,COLOR})

public procedure DrawTextureV(sequence texture,sequence pos,sequence tint)
	c_proc(xDrawTextureV,{texture,pos,tint})
end procedure

public constant xDrawTextureEx = define_c_proc(ray,"+DrawTextureEx",{TEXTURE2D,VECTOR2,C_FLOAT,C_FLOAT,COLOR})

public procedure DrawTextureEx(sequence texture,sequence pos,atom rotation,atom scale,sequence color)
	c_proc(xDrawTextureEx,{texture,pos,rotation,scale,color})
end procedure

public constant xDrawTextureRec = define_c_proc(ray,"+DrawTextureRec",{TEXTURE2D,RECTANGLE,VECTOR2,COLOR})

public procedure DrawTextureRec(sequence texture,sequence source,sequence pos,sequence tint)
	c_proc(xDrawTextureRec,{texture,source,pos,tint})
end procedure

public constant xDrawTexturePro = define_c_proc(ray,"+DrawTexturePro",{TEXTURE2D,RECTANGLE,RECTANGLE,VECTOR2,C_FLOAT,COLOR})

public procedure DrawTexturePro(sequence texture,sequence source,sequence dest,sequence origin,atom rotation,sequence tint)
	c_proc(xDrawTexturePro,{texture,source,dest,origin,rotation,tint})
end procedure

public constant xDrawTextureNPatch = define_c_proc(ray,"+DrawTextureNPatch",{TEXTURE2D,NPATCHINFO,RECTANGLE,VECTOR2,C_FLOAT,COLOR})

public procedure DrawTextureNPatch(sequence texture,sequence nPatchInfo,sequence dest,sequence origin,atom rotation,sequence tint)
	c_proc(xDrawTextureNPatch,{texture,nPatchInfo,dest,origin,rotation,tint})
end procedure

--Color/Pixel
public constant xColorIsEqual = define_c_func(ray,"+ColorIsEqual",{COLOR,COLOR},C_BOOL)

public function ColorIsEqual(sequence col,sequence col2)
	return c_func(xColorIsEqual,{col,col2})
end function

public constant xFade = define_c_func(ray,"+Fade",{COLOR,C_FLOAT},COLOR)

public function Fade(sequence color,atom alpha)
	return c_func(xFade,{color,alpha})
end function

public constant xColorToInt = define_c_func(ray,"+ColorToInt",{COLOR},C_INT)

public function ColorToInt(sequence color)
	return c_func(xColorToInt,{color})
end function

public constant xColorNormalize = define_c_func(ray,"+ColorNormalize",{COLOR},VECTOR4)

public function ColorNormalize(sequence color)
	return c_func(xColorNormalize,{color})
end function

public constant xColorFromNormalized = define_c_func(ray,"+ColorFromNormalized",{VECTOR4},COLOR)

public function ColorFromNormalized(sequence normalized)
	return c_func(xColorFromNormalized,{normalized})
end function

public constant xColorToHSV = define_c_func(ray,"+ColorToHSV",{COLOR},VECTOR3)

public function ColorToHSV(sequence color)
	return c_func(xColorToHSV,{color})
end function

public constant xColorFromHSV = define_c_func(ray,"+ColorFromHSV",{C_FLOAT,C_FLOAT,C_FLOAT},COLOR)

public function ColorFromHSV(atom hue,atom saturation,atom val)
	return c_func(xColorFromHSV,{hue,saturation,val})
end function

public constant xColorTint = define_c_func(ray,"+ColorTint",{COLOR,COLOR},COLOR)

public function ColorTint(sequence color,sequence tint)
	return c_func(xColorTint,{color,tint})
end function

public constant xColorBrightness = define_c_func(ray,"+ColorBrightness",{COLOR,C_FLOAT},COLOR)

public function ColorBrightness(sequence color,atom factor)
	return c_func(xColorBrightness,{color,factor})
end function

public constant xColorContrast = define_c_func(ray,"+ColorContrast",{COLOR,C_FLOAT},COLOR)

public function ColorContrast(sequence color,atom contrast)
	return c_func(xColorContrast,{color,contrast})
end function

public constant xColorAlpha = define_c_func(ray,"+ColorAlpha",{COLOR,C_FLOAT},COLOR)

public function ColorAlpha(sequence color,atom alpha)
	return c_func(xColorAlpha,{color,alpha})
end function

public constant xColorAlphaBlend = define_c_func(ray,"+ColorAlphaBlend",{COLOR,COLOR,COLOR},COLOR)

public function ColorAlphaBlend(sequence dst,sequence src,sequence tint)
	return c_func(xColorAlphaBlend,{dst,src,tint})
end function

public constant xColorLerp = define_c_func(ray,"+ColorLerp",{COLOR,COLOR,C_FLOAT},COLOR)

public function ColorLerp(sequence color,sequence color2,atom factor)
	return c_func(xColorLerp,{color,color2,factor})
end function

public constant xGetColor = define_c_func(ray,"+GetColor",{C_UINT},COLOR)

public function GetColor(atom hexVal)
	return c_func(xGetColor,{hexVal})
end function

public constant xGetPixelColor = define_c_func(ray,"+GetPixelColor",{C_POINTER,C_INT},COLOR)

public function GetPixelColor(atom srcPtr,atom format)
	return c_func(xGetPixelColor,{srcPtr,format})
end function

public constant xSetPixelColor = define_c_proc(ray,"+SetPixelColor",{C_POINTER,COLOR,C_INT})

public procedure SetPixelColor(atom dstPtr,sequence color,atom format)
	c_proc(xSetPixelColor,{dstPtr,color,format})
end procedure

public constant xGetPixelDataSize = define_c_func(ray,"+GetPixelDataSize",{C_INT,C_INT,C_INT},C_INT)

public function GetPixelDataSize(atom width,atom height,atom format)
	return c_func(xGetPixelDataSize,{width,height,format})
end function

--Font loading
public constant xGetFontDefault = define_c_func(ray,"+GetFontDefault",{},FONT)

public function GetFontDefault()
	return c_func(xGetFontDefault,{})
end function

public constant xLoadFont = define_c_func(ray,"+LoadFont",{C_STRING},FONT)

public function LoadFont(sequence fname)
	return c_func(xLoadFont,{fname})
end function

public constant xLoadFontEx = define_c_func(ray,"+LoadFontEx",{C_STRING,C_INT,C_POINTER,C_INT},FONT)

public function LoadFontEx(sequence fname,atom fontSize,atom points,atom count)
	return c_func(xLoadFontEx,{fname,fontSize,points,count})
end function

public constant xLoadFontFromImage = define_c_func(ray,"+LoadFontFromImage",{IMAGE,COLOR,C_INT},FONT)

public function LoadFontFromImage(sequence image,sequence key,atom firstChar)
	return c_func(xLoadFontFromImage,{image,key,firstChar})
end function

public constant xLoadFontFromMemory = define_c_func(ray,"+LoadFontFromMemory",{C_STRING,C_POINTER,C_INT,C_INT,C_POINTER,C_INT},FONT)

public function LoadFontFromMemory(sequence fType,atom fileData,atom dataSize,atom fontSize,atom points,atom count)
	return c_func(xLoadFontFromMemory,{fType,fileData,dataSize,fontSize,points,count})
end function

public constant xIsFontValid = define_c_func(ray,"+IsFontValid",{FONT},C_BOOL)

public function IsFontValid(sequence font)
	return c_func(xIsFontValid,{font})
end function

public constant xLoadFontData = define_c_func(ray,"+LoadFontData",{C_POINTER,C_INT,C_INT,C_POINTER,C_INT,C_INT,C_POINTER},C_POINTER)

public function LoadFontData(atom fileData,atom dataSize,atom fontSize,atom points,atom count,atom xtype,atom glyphCount)
	return c_func(xLoadFontData,{fileData,dataSize,fontSize,points,count,xtype,glyphCount})
end function

public constant xGenImageFontAtlas = define_c_func(ray,"+GenImageFontAtlas",{C_POINTER,C_POINTER,C_INT,C_INT,C_INT,C_INT},IMAGE)

public function GenImageFontAtlas(atom glyphs,atom glyphRecs,atom count,atom fontSize,atom padding,atom method)
	return c_func(xGenImageFontAtlas,{glyphs,glyphRecs,count,fontSize,padding,method})
end function

public constant xUnloadFontData = define_c_proc(ray,"+UnloadFontData",{C_POINTER,C_INT})

public procedure UnloadFontData(atom glyphs,atom count)
	c_proc(xUnloadFontData,{glyphs,count})
end procedure

public constant xUnloadFont = define_c_proc(ray,"+UnloadFont",{FONT})

public procedure UnloadFont(sequence font)
	c_proc(xUnloadFont,{font})
end procedure

public constant xExportFontAsCode = define_c_func(ray,"+ExportFontAsCode",{FONT,C_STRING},C_BOOL)

public function ExportFontAsCode(sequence font,sequence fname)
	return c_func(xExportFontAsCode,{font,fname})
end function

--Text drawing functions
public constant xDrawFPS = define_c_proc(ray,"+DrawFPS",{C_INT,C_INT}),
				xDrawText = define_c_proc(ray,"+DrawText",{C_STRING,C_INT,C_INT,C_INT,COLOR}),
				xDrawTextEx = define_c_proc(ray,"+DrawTextEx",{FONT,C_STRING,VECTOR2,C_FLOAT,C_FLOAT,COLOR}),
				xDrawTextPro = define_c_proc(ray,"+DrawTextPro",{FONT,C_STRING,VECTOR2,VECTOR2,C_FLOAT,C_FLOAT,C_FLOAT,COLOR}),
				xDrawTextCodepoint = define_c_proc(ray,"+DrawTextCodepoint",{FONT,C_INT,VECTOR2,C_FLOAT,COLOR}),
				xDrawTextCodepoints = define_c_proc(ray,"+DrawTextCodepoints",{FONT,C_POINTER,C_INT,VECTOR2,C_FLOAT,C_FLOAT,COLOR})
				
public procedure DrawFPS(atom x,atom y)
	c_proc(xDrawFPS,{x,y})
end procedure

public procedure DrawText(sequence text,atom x,atom y,atom fontSize,sequence color)
	c_proc(xDrawText,{text,x,y,fontSize,color})
end procedure

public procedure DrawTextEx(sequence font,sequence text,sequence pos,atom fontSize,atom spacing,sequence tint)
	c_proc(xDrawTextEx,{font,text,pos,fontSize,spacing,tint})
end procedure

public procedure DrawTextPro(sequence font,sequence text,sequence pos,sequence origin,atom rotation,atom fontSize,atom spacing,sequence tint)
	c_proc(xDrawTextPro,{font,text,pos,origin,rotation,fontSize,spacing,tint})
end procedure

public procedure DrawTextCodepoint(sequence font,atom codepoint,sequence pos,atom fontSize,sequence tint)
	c_proc(xDrawTextCodepoint,{font,codepoint,pos,fontSize,tint})
end procedure

public procedure DrawTextCodepoints(sequence font,atom codepoints,atom codepointCount,sequence pos,atom fontSize,atom spacing,sequence tint)
	c_proc(xDrawTextCodepoints,{font,codepoints,codepointCount,pos,fontSize,spacing,tint})
end procedure

--Text font info
public constant xSetTextLineSpacing = define_c_proc(ray,"+SetTextLineSpacing",{C_INT})

public procedure SetTextLineSpacing(atom spacing)
	c_proc(xSetTextLineSpacing,{spacing})
end procedure

public constant xMeasureText = define_c_func(ray,"+MeasureText",{C_STRING,C_INT},C_INT)

public function MeasureText(sequence text,atom fontSize)
	return c_func(xMeasureText,{text,fontSize})
end function

public constant xMeasureTextEx = define_c_func(ray,"+MeasureTextEx",{FONT,C_STRING,C_FLOAT,C_FLOAT},VECTOR2)

public function MeasureTextEx(sequence font,sequence text,atom fontSize,atom spacing)
	return c_func(xMeasureTextEx,{font,text,fontSize,spacing})
end function

public constant xMeasureTextCodepoints = define_c_func(ray,"+MeasureTextCodepoints",{FONT,C_POINTER,C_INT,C_FLOAT,C_FLOAT},VECTOR2)

public function MeasureTextCodepoints(sequence font,atom points,atom len,atom fontSize,atom spacing)
	return c_func(xMeasureTextCodepoints,{font,points,len,fontSize,spacing})
end function

public constant xGetGlyphIndex = define_c_func(ray,"+GetGlyphIndex",{FONT,C_INT},C_INT)

public function GetGlyphIndex(sequence font,atom point)
	return c_func(xGetGlyphIndex,{font,point})
end function

public constant xGetGlyphInfo = define_c_func(ray,"+GetGlyphInfo",{FONT,C_INT},GLYPHINFO)

public function GetGlyphInfo(sequence font,atom point)
	return c_func(xGetGlyphInfo,{font,point})
end function

public constant xGetGlyphAtlasRec = define_c_func(ray,"+GetGlyphAtlasRec",{FONT,C_INT},RECTANGLE)

public function GetGlyphAtlasRec(sequence font,atom point)
	return c_func(xGetGlyphAtlasRec,{font,point})
end function

--Text codepoints
public constant xLoadUTF8 = define_c_func(ray,"+LoadUTF8",{C_POINTER,C_INT},C_POINTER)

public function LoadUTF8(atom points,atom len)
	return c_func(xLoadUTF8,{points,len})
end function

public constant xUnloadUTF8 = define_c_proc(ray,"+UnloadUTF8",{C_STRING})

public procedure UnloadUTF8(sequence text)
	c_proc(xUnloadUTF8,{text})
end procedure

public constant xLoadCodepoints = define_c_func(ray,"+LoadCodepoints",{C_STRING,C_POINTER},C_POINTER)

public function LoadCodepoints(sequence text,atom count)
	return c_func(xLoadCodepoints,{text,count})
end function

public constant xUnloadCodepoints = define_c_proc(ray,"+UnloadCodepoints",{C_POINTER})

public procedure UnloadCodepoints(atom points)
	c_proc(xUnloadCodepoints,{points})
end procedure

public constant xGetCodepointCount = define_c_func(ray,"+GetCodepointCount",{C_STRING},C_INT)

public function GetCodepointCount(sequence text)
	return c_func(xGetCodepointCount,{text})
end function

public constant xGetCodepoint = define_c_func(ray,"+GetCodepoint",{C_STRING,C_POINTER},C_INT)

public function GetCodepoint(sequence text,atom size)
	return c_func(xGetCodepoint,{text,size})
end function

public constant xGetCodepointNext = define_c_func(ray,"+GetCodepointNext",{C_STRING,C_POINTER},C_INT)

public function GetCodepointNext(sequence text,atom size)
	return c_func(xGetCodepointNext,{text,size})
end function

public constant xGetCodepointPrevious = define_c_func(ray,"+GetCodepointPrevious",{C_STRING,C_POINTER},C_INT)

public function GetCodepointPrevious(sequence text,atom size)
	return c_func(xGetCodepointPrevious,{text,size})
end function

public constant xCodepointToUTF8 = define_c_func(ray,"+CodepointToUTF8",{C_INT,C_POINTER},C_STRING)

public function CodepointToUTF8(atom point,atom size)
	return c_func(xCodepointToUTF8,{point,size})
end function

--Text strings
public constant xLoadTextLines = define_c_func(ray,"+LoadTextLines",{C_STRING,C_POINTER},C_POINTER)

public function LoadTextLines(sequence text,atom count)
	return c_func(xLoadTextLines,{text,count})
end function

public constant xUnloadTextLines = define_c_proc(ray,"+UnloadTextLines",{C_POINTER,C_INT})

public procedure UnloadTextLines(sequence text,atom count)
	c_proc(xUnloadTextLines,{text,count})
end procedure

public constant xTextCopy = define_c_func(ray,"+TextCopy",{C_STRING,C_STRING},C_INT)

public function TextCopy(sequence dst,sequence src)
	return c_func(xTextCopy,{dst,src})
end function

public constant xTextIsEqual = define_c_func(ray,"+TextIsEqual",{C_STRING,C_STRING},C_BOOL)

public function TextIsEqual(sequence text,sequence text2)
	return c_func(xTextIsEqual,{text,text2})
end function

public constant xTextLength = define_c_func(ray,"+TextLength",{C_STRING},C_UINT)

public function TextLength(sequence text)
	return c_func(xTextLength,{text})
end function

public constant xTextFormat = define_c_func(ray,"+TextFormat",{C_STRING,C_POINTER},C_STRING)

public function TextFormat(sequence text,object x)
	return c_func(xTextFormat,{text,x})
end function

public constant xTextSubtext = define_c_func(ray,"+TextSubtext",{C_STRING,C_INT,C_INT},C_STRING)

public function TextSubtext(sequence text,atom pos,atom len)
	return c_func(xTextSubtext,{text,pos,len})
end function

public constant xTextRemoveSpaces = define_c_func(ray,"+TextRemoveSpaces",{C_STRING},C_STRING)

public function TextRemoveSpaces(sequence text)
	return c_func(xTextRemoveSpaces,{text})
end function

public constant xGetTextBetween = define_c_func(ray,"+GetTextBetween",{C_STRING,C_STRING,C_STRING},C_STRING)

public function GetTextBetween(sequence text,sequence begin,sequence xend)
	return c_func(xGetTextBetween,{text,begin,xend})
end function

public constant xTextReplace = define_c_func(ray,"+TextReplace",{C_STRING,C_STRING,C_STRING},C_STRING)

public function TextReplace(sequence text,sequence search,sequence replacement)
	return c_func(xTextReplace,{text,search,replacement})
end function

public constant xTextReplaceAlloc = define_c_func(ray,"+TextReplaceAlloc",{C_STRING,C_STRING,C_STRING},C_STRING)

public function TextReplaceAlloc(sequence text,sequence search,sequence replacement)
	return c_func(xTextReplaceAlloc,{text,search,replacement})
end function

public constant xTextReplaceBetween = define_c_func(ray,"+TextReplaceBetween",{C_STRING,C_STRING,C_STRING,C_STRING},C_STRING)

public function TextReplaceBetween(sequence text,sequence begin,sequence xend,sequence replacement)
	return c_func(xTextReplaceBetween,{text,begin,xend,replacement})
end function

public constant xTextReplaceBetweenAlloc = define_c_func(ray,"+TextReplaceBetweenAlloc",{C_STRING,C_STRING,C_STRING,C_STRING},C_STRING)

public function TextReplaceBetweenAlloc(sequence text,sequence begin,sequence xend,sequence replacement)
	return c_func(xTextReplaceBetweenAlloc,{text,begin,xend,replacement})
end function

public constant xTextInsert = define_c_func(ray,"+TextInsert",{C_STRING,C_STRING,C_INT},C_STRING)

public function TextInsert(sequence text,sequence insert,atom pos)
	return c_func(xTextInsert,{text,insert,pos})
end function

public constant xTextInsertAlloc = define_c_func(ray,"+TextInsertAlloc",{C_STRING,C_STRING,C_INT},C_STRING)

public function TextInsertAlloc(sequence text,sequence insert,atom pos)
	return c_func(xTextInsertAlloc,{text,insert,pos})
end function

public constant xTextJoin = define_c_func(ray,"+TextJoin",{C_POINTER,C_INT,C_STRING},C_STRING)

public function TextJoin(sequence textList,atom count,sequence delimiter)
	return c_func(xTextJoin,{textList,count,delimiter})
end function

public constant xTextSplit = define_c_func(ray,"+TextSplit",{C_STRING,C_CHAR,C_POINTER},C_POINTER)

public function TextSplit(sequence text,atom delimiter,atom count)
	return c_func(xTextSplit,{text,delimiter,count})
end function

public constant xTextAppend = define_c_proc(ray,"+TextAppend",{C_STRING,C_STRING,C_POINTER})

public procedure TextAppend(sequence text,sequence xappend,atom pos)
	c_proc(xTextAppend,{text,xappend,pos})
end procedure

public constant xTextFindIndex = define_c_func(ray,"+TextFindIndex",{C_STRING,C_STRING},C_INT)

public function TextFindIndex(sequence text,sequence search)
	return c_func(xTextFindIndex,{text,search})
end function

public constant xTextToUpper = define_c_func(ray,"+TextToUpper",{C_STRING},C_STRING)

public function TextToUpper(sequence text)
	return c_func(xTextToUpper,{text})	
end function

public constant xTextToLower = define_c_func(ray,"+TextToLower",{C_STRING},C_STRING)

public function TextToLower(sequence text)
	return c_func(xTextToLower,{text})
end function

public constant xTextToPascal = define_c_func(ray,"+TextToPascal",{C_STRING},C_STRING)

public function TextToPascal(sequence text)
	return c_func(xTextToPascal,{text})
end function

public constant xTextToSnake = define_c_func(ray,"+TextToSnake",{C_STRING},C_STRING)

public function TextToSnake(sequence text)
	return c_func(xTextToSnake,{text})
end function

public constant xTextToCamel = define_c_func(ray,"+TextToCamel",{C_STRING},C_STRING)

public function TextToCamel(sequence text)
	return c_func(xTextToCamel,{text})
end function

public constant xTextToInteger = define_c_func(ray,"+TextToInteger",{C_STRING},C_INT)

public function TextToInteger(sequence text)
	return c_func(xTextToInteger,{text})
end function

public constant xTextToFloat = define_c_func(ray,"+TextToFloat",{C_STRING},C_FLOAT)

public function TextToFloat(sequence text)
	return c_func(xTextToFloat,{text})
end function

--Basic 3D shapes
public constant 
    xDrawLine3D          = define_c_proc(ray,"+DrawLine3D",{VECTOR3,VECTOR3,COLOR}),
    xDrawPoint3D         = define_c_proc(ray,"+DrawPoint3D",{VECTOR3,COLOR}),
    xDrawCircle3D        = define_c_proc(ray,"+DrawCircle3D",{VECTOR3,C_FLOAT,VECTOR3,C_FLOAT,COLOR}),
    xDrawTriangle3D      = define_c_proc(ray,"+DrawTriangle3D",{VECTOR3,VECTOR3,VECTOR3,COLOR}),
    xDrawTriangleStrip3D = define_c_proc(ray,"+DrawTriangleStrip3D",{C_POINTER,C_INT,COLOR}),
    xDrawCube            = define_c_proc(ray,"+DrawCube",{VECTOR3,C_FLOAT,C_FLOAT,C_FLOAT,COLOR}),
    xDrawCubeV           = define_c_proc(ray,"+DrawCubeV",{VECTOR3,VECTOR3,COLOR}),
    xDrawCubeWires       = define_c_proc(ray,"+DrawCubeWires",{VECTOR3,C_FLOAT,C_FLOAT,C_FLOAT,COLOR}),
    xDrawCubeWiresV      = define_c_proc(ray,"+DrawCubeWiresV",{VECTOR3,VECTOR3,COLOR}),
    xDrawSphere          = define_c_proc(ray,"+DrawSphere",{VECTOR3,C_FLOAT,COLOR}),
    xDrawSphereEx        = define_c_proc(ray,"+DrawSphereEx",{VECTOR3,C_FLOAT,C_INT,C_INT,COLOR}),
    xDrawSphereWires     = define_c_proc(ray,"+DrawSphereWires",{VECTOR3,C_FLOAT,C_INT,C_INT,COLOR}),
    xDrawCylinder        = define_c_proc(ray,"+DrawCylinder",{VECTOR3,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,COLOR}),
    xDrawCylinderEx      = define_c_proc(ray,"+DrawCylinderEx",{VECTOR3,VECTOR3,C_FLOAT,C_FLOAT,C_INT,COLOR}),
    xDrawCylinderWires   = define_c_proc(ray,"+DrawCylinderWires",{VECTOR3,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,COLOR}),
    xDrawCylinderWiresEx = define_c_proc(ray,"+DrawCylinderWiresEx",{VECTOR3,VECTOR3,C_FLOAT,C_FLOAT,C_INT,COLOR}),
    xDrawCapsule         = define_c_proc(ray,"+DrawCapsule",{VECTOR3,VECTOR3,C_FLOAT,C_INT,C_INT,COLOR}),
    xDrawCapsuleWires    = define_c_proc(ray,"+DrawCapsuleWires",{VECTOR3,VECTOR3,C_FLOAT,C_INT,C_INT,COLOR}),
    xDrawPlane           = define_c_proc(ray,"+DrawPlane",{VECTOR3,VECTOR2,COLOR}),
    xDrawRay             = define_c_proc(ray,"+DrawRay",{RAY,COLOR}),
    xDrawGrid            = define_c_proc(ray,"+DrawGrid",{C_INT,C_FLOAT})
    
public procedure DrawLine3D(sequence startPos, sequence endPos, sequence color)
    c_proc(xDrawLine3D, {startPos, endPos, color})
end procedure

public procedure DrawPoint3D(sequence position, sequence color)
    c_proc(xDrawPoint3D, {position, color})
end procedure

public procedure DrawCircle3D(sequence center, atom radius, sequence rotationAxis, atom rotationAngle, sequence color)
    c_proc(xDrawCircle3D, {center, radius, rotationAxis, rotationAngle, color})
end procedure

public procedure DrawTriangle3D(sequence v1, sequence v2, sequence v3, sequence color)
    c_proc(xDrawTriangle3D, {v1, v2, v3, color})
end procedure

public procedure DrawCube(sequence position, atom width, atom height, atom length, sequence color)
    c_proc(xDrawCube, {position, width, height, length, color})
end procedure

public procedure DrawCubeV(sequence position, sequence size, sequence color)
    c_proc(xDrawCubeV, {position, size, color})
end procedure

public procedure DrawSphere(sequence centerPos, atom radius, sequence color)
    c_proc(xDrawSphere, {centerPos, radius, color})
end procedure

public procedure DrawSphereEx(sequence centerPos, atom radius, integer rings, integer slices, sequence color)
    c_proc(xDrawSphereEx, {centerPos, radius, rings, slices, color})
end procedure

public procedure DrawCylinder(sequence pos, atom radTop, atom radBot, atom height, integer slices, sequence color)
    c_proc(xDrawCylinder, {pos, radTop, radBot, height, slices, color})
end procedure

public procedure DrawCapsule(sequence startPos, sequence endPos, atom radius, integer slices, integer rings, sequence color)
    c_proc(xDrawCapsule, {startPos, endPos, radius, slices, rings, color})
end procedure

public procedure DrawPlane(sequence centerPos, sequence size, sequence color)
    c_proc(xDrawPlane, {centerPos, size, color})
end procedure

public procedure DrawGrid(integer slices, atom spacing)
    c_proc(xDrawGrid, {slices, spacing})
end procedure

--Model management
public constant 
    xLoadModel           = define_c_func(ray,"+LoadModel",{C_STRING},MODEL),
    xLoadModelFromMesh   = define_c_func(ray,"+LoadModelFromMesh",{MESH},MODEL),
    xIsModelValid        = define_c_func(ray,"+IsModelValid",{MODEL},C_BOOL),
    xUnloadModel         = define_c_proc(ray,"+UnloadModel",{MODEL}),
    xGetModelBoundingBox = define_c_func(ray,"+GetModelBoundingBox",{MODEL},BOUNDINGBOX)
    
-- Load model from files (meshes and materials)
public function LoadModel(sequence fileName)
    return c_func(xLoadModel, {fileName})
end function

-- Load model from generated mesh (default material)
public function LoadModelFromMesh(sequence mesh)
    return c_func(xLoadModelFromMesh, {mesh})
end function

-- Check if a model is valid (loaded in GPU, VAO/VBOs)
public function IsModelValid(sequence model)
    return c_func(xIsModelValid, {model})
end function

-- Unload model from memory (RAM and/or VRAM)
public procedure UnloadModel(sequence model)
    c_proc(xUnloadModel, {model})
end procedure

-- Compute model bounding box limits
public function GetModelBoundingBox(sequence model)
    return c_func(xGetModelBoundingBox, {model})
end function

--model drawing
public constant 
    xDrawModel         = define_c_proc(ray,"+DrawModel",{MODEL,VECTOR3,C_FLOAT,COLOR}),
    xDrawModelEx       = define_c_proc(ray,"+DrawModelEx",{MODEL,VECTOR3,VECTOR3,C_FLOAT,VECTOR3,COLOR}),
    xDrawModelWires    = define_c_proc(ray,"+DrawModelWires",{MODEL,VECTOR3,C_FLOAT,COLOR}),
    xDrawModelWiresEx  = define_c_proc(ray,"+DrawModelWiresEx",{MODEL,VECTOR3,VECTOR3,C_FLOAT,VECTOR3,COLOR}),
    xDrawBoundingBox   = define_c_proc(ray,"+DrawBoundingBox",{BOUNDINGBOX,COLOR}),
    xDrawBillboard     = define_c_proc(ray,"+DrawBillboard",{CAMERA3D,TEXTURE2D,VECTOR3,C_FLOAT,COLOR}),
    xDrawBillboardRec  = define_c_proc(ray,"+DrawBillboardRec",{CAMERA3D,TEXTURE2D,RECTANGLE,VECTOR3,VECTOR2,COLOR}),
    xDrawBillboardPro  = define_c_proc(ray,"+DrawBillboardPro",{CAMERA3D,TEXTURE2D,RECTANGLE,VECTOR3,VECTOR3,VECTOR2,VECTOR2,C_FLOAT,COLOR})
    
public procedure DrawModel(sequence model, sequence position, atom scale, sequence tint)
    c_proc(xDrawModel, {model, position, scale, tint})
end procedure

public procedure DrawModelEx(sequence model, sequence pos, sequence rotAxis, atom rotAngle, sequence scale, sequence tint)
    c_proc(xDrawModelEx, {model, pos, rotAxis, rotAngle, scale, tint})
end procedure

public procedure DrawModelWires(sequence model, sequence position, atom scale, sequence tint)
    c_proc(xDrawModelWires, {model, position, scale, tint})
end procedure

public procedure DrawModelWiresEx(sequence model, sequence pos, sequence rotAxis, atom rotAngle, sequence scale, sequence tint)
    c_proc(xDrawModelWiresEx, {model, pos, rotAxis, rotAngle, scale, tint})
end procedure

public procedure DrawBoundingBox(sequence box, sequence color)
    c_proc(xDrawBoundingBox, {box, color})
end procedure

-- Draw a billboard texture
public procedure DrawBillboard(sequence camera, sequence texture, sequence pos, atom scale, sequence tint)
    c_proc(xDrawBillboard, {camera, texture, pos, scale, tint})
end procedure

-- Draw a billboard texture defined by a source rectangle
public procedure DrawBillboardRec(sequence camera, sequence texture, sequence source, sequence pos, sequence size, sequence tint)
    c_proc(xDrawBillboardRec, {camera, texture, source, pos, size, tint})
end procedure

-- Draw billboard with full control (up vector, origin, rotation)
public procedure DrawBillboardPro(sequence camera, sequence texture, sequence source, sequence pos, sequence up, sequence size, sequence origin, atom rotation, sequence tint)
    c_proc(xDrawBillboardPro, {camera, texture, source, pos, up, size, origin, rotation, tint})
end procedure

--Mesh management
public constant 
    xUploadMesh          = define_c_proc(ray,"+UploadMesh",{C_POINTER,C_BOOL}),
    xUpdateMeshBuffer    = define_c_proc(ray,"+UpdateMeshBuffer",{MESH,C_INT,C_POINTER,C_INT,C_INT}),
    xUnloadMesh          = define_c_proc(ray,"+UnloadMesh",{MESH}),
    xDrawMesh            = define_c_proc(ray,"+DrawMesh",{MESH,MATERIAL,MATRIX}),
    xDrawMeshInstanced   = define_c_proc(ray,"+DrawMeshInstanced",{MESH,MATERIAL,C_POINTER,C_INT}),
    xGetMeshBoundingBox  = define_c_func(ray,"+GetMeshBoundingBox",{MESH},BOUNDINGBOX),
    xGenMeshTangents     = define_c_proc(ray,"+GenMeshTangents",{C_POINTER}),
    xExportMesh          = define_c_func(ray,"+ExportMesh",{MESH,C_STRING},C_BOOL),
    xExportMeshAsCode    = define_c_func(ray,"+ExportMeshAsCode",{MESH,C_STRING},C_BOOL)
    
-- Upload mesh vertex data in GPU (modifies the mesh struct with VAO/VBO IDs)
public procedure UploadMesh(atom pMesh, integer dynamic)
    c_proc(xUploadMesh, {pMesh, dynamic})
end procedure

-- Update mesh vertex data in GPU for a specific buffer index
public procedure UpdateMeshBuffer(sequence mesh, integer index, atom pData, integer dataSize, integer offset)
    c_proc(xUpdateMeshBuffer, {mesh, index, pData, dataSize, offset})
end procedure

-- Unload mesh data from CPU and GPU
public procedure UnloadMesh(sequence mesh)
    c_proc(xUnloadMesh, {mesh})
end procedure

-- Draw a 3d mesh with material and transform
public procedure DrawMesh(sequence mesh, sequence material, sequence transform)
    c_proc(xDrawMesh, {mesh, material, transform})
end procedure

-- Draw multiple mesh instances
public procedure DrawMeshInstanced(sequence mesh, sequence material, atom pTransforms, integer instances)
    c_proc(xDrawMeshInstanced, {mesh, material, pTransforms, instances})
end procedure

-- Compute mesh bounding box limits
public function GetMeshBoundingBox(sequence mesh)
    return c_func(xGetMeshBoundingBox, {mesh})
end function

-- Compute mesh tangents (requires a pointer to the mesh)
public procedure GenMeshTangents(atom pMesh)
    c_proc(xGenMeshTangents, {pMesh})
end procedure

-- Export mesh data to file (.obj, etc)
public function ExportMesh(sequence mesh, sequence fileName)
    return c_func(xExportMesh, {mesh, fileName})
end function

-- Export mesh data as header code (.h)
public function ExportMeshAsCode(sequence mesh, sequence fileName)
    return c_func(xExportMeshAsCode, {mesh, fileName})
end function

--Mesh generation
public constant 
    xGenMeshPoly      = define_c_func(ray,"+GenMeshPoly",{C_INT,C_FLOAT},MESH),
    xGenMeshPlane     = define_c_func(ray,"+GenMeshPlane",{C_FLOAT,C_FLOAT,C_INT,C_INT},MESH),
    xGenMeshCube      = define_c_func(ray,"+GenMeshCube",{C_FLOAT,C_FLOAT,C_FLOAT},MESH),
    xGenMeshSphere    = define_c_func(ray,"+GenMeshSphere",{C_FLOAT,C_INT,C_INT},MESH),
    xGenMeshHemiSphere= define_c_func(ray,"+GenMeshHemiSphere",{C_FLOAT,C_INT,C_INT},MESH),
    xGenMeshCylinder  = define_c_func(ray,"+GenMeshCylinder",{C_FLOAT,C_FLOAT,C_INT},MESH),
    xGenMeshCone      = define_c_func(ray,"+GenMeshCone",{C_FLOAT,C_FLOAT,C_INT},MESH),
    xGenMeshTorus     = define_c_func(ray,"+GenMeshTorus",{C_FLOAT,C_FLOAT,C_INT,C_INT},MESH),
    xGenMeshKnot      = define_c_func(ray,"+GenMeshKnot",{C_FLOAT,C_FLOAT,C_INT,C_INT},MESH),
    xGenMeshHeightmap = define_c_func(ray,"+GenMeshHeightmap",{IMAGE,VECTOR3},MESH),
    xGenMeshCubicmap  = define_c_func(ray,"+GenMeshCubicmap",{IMAGE,VECTOR3},MESH)
    
public function GenMeshPoly(integer sides, atom radius)
    return c_func(xGenMeshPoly, {sides, radius})
end function

public function GenMeshPlane(atom width, atom length, integer resX, integer resZ)
    return c_func(xGenMeshPlane, {width, length, resX, resZ})
end function

public function GenMeshCube(atom width, atom height, atom length)
    return c_func(xGenMeshCube, {width, height, length})
end function

public function GenMeshSphere(atom radius, integer rings, integer slices)
    return c_func(xGenMeshSphere, {radius, rings, slices})
end function

public function GenMeshHemiSphere(atom radius, integer rings, integer slices)
    return c_func(xGenMeshHemiSphere, {radius, rings, slices})
end function

public function GenMeshCylinder(atom radius, atom height, integer slices)
    return c_func(xGenMeshCylinder, {radius, height, slices})
end function

public function GenMeshCone(atom radius, atom height, integer slices)
    return c_func(xGenMeshCone, {radius, height, slices})
end function

public function GenMeshTorus(atom radius, atom size, integer radSeg, integer sides)
    return c_func(xGenMeshTorus, {radius, size, radSeg, sides})
end function

public function GenMeshKnot(atom radius, atom size, integer radSeg, integer sides)
    return c_func(xGenMeshKnot, {radius, size, radSeg, sides})
end function

public function GenMeshHeightmap(sequence heightmap, sequence size)
    return c_func(xGenMeshHeightmap, {heightmap, size})
end function

public function GenMeshCubicmap(sequence cubicmap, sequence cubeSize)
    return c_func(xGenMeshCubicmap, {cubicmap, cubeSize})
end function

--Material loading
public constant 
    xLoadMaterials       = define_c_func(ray,"+LoadMaterials",{C_STRING,C_POINTER},C_POINTER),
    xLoadMaterialDefault = define_c_func(ray,"+LoadMaterialDefault",{},MATERIAL),
    xIsMaterialValid     = define_c_func(ray,"+IsMaterialValid",{MATERIAL},C_BOOL),
    xUnloadMaterial      = define_c_proc(ray,"+UnloadMaterial",{MATERIAL}),
    xSetMaterialTexture  = define_c_proc(ray,"+SetMaterialTexture",{C_POINTER,C_INT,TEXTURE2D}),
    xSetModelMeshMaterial = define_c_proc(ray,"+SetModelMeshMaterial",{C_POINTER,C_INT,C_INT})
    
-- Load materials from model file
public function LoadMaterials(sequence fileName, atom pMaterialCount)
    return c_func(xLoadMaterials, {fileName, pMaterialCount})
end function

-- Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
public function LoadMaterialDefault()
    return c_func(xLoadMaterialDefault, {})
end function

-- Check if a material is valid
public function IsMaterialValid(sequence material)
    return c_func(xIsMaterialValid, {material})
end function

-- Unload material from VRAM
public procedure UnloadMaterial(sequence material)
    c_proc(xUnloadMaterial, {material})
end procedure

-- Set texture for a material map type (Diffuse, Normal, etc.)
public procedure SetMaterialTexture(atom pMaterial, integer mapType, sequence texture)
    c_proc(xSetMaterialTexture, {pMaterial, mapType, texture})
end procedure

-- Set material for a specific mesh within a model
public procedure SetModelMeshMaterial(atom pModel, integer meshId, integer materialId)
    c_proc(xSetModelMeshMaterial, {pModel, meshId, materialId})
end procedure

--Model animation
public constant 
    xLoadModelAnimations   = define_c_func(ray,"+LoadModelAnimations",{C_STRING,C_POINTER},C_POINTER),
    xUpdateModelAnimation  = define_c_proc(ray,"+UpdateModelAnimation",{MODEL,MODELANIMATION,C_FLOAT}),
    xUpdateModelAnimationEx= define_c_proc(ray,"+UpdateModelAnimationEx",{MODEL,MODELANIMATION,C_FLOAT,MODELANIMATION,C_FLOAT,C_FLOAT}),
    xUnloadModelAnimations = define_c_proc(ray,"+UnloadModelAnimations",{C_POINTER,C_INT}),
    xIsModelAnimationValid = define_c_func(ray,"+IsModelAnimationValid",{MODEL,MODELANIMATION},C_BOOL)
    
-- Load model animations from file
public function LoadModelAnimations(sequence fileName, atom pAnimCount)
    return c_func(xLoadModelAnimations, {fileName, pAnimCount})
end function

-- Check if a model animation is valid
public function IsModelAnimationValid(sequence model, sequence anim)
    return c_func(xIsModelAnimationValid, {model, anim})
end function

-- Update model animation pose
public procedure UpdateModelAnimation(sequence model, sequence anim, atom frame)
    c_proc(xUpdateModelAnimation, {model, anim, frame})
end procedure

-- Update model animation pose, blending two animations (e.g., blending Walk into Run)
public procedure UpdateModelAnimationEx(sequence model, sequence animA, atom frameA, sequence animB, atom frameB, atom blend)
    c_proc(xUpdateModelAnimationEx, {model, animA, frameA, animB, frameB, blend})
end procedure

-- Unload animation array data
public procedure UnloadModelAnimations(atom pAnimations, integer animCount)
    c_proc(xUnloadModelAnimations, {pAnimations, animCount})
end procedure

--Collision Detection
public constant 
    xCheckCollisionSpheres   = define_c_func(ray,"+CheckCollisionSpheres",{VECTOR3,C_FLOAT,VECTOR3,C_FLOAT},C_BOOL),
    xCheckCollisionBoxes     = define_c_func(ray,"+CheckCollisionBoxes",{BOUNDINGBOX,BOUNDINGBOX},C_BOOL),
    xCheckCollisionBoxSphere = define_c_func(ray,"+CheckCollisionBoxSphere",{BOUNDINGBOX,VECTOR3,C_FLOAT},C_BOOL),
    xGetRayCollisionSphere   = define_c_func(ray,"+GetRayCollisionSphere",{RAY,VECTOR3,C_FLOAT},RAYCOLLISION),
    xGetRayCollisionBox      = define_c_func(ray,"+GetRayCollisionBox",{RAY,BOUNDINGBOX},RAYCOLLISION),
    xGetRayCollisionMesh     = define_c_func(ray,"+GetRayCollisionMesh",{RAY,MESH,MATRIX},RAYCOLLISION),
    xGetRayCollisionTriangle = define_c_func(ray,"+GetRayCollisionTriangle",{RAY,VECTOR3,VECTOR3,VECTOR3},RAYCOLLISION),
    xGetRayCollisionQuad     = define_c_func(ray,"+GetRayCollisionQuad",{RAY,VECTOR3,VECTOR3,VECTOR3,VECTOR3},RAYCOLLISION)
    
public function CheckCollisionSpheres(sequence center1, atom radius1, sequence center2, atom radius2)
    return c_func(xCheckCollisionSpheres, {center1, radius1, center2, radius2})
end function

public function CheckCollisionBoxes(sequence box1, sequence box2)
    return c_func(xCheckCollisionBoxes, {box1, box2})
end function

public function CheckCollisionBoxSphere(sequence box, sequence center, atom radius)
    return c_func(xCheckCollisionBoxSphere, {box, center, radius})
end function

public function GetRayCollisionSphere(sequence ray_obj, sequence center, atom radius)
    return c_func(xGetRayCollisionSphere, {ray_obj, center, radius})
end function

public function GetRayCollisionBox(sequence ray_obj, sequence box)
    return c_func(xGetRayCollisionBox, {ray_obj, box})
end function

-- Note: This checks collision against every triangle in the mesh (expensive!)
public function GetRayCollisionMesh(sequence ray_obj, sequence mesh, sequence transform)
    return c_func(xGetRayCollisionMesh, {ray_obj, mesh, transform})
end function

public function GetRayCollisionTriangle(sequence ray_obj, sequence p1, sequence p2, sequence p3)
    return c_func(xGetRayCollisionTriangle, {ray_obj, p1, p2, p3})
end function

public function GetRayCollisionQuad(sequence ray_obj, sequence p1, sequence p2, sequence p3, sequence p4)
    return c_func(xGetRayCollisionQuad, {ray_obj, p1, p2, p3, p4})
end function

--Audio loading & playing

--Callback needs work prevents raylib from loading properly

--public function MyAudioCallback(atom pBufferData, atom frames)
    -- This is where you would calculate your sound wave (Sine, Square, etc.)
    -- and use 'poke' or 'mem_copy' to fill pBufferData.
    
    -- In Phix/Euphoria, callbacks must return a value (usually 0 for void)
  --  return 0
--end function

--public atom xAudioCallback = call_back({'+', 'v', {C_POINTER, C_UINT}}, routine_id("MyAudioCallback"))

--Audio device
public constant 
    xInitAudioDevice   = define_c_proc(ray, "+InitAudioDevice", {}),
    xCloseAudioDevice  = define_c_proc(ray, "+CloseAudioDevice", {}),
    xIsAudioDeviceReady = define_c_func(ray, "+IsAudioDeviceReady", {}, C_BOOL),
    xSetMasterVolume   = define_c_proc(ray, "+SetMasterVolume", {C_FLOAT}),
    xGetMasterVolume   = define_c_func(ray, "+GetMasterVolume", {}, C_FLOAT)
    
-- Initialize audio device and context
public procedure InitAudioDevice()
    c_proc(xInitAudioDevice, {})
end procedure

-- Close the audio device and context
public procedure CloseAudioDevice()
    c_proc(xCloseAudioDevice, {})
end procedure

-- Check if audio device has been initialized successfully
public function IsAudioDeviceReady()
    return c_func(xIsAudioDeviceReady, {})
end function

-- Set master volume (global listener volume)
public procedure SetMasterVolume(atom volume)
    c_proc(xSetMasterVolume, {volume})
end procedure

-- Get current master volume
public function GetMasterVolume()
    return c_func(xGetMasterVolume, {})
end function

--Wave/sound loading
public constant 
    xLoadWave           = define_c_func(ray,"+LoadWave",{C_STRING},WAVE),
    xLoadWaveFromMemory = define_c_func(ray,"+LoadWaveFromMemory",{C_STRING,C_POINTER,C_INT},WAVE),
    xIsWaveValid        = define_c_func(ray,"+IsWaveValid",{WAVE},C_BOOL),
    xLoadSound          = define_c_func(ray,"+LoadSound",{C_STRING},SOUND),
    xLoadSoundFromWave  = define_c_func(ray,"+LoadSoundFromWave",{WAVE},SOUND),
    xLoadSoundAlias     = define_c_func(ray,"+LoadSoundAlias",{SOUND},SOUND),
    xIsSoundValid       = define_c_func(ray,"+IsSoundValid",{SOUND},C_BOOL),
    xUpdateSound        = define_c_proc(ray,"+UpdateSound",{SOUND,C_POINTER,C_INT}),
    xUnloadWave         = define_c_proc(ray,"+UnloadWave",{WAVE}),
    xUnloadSound        = define_c_proc(ray,"+UnloadSound",{SOUND}),
    xUnloadSoundAlias   = define_c_proc(ray,"+UnloadSoundAlias",{SOUND}),
    xExportWave         = define_c_func(ray,"+ExportWave",{WAVE,C_STRING},C_BOOL),
    xExportWaveAsCode   = define_c_func(ray,"+ExportWaveAsCode",{WAVE,C_STRING},C_BOOL)
    
public function LoadWave(sequence fileName)
    return c_func(xLoadWave, {fileName})
end function

public function LoadWaveFromMemory(sequence fileType, atom pFileData, integer dataSize)
    return c_func(xLoadWaveFromMemory, {fileType, pFileData, dataSize})
end function

public function IsWaveValid(sequence wave)
    return c_func(xIsWaveValid, {wave})
end function

public procedure UnloadWave(sequence wave)
    c_proc(xUnloadWave, {wave})
end procedure

public function ExportWave(sequence wave, sequence fileName)
    return c_func(xExportWave, {wave, fileName})
end function

public function LoadSound(sequence fileName)
    return c_func(xLoadSound, {fileName})
end function

public function LoadSoundFromWave(sequence wave)
    return c_func(xLoadSoundFromWave, {wave})
end function

public function LoadSoundAlias(sequence source)
    return c_func(xLoadSoundAlias, {source})
end function

public function IsSoundValid(sequence sound)
    return c_func(xIsSoundValid, {sound})
end function

public procedure UpdateSound(sequence sound, atom pData, integer sampleCount)
    c_proc(xUpdateSound, {sound, pData, sampleCount})
end procedure

public procedure UnloadSound(sequence sound)
    c_proc(xUnloadSound, {sound})
end procedure

public procedure UnloadSoundAlias(sequence alias)
    c_proc(xUnloadSoundAlias, {alias})
end procedure

--Wave/sound management
public constant 
    xPlaySound         = define_c_proc(ray, "+PlaySound", {SOUND}),
    xStopSound          = define_c_proc(ray, "+StopSound", {SOUND}),
    xPauseSound         = define_c_proc(ray, "+PauseSound", {SOUND}),
    xResumeSound        = define_c_proc(ray, "+ResumeSound", {SOUND}),
    xIsSoundPlaying     = define_c_func(ray, "+IsSoundPlaying", {SOUND}, C_BOOL),
    xSetSoundVolume     = define_c_proc(ray, "+SetSoundVolume", {SOUND, C_FLOAT}),
    xSetSoundPitch      = define_c_proc(ray, "+SetSoundPitch", {SOUND, C_FLOAT}),
    xSetSoundPan        = define_c_proc(ray, "+SetSoundPan", {SOUND, C_FLOAT}),
    xWaveCopy           = define_c_func(ray, "+WaveCopy", {WAVE}, WAVE),
    xWaveCrop           = define_c_proc(ray, "+WaveCrop", {C_POINTER, C_INT, C_INT}),
    xWaveFormat         = define_c_proc(ray, "+WaveFormat", {C_POINTER, C_INT, C_INT, C_INT}),
    xLoadWaveSamples    = define_c_func(ray, "+LoadWaveSamples", {WAVE}, C_POINTER),
    xUnloadWaveSamples  = define_c_proc(ray, "+UnloadWaveSamples", {C_POINTER})
    
public procedure PlaySound(sequence sound)
    c_proc(xPlaySound, {sound})
end procedure

public procedure StopSound(sequence sound)
    c_proc(xStopSound, {sound})
end procedure

public procedure PauseSound(sequence sound)
    c_proc(xPauseSound, {sound})
end procedure

public procedure ResumeSound(sequence sound)
    c_proc(xResumeSound, {sound})
end procedure

public function IsSoundPlaying(sequence sound)
    return c_func(xIsSoundPlaying, {sound})
end function

public procedure SetSoundVolume(sequence sound, atom volume)
    c_proc(xSetSoundVolume, {sound, volume})
end procedure

public procedure SetSoundPitch(sequence sound, atom pitch)
    c_proc(xSetSoundPitch, {sound, pitch})
end procedure

public procedure SetSoundPan(sequence sound, atom pan)
    c_proc(xSetSoundPan, {sound, pan})
end procedure

public function WaveCopy(sequence wave)
    return c_func(xWaveCopy, {wave})
end function

-- Note: Pass the address (atom) of the Wave struct
public procedure WaveCrop(atom pWave, integer initFrame, integer finalFrame)
    c_proc(xWaveCrop, {pWave, initFrame, finalFrame})
end procedure

-- Note: Pass the address (atom) of the Wave struct
public procedure WaveFormat(atom pWave, integer sampleRate, integer sampleSize, integer channels)
    c_proc(xWaveFormat, {pWave, sampleRate, sampleSize, channels})
end procedure

public function LoadWaveSamples(sequence wave)
    return c_func(xLoadWaveSamples, {wave})
end function

public procedure UnloadWaveSamples(atom pSamples)
    c_proc(xUnloadWaveSamples, {pSamples})
end procedure

--Music management
public constant 
    xLoadMusicStream           = define_c_func(ray, "+LoadMusicStream", {C_STRING}, MUSIC),
    xLoadMusicStreamFromMemory = define_c_func(ray, "+LoadMusicStreamFromMemory", {C_STRING, C_POINTER, C_INT}, MUSIC),
    xIsMusicValid              = define_c_func(ray, "+IsMusicValid", {MUSIC}, C_BOOL),
    xUnloadMusicStream         = define_c_proc(ray, "+UnloadMusicStream", {MUSIC}),
    xPlayMusicStream           = define_c_proc(ray, "+PlayMusicStream", {MUSIC}),
    xIsMusicStreamPlaying      = define_c_func(ray, "+IsMusicStreamPlaying", {MUSIC}, C_BOOL),
    xUpdateMusicStream         = define_c_proc(ray, "+UpdateMusicStream", {MUSIC}),
    xStopMusicStream           = define_c_proc(ray, "+StopMusicStream", {MUSIC}),
    xPauseMusicStream          = define_c_proc(ray, "+PauseMusicStream", {MUSIC}),
    xResumeMusicStream         = define_c_proc(ray, "+ResumeMusicStream", {MUSIC}),
    xSeekMusicStream           = define_c_proc(ray, "+SeekMusicStream", {MUSIC, C_FLOAT}),
    xSetMusicVolume            = define_c_proc(ray, "+SetMusicVolume", {MUSIC, C_FLOAT}),
    xSetMusicPitch             = define_c_proc(ray, "+SetMusicPitch", {MUSIC, C_FLOAT}),
    xSetMusicPan               = define_c_proc(ray, "+SetMusicPan", {MUSIC, C_FLOAT}),
    xGetMusicTimeLength        = define_c_func(ray, "+GetMusicTimeLength", {MUSIC}, C_FLOAT),
    xGetMusicTimePlayed        = define_c_func(ray, "+GetMusicTimePlayed", {MUSIC}, C_FLOAT)
    
public function LoadMusicStream(sequence fileName)
    return c_func(xLoadMusicStream, {fileName})
end function

public function LoadMusicStreamFromMemory(sequence fileType, atom pData, integer dataSize)
    return c_func(xLoadMusicStreamFromMemory, {fileType, pData, dataSize})
end function

public function IsMusicValid(sequence music)
    return c_func(xIsMusicValid, {music})
end function

public procedure UnloadMusicStream(sequence music)
    c_proc(xUnloadMusicStream, {music})
end procedure

public procedure PlayMusicStream(sequence music)
    c_proc(xPlayMusicStream, {music})
end procedure

public procedure UpdateMusicStream(sequence music)
    c_proc(xUpdateMusicStream, {music})
end procedure

public procedure StopMusicStream(sequence music)
    c_proc(xStopMusicStream, {music})
end procedure

public procedure PauseMusicStream(sequence music)
    c_proc(xPauseMusicStream, {music})
end procedure

public procedure ResumeMusicStream(sequence music)
    c_proc(xResumeMusicStream, {music})
end procedure

public function IsMusicStreamPlaying(sequence music)
    return c_func(xIsMusicStreamPlaying, {music})
end function

public procedure SeekMusicStream(sequence music, atom position)
    c_proc(xSeekMusicStream, {music, position})
end procedure

public procedure SetMusicVolume(sequence music, atom volume)
    c_proc(xSetMusicVolume, {music, volume})
end procedure

public procedure SetMusicPitch(sequence music, atom pitch)
    c_proc(xSetMusicPitch, {music, pitch})
end procedure

public procedure SetMusicPan(sequence music, atom pan)
    c_proc(xSetMusicPan, {music, pan})
end procedure

public function GetMusicTimeLength(sequence music)
    return c_func(xGetMusicTimeLength, {music})
end function

public function GetMusicTimePlayed(sequence music)
    return c_func(xGetMusicTimePlayed, {music})
end function

--Audiostream management
public constant 
    xLoadAudioStream           = define_c_func(ray, "+LoadAudioStream", {C_UINT, C_UINT, C_UINT}, AUDIOSTREAM),
    xIsAudioStreamValid        = define_c_func(ray, "+IsAudioStreamValid", {AUDIOSTREAM}, C_BOOL),
    xUnloadAudioStream         = define_c_proc(ray, "+UnloadAudioStream", {AUDIOSTREAM}),
    xUpdateAudioStream         = define_c_proc(ray, "+UpdateAudioStream", {AUDIOSTREAM, C_POINTER, C_INT}),
    xIsAudioStreamProcessed    = define_c_func(ray, "+IsAudioStreamProcessed", {AUDIOSTREAM}, C_BOOL),
    xPlayAudioStream           = define_c_proc(ray, "+PlayAudioStream", {AUDIOSTREAM}),
    xPauseAudioStream          = define_c_proc(ray, "+PauseAudioStream", {AUDIOSTREAM}),
    xResumeAudioStream         = define_c_proc(ray, "+ResumeAudioStream", {AUDIOSTREAM}),
    xIsAudioStreamPlaying      = define_c_func(ray, "+IsAudioStreamPlaying", {AUDIOSTREAM}, C_BOOL),
    xStopAudioStream           = define_c_proc(ray, "+StopAudioStream", {AUDIOSTREAM}),
    xSetAudioStreamVolume      = define_c_proc(ray, "+SetAudioStreamVolume", {AUDIOSTREAM, C_FLOAT}),
    xSetAudioStreamPitch       = define_c_proc(ray, "+SetAudioStreamPitch", {AUDIOSTREAM, C_FLOAT}),
    xSetAudioStreamPan         = define_c_proc(ray, "+SetAudioStreamPan", {AUDIOSTREAM, C_FLOAT}),
    xSetAudioStreamBufferSizeDefault = define_c_proc(ray, "+SetAudioStreamBufferSizeDefault", {C_INT}),
    xSetAudioStreamCallback    = define_c_proc(ray, "+SetAudioStreamCallback", {AUDIOSTREAM, C_POINTER}),
    xAttachAudioStreamProcessor = define_c_proc(ray, "+AttachAudioStreamProcessor", {AUDIOSTREAM, C_POINTER}),
    xDetachAudioStreamProcessor = define_c_proc(ray, "+DetachAudioStreamProcessor", {AUDIOSTREAM, C_POINTER}),
    xAttachAudioMixedProcessor  = define_c_proc(ray, "+AttachAudioMixedProcessor", {C_POINTER}),
    xDetachAudioMixedProcessor  = define_c_proc(ray, "+DetachAudioMixedProcessor", {C_POINTER})
    
public function LoadAudioStream(integer sampleRate, integer sampleSize, integer channels)
    return c_func(xLoadAudioStream, {sampleRate, sampleSize, channels})
end function

public procedure UpdateAudioStream(sequence stream, atom pData, integer frameCount)
    c_proc(xUpdateAudioStream, {stream, pData, frameCount})
end procedure

public function IsAudioStreamProcessed(sequence stream)
    return c_func(xIsAudioStreamProcessed, {stream})
end function

public procedure UnloadAudioStream(sequence stream)
    c_proc(xUnloadAudioStream, {stream})
end procedure

-- Set a callback to fill the buffer automatically on the audio thread
public procedure SetAudioStreamCallback(sequence stream, atom pCallback)
    c_proc(xSetAudioStreamCallback, {stream, pCallback})
end procedure

-- Global processors (Effect filters, Visualizers, etc.)
public procedure AttachAudioMixedProcessor(atom pProcessor)
    c_proc(xAttachAudioMixedProcessor, {pProcessor})
end procedure

public procedure DetachAudioMixedProcessor(atom pProcessor)
    c_proc(xDetachAudioMixedProcessor, {pProcessor})
end procedure

public procedure PlayAudioStream(sequence stream)
    c_proc(xPlayAudioStream, {stream})
end procedure

public procedure SetAudioStreamVolume(sequence stream, atom volume)
    c_proc(xSetAudioStreamVolume, {stream, volume})
end procedure

public procedure SetAudioStreamPan(sequence stream, atom pan)
    c_proc(xSetAudioStreamPan, {stream, pan})
end procedure
­3723.0