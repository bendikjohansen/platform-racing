extends Node2D

onready var Character = preload("res://Platform Racing/Character/Character.tscn")
onready var PlayerMovement = preload("res://Platform Racing/Character/PlayerMovement.gd")
onready var Spawn = $Spawn

func _ready():
	var player = Character.instance()
	player.set_script(PlayerMovement)
	var camera = Camera2D.new()
	camera.current = true
	player.add_child(camera)
	player.global_position = Spawn.global_position
	add_child(player)

	if not get_tree().get_network_peer():
		return

	var peer_id = get_tree().get_network_unique_id()
	player.set_network_master(peer_id)
	player.set_name(str(peer_id))

	for id in get_tree().get_network_connected_peers():
		var character = Character.instance()
		character.global_position = Spawn.global_position
		character.set_network_master(id)
		character.set_name(str(id))
		add_child(character)
