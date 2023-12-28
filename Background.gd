extends Node2D

@export var bg = Color(0.1, 0.1, 0.1);
@export var fg = Color(0.2, 0.2, 0.2);
@export var gap = 100;

func _draw():
	var viewportSize = get_viewport().size;
	var width = viewportSize.x;
	var height = viewportSize.y;
	
	draw_rect(Rect2(Vector2.ZERO, viewportSize), bg);
	for x in range(0, width, gap):
		draw_line(Vector2(x, 0), Vector2(x, height), fg, -1);
	for y in range(0, height, gap):
		draw_line(Vector2(0, y), Vector2(width, y), fg, -1);
