extends Node

func _input(event):
	if event.is_action_pressed("open_menu"):
		get_tree().change_scene("res://Platform Racing/MenuScreen/MenuScreen.tscn")
