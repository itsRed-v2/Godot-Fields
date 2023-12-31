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

func body_clicked(body: SphericBody):
	if body != currently_selected_body:
		currently_selected_body = null;
		selected_body_changed.emit();

func body_selected(body: SphericBody):
	currently_selected_body = body;
	selected_body_changed.emit();

