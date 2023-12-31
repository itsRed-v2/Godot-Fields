class_name SphericBody extends Node2D

const selected_indicator_inner = 35;
const selected_indicator_outer = 55;
const selected_indicator_width = 3;

@export var charge = 0:
	set(new_value):
		charge = new_value;
		update_info();
		
@export var mass = 1:
	set(new_value):
		mass = new_value;
		update_info();

var dragging = false;

func _ready():
	Global.connect("selected_body_changed", _on_selected_body_changed);
	update_info();

func _process(_delta):
	if selected():
		queue_redraw();

func _on_area_2d_mouse_entered():
	if Global.currently_hovered_body == null:
		Global.currently_hovered_body = self;
		queue_redraw();

func _on_area_2d_mouse_exited():
	if Global.currently_hovered_body == self:
		Global.currently_hovered_body = null;
		queue_redraw();

func _input(event):
	if event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position();
		
	if event is InputEventMouseButton and (hovered() or dragging):
		handle_click(event);

func handle_click(event: InputEventMouseButton):
	if event.button_index != MOUSE_BUTTON_LEFT:
		return;
	
	if event.pressed: # Button press
		dragging = true;
	else: # Button release
		Global.body_selected(self);
		dragging = false;
		
	get_viewport().set_input_as_handled();

func _draw():
	var color = Color(0.254902, 0.411765, 0.882353);
	if hovered():
		color = color.darkened(0.2);
	draw_circle(Vector2.ZERO, 20, color);
	
	if selected():
		for vec in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
			var offset = sin(Time.get_ticks_msec() / 500.0) * 5.0;
			var start = vec * (selected_indicator_inner + offset);
			var end = vec * (selected_indicator_outer + offset);
			draw_line(start, end, Color.GRAY, selected_indicator_width);

func _on_selected_body_changed():
	# Needed to remove the selected indicator when the body is unselected
	queue_redraw();

func hovered():
	return Global.currently_hovered_body == self;

func selected():
	return Global.currently_selected_body == self;

func update_info():
	var data_label = get_node("Data");
	data_label.text = "";
	if Global.show_charge:
		data_label.text += "Charge: %.1f C\n" % charge;
	if Global.show_mass:
		data_label.text += "Mass: %d kg\n" % mass;
