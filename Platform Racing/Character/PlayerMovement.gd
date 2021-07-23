extends "res://Platform Racing/Character/Character.gd"

func _process(delta: float):
	var horizontal_movement := (Input.get_action_strength("move_right")
							- Input.get_action_strength("move_left"))
	if Input.is_action_just_pressed("jump"):
		jump()
	move(horizontal_movement)
