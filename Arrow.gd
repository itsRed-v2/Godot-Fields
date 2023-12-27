@tool
extends Sprite2D

var vector = Vector2.UP;

var color = Color.CRIMSON;
var draw_scale = 30;
var line_width = 3;
var arrow_arms_length = 10;

func _process(_delta):
	queue_redraw();

func _draw():
	if not Global.draw_electrostatic_field:
		return

	var length = vector.length() * draw_scale;
	
	var effective_arrow_arms_length = arrow_arms_length;
	if length * 2 < arrow_arms_length:
		effective_arrow_arms_length = length * 2;
	
	var tipPoint = Vector2.UP * length;
	var arrow_end_left = tipPoint + Vector2(-effective_arrow_arms_length, effective_arrow_arms_length);
	var arrow_end_right = tipPoint + Vector2(effective_arrow_arms_length, effective_arrow_arms_length);

	var arrow_end = [
		arrow_end_left,
		tipPoint,
		arrow_end_right
	];

	draw_line(Vector2.ZERO, tipPoint, color, line_width);
	draw_polyline(arrow_end, color, line_width);
	
	draw_circle(Vector2.ZERO, line_width / 2.0, color);
	draw_circle(arrow_end_left, line_width / 2.0, color);
	draw_circle(arrow_end_right, line_width / 2.0, color);
	
	rotation = vector.angle() + PI / 2;

func set_vector(vec: Vector2):
	vector = vec;
