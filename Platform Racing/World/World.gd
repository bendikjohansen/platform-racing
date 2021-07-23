extends Node2D

onready var Character = preload("res://Platform Racing/Character/Character.tscn")
onready var PlayerMovement = preload("res://Platform Racing/Character/PlayerMovement.gd")

func _ready():
	var player = Character.instance()
	var peer_id = get_tree().get_network_unique_id()
	player.set_network_master(peer_id)
	player.set_script(PlayerMovement)
	player.set_name(str(peer_id))
	var camera = Camera2D.new()
	camera.current = true
	player.add_child(camera)
	add_child(player)

	for id in get_tree().get_network_connected_peers():
		var character = Character.instance()
		character.set_network_master(id)
		character.set_name(str(id))
		add_child(character)
