extends VBoxContainer

func _ready():
	disable();
	Global.connect("selected_body_changed", _on_selected_body_changed);

func _on_selected_body_changed():
	var body: SphericBody = Global.currently_selected_body;
	if body == null:
		disable();
	else:
		enable(body);

func enable(body: SphericBody):
	$Inputs/ChargeSection/SpinBox.value = body.charge;
	$Inputs/MassSection/SpinBox.value = body.mass;
	$Inputs.visible = true;
	$NotSelected.visible = false;
	
func disable():
	$Inputs.visible = false;
	$NotSelected.visible = true;

func _on_charge_spin_box_value_changed(value):
	var body: SphericBody = Global.currently_selected_body;
	if body != null:
		body.charge = value;

func _on_mass_spin_box_value_changed(value):
	var body: SphericBody = Global.currently_selected_body;
	if body != null:
		body.mass = value;

func _on_delete_button_pressed():
	var body: SphericBody = Global.currently_selected_body;
	if body != null:
		get_tree().call_group("BodyCreator", "_delete_body", body);
		Global.body_selected(null);
