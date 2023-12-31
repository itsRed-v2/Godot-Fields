extends Node

signal selected_body_changed;
signal draw_settings_changed;

var draw_electrostatic_field = true:
	set(new_value):
		draw_electrostatic_field = new_value;
		draw_settings_changed.emit();

var show_charge = true;
var show_mass = false;

var currently_selected_body: SphericBody = null;
var currently_hovered_body: SphericBody = null;

func body_selected(body: SphericBody):
	currently_selected_body = body;
	selected_body_changed.emit();

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Unselect when the background is clicked
			Global.body_selected(null);
