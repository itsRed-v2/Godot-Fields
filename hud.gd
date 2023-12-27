extends CanvasLayer

func _ready():
	get_node("ColorRect/ElecticFieldCheckBox").button_pressed = Global.draw_electrostatic_field;
	get_node("ColorRect/ChargesCheckBox").button_pressed = Global.show_charge;
	get_node("ColorRect/MassCheckBox").button_pressed = Global.show_mass;

func _on_electic_field_check_box_toggled(toggled_on):
	Global.draw_electrostatic_field = toggled_on;

func _on_charges_check_box_toggled(toggled_on):
	Global.show_charge = toggled_on;
	get_tree().call_group("sphericBody", "update_info");

func _on_mass_check_box_toggled(toggled_on):
	Global.show_mass = toggled_on;
	get_tree().call_group("sphericBody", "update_info");
