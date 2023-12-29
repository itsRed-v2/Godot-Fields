extends Node2D

@export var charge = 0;
@export var mass = 1;

var speed = 200;
var isHovered = false;
var dragging = false;

func _process(_delta):
	if isHovered && Input.is_action_just_pressed("mouse_left_button"):
		dragging = true;
	if Input.is_action_just_released("mouse_left_button"):
		dragging = false;

func _on_area_2d_mouse_entered():
	isHovered = true;
	queue_redraw();

func _on_area_2d_mouse_exited():
	isHovered = false;
	queue_redraw();

func _input(event):
	if dragging && event is InputEventMouseMotion:
		global_position = get_global_mouse_position();

func _draw():
	var color = Color(0.254902, 0.411765, 0.882353);
	if isHovered: color = color.darkened(0.2);
	draw_circle(Vector2.ZERO, 20, color);

func update_info():
	var data_label = get_node("Data");
	data_label.text = "";
	if Global.show_charge:
		data_label.text += "Charge: " + str(charge) + " C\n";
	if Global.show_mass:
		data_label.text += "Mass: " + str(mass) + " kg\n";
