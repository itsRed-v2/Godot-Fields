class_name SphericBody extends Node2D

const selected_indicator_inner = 35;
const selected_indicator_outer = 55;
const selected_indicator_width = 3;

@export var charge = 0:
	set(new_value):
		charge = new_value;
		update_info();
		print("new value: ", new_value);
		
@export var mass = 1:
	set(new_value):
		mass = new_value;
		update_info();

var isHovered = false;
var dragging = false;
var hasMoved = false;

var isSelected = false;

func _ready():
	Global.connect("selected_body_changed", _on_selected_body_changed);
	update_info();

func _process(_delta):
	if isHovered && Input.is_action_just_pressed("mouse_left_button"):
		dragging = true;
		hasMoved = false;
	if Input.is_action_just_released("mouse_left_button"):
		if isHovered and not hasMoved:
			Global.body_selected(null if isSelected else self);
		if isHovered and hasMoved:
			Global.body_clicked(self);
		dragging = false;
		hasMoved = false;
	
	if isSelected:
		queue_redraw();

func _on_area_2d_mouse_entered():
	if Global.currently_hovered_body == null:
		Global.currently_hovered_body = self;
		isHovered = true;
		queue_redraw();

func _on_area_2d_mouse_exited():
	if Global.currently_hovered_body == self:
		Global.currently_hovered_body = null;
		isHovered = false;
		queue_redraw();

func _input(event):
	if dragging && event is InputEventMouseMotion:
		global_position = get_global_mouse_position();
		hasMoved = true;

func _draw():
	var color = Color(0.254902, 0.411765, 0.882353);
	if isHovered: color = color.darkened(0.2);
	draw_circle(Vector2.ZERO, 20, color);
	
	if isSelected:
		for vec in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
			var offset = sin(Time.get_ticks_msec() / 500.0) * 5.0;
			var start = vec * (selected_indicator_inner + offset);
			var end = vec * (selected_indicator_outer + offset);
			draw_line(start, end, Color.GRAY, selected_indicator_width);

func update_info():
	var data_label = get_node("Data");
	data_label.text = "";
	if Global.show_charge:
		data_label.text += "Charge: %.1f C\n" % charge;
	if Global.show_mass:
		data_label.text += "Mass: %d kg\n" % mass;

func _on_selected_body_changed():
	isSelected = Global.currently_selected_body == self;
	queue_redraw();
