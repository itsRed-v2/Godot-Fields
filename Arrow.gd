extends Sprite2D

@export
var vector = Vector2.UP;

const base_color = Color.SALMON;
const streched_color = Color.CRIMSON;
const draw_scale = 30;
const line_width = 3;
const arrow_arms_length = 10;
const size_treshold = 200;
const streched_treshold = 300;

func _process(_delta):
	queue_redraw();

func _draw():
	if not Global.draw_electrostatic_field:
		return
	
	# Adjusting the length
	var length = vector.length() * draw_scale;
	if (length > size_treshold):
		length = size_treshold - 1 + sqrt(length - size_treshold + 1);
	
	# If the vector is very small, draw a smaller arrow
	var effective_arrow_arms_length = arrow_arms_length;
	if length * 2 < arrow_arms_length:
		effective_arrow_arms_length = length * 2;
		
	# If the vector is very big, adjust the color
	var color = base_color;
	if length > size_treshold:
		var weight = remap(length, size_treshold, streched_treshold, 0, 1);
		weight = clamp(weight, 0, 1);
		color = color.lerp(streched_color, weight);
		
	# Drawing the Arrow
	
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
