extends Node2D

const arrowScene = preload("res://arrow.tscn");
const vectors_distance = 100; # 1m = 100px

func _ready():
	recreate_vectors();

func _process(_delta):
	update_vectors();

func recreate_vectors():
	var camera = $"../Camera";
	var view_rect = camera.get_view_rect();
	
	var start = ceil(view_rect.position / vectors_distance) * vectors_distance;
	var end = start + view_rect.size;

	var container = $ArrowContainer;
	
	for node in container.get_children():
		container.remove_child(node);
		node.queue_free();
	
	for x in range(start.x, end.x, vectors_distance):
		for y in range(start.y, end.y, vectors_distance):
			var arrow = arrowScene.instantiate();
			arrow.position = Vector2(x, y);
			container.add_child(arrow);
	
	update_vectors();

func update_vectors():
	var arrow_container = get_node("ArrowContainer");
	for arrow in arrow_container.get_children():
		var field = calculate_field(arrow.position);
		arrow.set_vector(field);

func calculate_field(point: Vector2) -> Vector2:
	var entities = $EntitiesContainer;
	
	var field = Vector2.ZERO;
	for e in entities.get_children():
		var diff: Vector2 = e.position - point;
		var distance_squared = diff.length_squared() / (100 * 100); # 1m = 100px
		var field_value = e.charge / distance_squared;
		field += field_value * diff.normalized();
		
	return field;

func _on_camera_view_rect_changed():
	recreate_vectors();
