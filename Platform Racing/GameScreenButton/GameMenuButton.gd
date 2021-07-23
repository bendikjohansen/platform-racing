extends Button

func _on_GameMenuButton_pressed():
	get_tree().network_peer = null
	get_tree().change_scene("res://Platform Racing/MenuScreen/MenuScreen.tscn")
