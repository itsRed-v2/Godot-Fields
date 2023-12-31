extends Sprite2D

@export
var vector = Vector2.UP:
	set(new_value):
		vector = new_value;
		queue_redraw();

const base_color = Color.SANDY_BROWN;
const line_width = 3;
const arrow_arms_length = 8;
const vector_length = 30;

func _draw():
	var value = vector.length();
	var opacity = remap(value, -0.05, 3, 0, 1);
	var color = Color(base_color, opacity);
	modulate = color;
	
	rotation = vector.angle() + PI / 2;
