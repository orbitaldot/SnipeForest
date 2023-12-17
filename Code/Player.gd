extends CharacterBody2D

var camera:Camera2D
var sprite:AnimatedSprite2D
var position_old:Vector2

var time:float = 0
var moving:bool = false
var facing:String = 'right'
var mouse_x:float = 0.0
var cam_zoom:float = 4.0
var move_speed:float = 0.3
var mouse_down:bool = false
var mouse_pressed:bool = false

var boomHeadshot:AudioStreamPlayer

const cam_default_zoom:Vector2 = Vector2(4.0, 4.0)

func _ready():
	self.camera = self.get_node('Camera2D')
	self.sprite = self.get_node('AnimatedSprite2D')
	self.sprite.play(self.facing)
	get_tree().get_root().size = Vector2i(640, 480)
	
	get_tree().get_root().get_child(0).player_object = self

	self.boomHeadshot = get_node('AudioStreamPlayer')
	
	pass

func _process(delta):
	position_old = (position)
	
	var soldiers = get_tree().get_nodes_in_group('soldiers')
	var nearest_soldier = null
	var nearest_soldier_distance = INF
	
	var mouse_pos:Vector2 = self.camera.get_local_mouse_position()
	
	var crosshair = get_tree().get_root().get_child(0).get_node('Crosshair')
	
	crosshair.position = position + mouse_pos
	crosshair.z_index = self.z_index + 900;
	
	for i in len(soldiers):
		var dist = position.distance_to(soldiers[i].position)
		if dist <= nearest_soldier_distance:
			nearest_soldier = soldiers[i]
			nearest_soldier_distance = dist
		var soldier:CharacterBody2D = soldiers[i]
		var coll:CollisionShape2D = soldier.get_node('CollisionShape2D')
	
	if nearest_soldier_distance < INF:
		var mus:AudioStreamPlayer = get_tree().get_root().get_child(0).music
		mus.volume_db = -nearest_soldier_distance/5.0
	
	var horizontal = (1 if Input.is_key_pressed(KEY_D) else 0 - 1 if Input.is_key_pressed(KEY_A) else 0)
	var vertical = (1 if Input.is_key_pressed(KEY_S) else 0 - 1 if Input.is_key_pressed(KEY_W) else 0)
	
	var velocity = Vector2(horizontal * self.move_speed, 0)
	if !move_and_collide(velocity, true):
		position.x += horizontal * self.move_speed
	velocity = Vector2(0, vertical * self.move_speed)
	if !move_and_collide(velocity, true):
		position.y += vertical * self.move_speed
	
	self.facing = 'left' if mouse_pos.x < 0 else 'right'
	self.sprite.play(self.facing)
	
	var shoot_recoil:float = .5
	
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		if !mouse_down && !mouse_pressed:
			mouse_pressed = true
			mouse_down = true
	else:
		mouse_down = false
		mouse_pressed = false
		
	if mouse_pressed:
		self.sprite.rotation = shoot_recoil if self.facing == 'left' else -shoot_recoil
		self.camera.zoom *= 0.995
		get_tree().get_root().get_child(0).create_soldier(position + mouse_pos)
		crosshair.rotate_speed = 1.0
		crosshair.sprite.scale = Vector2(2.0, 2.0)
	
	
	self.camera.zoom.x = lerp(self.camera.zoom.x, self.cam_default_zoom.x, 0.1)
	self.camera.zoom.y = lerp(self.camera.zoom.y, self.cam_default_zoom.y, 0.1)
	sprite.rotation = lerp(sprite.rotation, 0.0, 0.2)

	var m = (position_old != position);
	if (m && !moving):
		sprite.frame = 1
		moving = true;
	elif (!m && moving):
		sprite.frame = 0
		moving = 0
		
	sprite.speed_scale = 2.0 if moving else 0.0
	
	mouse_pressed = false
	
	z_index = position.y
	
	time += delta;
	pass

