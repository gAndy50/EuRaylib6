include raylib.e

atom width = 800
atom height = 450

InitWindow(width,height,"Render Texture")

atom rtWidth = 300
atom rtHeight = 300

sequence target = LoadRenderTexture(rtWidth,rtHeight)

sequence ballPos = {rtWidth / 2.0, rtHeight / 2.0}
sequence ballSpeed = {5.0, 4.0}

atom ballRad = 20

atom rotation = 0.0

enum ball_x,
	 ball_y
	 
enum speed_x,
	 speed_y
	 
enum rt_id,
	 rt_texture,
	 rt_depth
	 
enum tex_id,
	 tex_width,
	 tex_height,
	 tex_mipmaps,
	 tex_format
	 
SetTargetFPS(60)

while not WindowShouldClose() do

	ballPos[ball_x] += ballSpeed[speed_x]
	ballPos[ball_y] += ballSpeed[speed_y]
	
	if ((ballPos[ball_x] >= (rtWidth - ballRad)) or (ballPos[ball_x] <= ballRad)) then
		ballSpeed[speed_x] *= -1.0
	end if
	
	if ((ballPos[ball_y] >= (rtHeight - ballRad)) or (ballPos[ball_y] <= ballRad)) then
		ballSpeed[speed_y] *= -1.0
	end if
	
	rotation += 0.5
	
	BeginTextureMode(target)
		ClearBackground(SKYBLUE)
		DrawRectangle(0,0,20,20,RED)
		DrawCircleV(ballPos,ballRad,MAROON)
	EndTextureMode()
	
	BeginDrawing()
	ClearBackground(RAYWHITE)
	
		DrawTexturePro(
		target[rt_texture],
		{0.0,0.0,
		target[rt_texture][tex_width],
		-target[rt_texture][tex_height]},
		{width / 2.0,
		height / 2.0,
		target[rt_texture][tex_width],
		target[rt_texture][tex_height]},
		{target[rt_texture][tex_width] / 2.0,
		target[rt_texture][tex_height] / 2.0},
		rotation,
		WHITE)
	EndDrawing()
end while

CloseWindow()
­36.16