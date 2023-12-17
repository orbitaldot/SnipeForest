extends CharacterBody2D

var facing:String = 'right';
var sprite:AnimatedSprite2D;
var life:float = 0.0;
var targeted:bool = false;
var shoot_area:Area2D

func _ready():
	self.sprite = get_node('AnimatedSprite2D');
	self.shoot_area = get_node('ShootArea')
	pass 

func _process(delta):
	var player:Node2D = get_tree().get_root().get_child(0).player_object
	
	self.facing = 'left' if player.position.x < position.x else 'right'
	self.sprite.play(self.facing)
	
	self.rotation = sin(life * 10) * 0.25
	
	var d = (player.position - position).normalized() * 0.1
	move_and_collide(d)
	
	if targeted && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		get_tree().get_root().get_child(0).player_object.boomHeadshot.play()
		hide()
		queue_free()
	
	z_index = position.y
	self.life += delta;
	pass

