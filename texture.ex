include raylib.e

atom Width = 800
atom Height = 600

InitWindow(Width,Height,"Simple Texture")

sequence tex = LoadTexture("raylib_logo.png")

SetTargetFPS(60)

enum id,
	 width,
	 height,
	 mipmaps,
	 format

while not WindowShouldClose() do
	BeginDrawing()
	DrawTexture(tex,Width / 2 - tex[width], Height / 2 - tex[height] / 2, WHITE)
	EndDrawing()
end while

UnloadTexture(tex)

CloseWindow()
­24.18