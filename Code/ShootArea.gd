extends Area2D

func _mouse_enter():
	get_parent().targeted = true
	pass

func _mouse_exit():
	print('aye')
	get_parent().targeted = false
	pass
