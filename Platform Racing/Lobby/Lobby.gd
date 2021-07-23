extends Node2D

onready var HostLobby = preload("res://Platform Racing/Lobby/HostLobbyScreen/HostLobbyScreen.tscn")
onready var ClientLobby = preload("res://Platform Racing/Lobby/ClientLobbyScreen/ClientLobbyScreen.tscn")

func _ready():
	var peer = get_tree().get_network_peer()

	if not peer:
		return

	if get_tree().is_network_server():
		var host_lobby = HostLobby.instance()
		host_lobby.connect("start_game", self, "_on_game_start")
		add_child(host_lobby)
	else:
		var client_lobby = ClientLobby.instance()
		add_child(client_lobby)

func _on_game_start():
	var peer = get_tree().get_network_peer()
	rpc("_on_game_started")
	get_tree().change_scene("res://Platform Racing/World/World.tscn")

remote func _on_game_started():
	get_tree().change_scene("res://Platform Racing/World/World.tscn")
