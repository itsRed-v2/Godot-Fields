extends Node2D

@export var bg = Color(0.1, 0.1, 0.1);
@export var fg = Color(0.2, 0.2, 0.2);
@export var gap = 100;

func _draw():
	var cameraView: Rect2 = $"../Camera".get_view_rect();
	var startPos = floor(cameraView.position / gap) * gap;
	var endPos = startPos + cameraView.size + Vector2(gap, gap);
	
	for x in range(startPos.x, endPos.x, gap):
		draw_line(Vector2(x, startPos.y), Vector2(x, endPos.y), fg, -1);
	for y in range(startPos.y, endPos.y, gap):
		draw_line(Vector2(startPos.x, y), Vector2(endPos.x, y), fg, -1);

func redraw():
	queue_redraw();
