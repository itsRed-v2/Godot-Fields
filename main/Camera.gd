extends Camera2D

signal view_rect_changed;

var dragging = false;

func get_view_rect():
	var viewPortSize = get_viewport().get_visible_rect().size;
	var width = viewPortSize.x;
	var height = viewPortSize.y;
	var realSize = Vector2(width, height);
	
	return Rect2(position, realSize);

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				dragging = true;
			else:
				dragging = false;

func _input(event):
	if event is InputEventMouseMotion:
		if dragging:
			move(-event.relative);

func move(movement: Vector2):
	position += movement;
	view_rect_changed.emit();
