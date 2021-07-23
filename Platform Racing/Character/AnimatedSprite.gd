extends AnimatedSprite

func turn(movement: float):
	if movement != 0:
		flip_h = movement < 0
		play("Run")
	else:
		play("Idle")
