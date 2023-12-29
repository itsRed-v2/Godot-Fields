extends Camera2D

const speed = 800;
const moves = [
	["up", Vector2.UP],
	["down", Vector2.DOWN],
	["left", Vector2.LEFT],
	["right", Vector2.RIGHT],
];

func _process(delta):
	var movement = Vector2.ZERO;
	for move in moves:
		if Input.is_action_pressed(move[0]):
			movement += move[1];
			redraw_everything();
	position += movement * speed * delta;

func get_view_rect():
	var viewPortSize = get_viewport().get_visible_rect().size;
	var width = viewPortSize.x;
	var height = viewPortSize.y;
	var realSize = Vector2(width, height);
	
	return Rect2(position, realSize);

func redraw_everything():
	$"../Background".redraw();
	$"../ElectricField".redraw_vectors();


