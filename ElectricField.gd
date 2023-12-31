extends Node2D

const colorArrowScene = preload("res://color_arrow.tscn");
const vectors_distance = 50; # 1m = 100px

func _ready():
	render();
	
	# Redraw when the drawing settings change
	Global.connect("draw_settings_changed", render);
	# Redraw when the window changes size
	get_tree().root.connect("size_changed", render);

func _process(_delta):
	update_vectors();

func render():
	if Global.draw_electrostatic_field:
		recreate_vectors();
	else:
		clear_vectors();

func recreate_vectors():
	var camera = $"../Camera";
	var view_rect = camera.get_view_rect();
	
	var start = ceil(view_rect.position / vectors_distance) * vectors_distance;
	var end = start + view_rect.size;
	var unit = Vector2(vectors_distance, vectors_distance);
	start -= unit;
	end += unit;
	
	clear_vectors();

	var container = $ArrowContainer;
	for x in range(start.x, end.x, vectors_distance):
		for y in range(start.y, end.y, vectors_distance):
			var arrow = colorArrowScene.instantiate();
			arrow.position = Vector2(x, y);
			container.add_child(arrow);
	
	update_vectors();
	
func clear_vectors():
	var container = $ArrowContainer;
	for node in container.get_children():
		container.remove_child(node);
		node.queue_free();

func update_vectors():
	var arrow_container = get_node("ArrowContainer");
	for arrow in arrow_container.get_children():
		var field = calculate_field(arrow.position);
		arrow.vector = field;

func calculate_field(point: Vector2) -> Vector2:
	var field = Vector2.ZERO;
	for e in $EntitiesContainer.get_children():
		var diff: Vector2 = e.position - point;
		var distance_squared = diff.length_squared() / (100 * 100); # 1m = 100px
		var field_value = e.charge / distance_squared;
		field += field_value * diff.normalized();
		
	return field;

func _on_camera_view_rect_changed():
	render();
