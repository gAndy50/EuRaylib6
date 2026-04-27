include raylib.e

atom width = 800
atom height = 450

public constant TRUE = 1, FALSE = 0

InitWindow(width,height,"Bouncing Ball")

sequence ballPos = {GetScreenWidth() / 2.0, GetScreenHeight() / 2.0}
sequence ballSpeed = {5.0, 4.0}
atom ballRadius = 20
atom gravity = 0.2

integer useGravity = TRUE
integer paused = 0
atom frameCounter = 0

SetTargetFPS(60)

while not WindowShouldClose() do

	if IsKeyPressed(KEY_G) and useGravity = TRUE then
		useGravity = FALSE
		elsif IsKeyPressed(KEY_G) and useGravity = FALSE then
			useGravity = TRUE
	end if
	
	if IsKeyPressed(KEY_P) and paused = 0 then
		paused = 1
		elsif IsKeyPressed(KEY_P) and paused = 1 then
			paused = 0
	end if
	
	if (paused = 0) then
	
		ballPos[1] += ballSpeed[1]
		ballPos[2] += ballSpeed[2]
		
		if useGravity = TRUE then
			ballSpeed[2] += gravity
		end if
		
		if ballPos[1] >= GetScreenWidth() - ballRadius or ballPos[1] <= ballRadius then
			ballSpeed[1] *= -1.0
		end if
		
		if ballPos[2] >= GetScreenHeight() - ballRadius or ballPos[2] <= ballRadius then
			ballSpeed[2] *= -0.95
		end if
	end if
	frameCounter += 1
	
	BeginDrawing()
	
		ClearBackground(RAYWHITE)
		
		DrawCircleV(ballPos,ballRadius,MAROON)
		
		DrawFPS(1,1)
		DrawText("Press P to Pause",10,20,20,GREEN)
		DrawText("Press G to turn gravity on/off",10,40,20,GREEN)

	EndDrawing()
end while

CloseWindow()
­62.40