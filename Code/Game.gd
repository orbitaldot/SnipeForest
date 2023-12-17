extends Node2D

var player_object:Node2D

var soldier = preload("res://Scenes/soldier.tscn")
var tree = preload("res://Scenes/tree.tscn")
var music:AudioStreamPlayer

func _ready():
	populate_forest(500, 500)
	self.music = get_node('Music')
	self.music.play()
	get_tree().get_root().size = Vector2i(640, 480)
	pass

func _process(delta):
	pass

func get_player():
	return player_object

func create_soldier(pos:Vector2):
	var rng = RandomNumberGenerator.new()
	print('new soldier...', pos)
	var new_soldier = spawn_around_position(soldier, pos, 60.0, rng.randf_range(0, 2*PI))
	new_soldier.add_to_group('soldiers')
	return new_soldier;
	
func spawn_around_position(object, posi, distance, angle):
	var pos = posi + Vector2(cos(angle)*distance, sin(angle)*distance)
	var new_obj = object.instantiate()
	new_obj.position = pos
	add_child(new_obj)
	return new_obj
	
func populate_forest(spread:float, count:int):
	var rng = RandomNumberGenerator.new()
	for i in count:
		var ang = rng.randf_range(0, 2*PI)
		var l = rng.randf_range(32.0, spread)
		var new_tree = spawn_around_position(tree, Vector2(0.0,0.0), l, ang)
		new_tree.z_index = new_tree.position.y
		
