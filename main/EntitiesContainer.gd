extends Node2D

const spheric_body_scene = preload("res://spheric_body/spheric_body.tscn");

func _create_new_body():
	var view_rect: Rect2 = $"../../Camera".get_view_rect();
	var center = view_rect.position + (view_rect.size / 2);
	
	var body = spheric_body_scene.instantiate();
	body.position = center;
	add_child(body);
	
	Global.body_selected(body);

func _delete_body(body: SphericBody):
	remove_child(body);
	body.queue_free();
