extends Node2D

var arrowScene = preload("res://arrow.tscn");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	var viewportSize = get_viewport().size;
	var container = get_node("ArrowContainer");
	
	for x in range(0, viewportSize.x, 100):
		for y in range(0, viewportSize.y, 100):
			var arrow = arrowScene.instantiate();
			arrow.position = Vector2(x, y);
			container.add_child(arrow);

func _process(_delta):
	var arrow_container = get_node("ArrowContainer");
	
	for arrow in arrow_container.get_children():
		var field = calculate_field(arrow.position);
		arrow.set_vector(field);

func calculate_field(point: Vector2) -> Vector2:
	var entities = get_node("Entities");
	
	var field = Vector2.ZERO;
	
	for e in entities.get_children():
		var diff: Vector2 = e.position - point;
		var distance_squared = diff.length_squared() / (100 * 100); # 1m = 100px
		var field_value = e.charge / distance_squared;
		field += field_value * diff.normalized();
		
	return field;
		
