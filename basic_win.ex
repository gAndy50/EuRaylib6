include raylib.e

atom width = 800
atom height = 600

InitWindow(width,height,"Basic Window")

SetTargetFPS(60)

while not WindowShouldClose() do
	BeginDrawing()
	ClearBackground(BLANK)
	DrawText("Basic Window",190,200,20,LIGHTGRAY)
	EndDrawing()
end while

CloseWindow()
­14.13