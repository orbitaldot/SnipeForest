extends Node2D


var font_text:Font = load("res://Fonts/tf2build.ttf")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _draw():
	var global = get_node('/root/Global')
	draw_string(font_text, Vector2(10.0, 10.0), 'Soldiers killed: ' + global.soldiers_killed)
	pass
