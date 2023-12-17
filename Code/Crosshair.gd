extends Node2D

var sprite:Sprite2D
var rotate_speed:float = 0.005;

func _ready():
	self.sprite = get_node('Sprite2D')
	self.sprite.scale = Vector2(10.0,10.0)
	pass 

func _process(delta):
	self.sprite.scale.x = lerp(self.sprite.scale.x, 0.75, 0.1)
	self.sprite.scale.y = lerp(self.sprite.scale.y, 0.75, 0.1)
	
	self.rotate_speed = lerp(self.rotate_speed, 0.005, 0.1)
	
	self.rotation += self.rotate_speed;
	pass
