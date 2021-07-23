extends CenterContainer

onready var address_input = $VBoxContainer/JoinContainer/AddressInput

const PORT = 8000
const MAX_PLAYERS = 8

func _on_JoinButton_pressed():
	var address_raw = address_input.get_text()
	if not address_raw:
		return

	var full_address = address_raw.split(':')
	if len(full_address) != 2:
		return

	var ip = full_address[0]
	var port = int(full_address[1])

	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().network_peer = peer

	get_tree().change_scene("res://Platform Racing/Lobby/Lobby.tscn")

func _on_OpenServerButton_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = peer

	get_tree().change_scene("res://Platform Racing/Lobby/Lobby.tscn")

func _on_QuitGameButton_pressed():
	get_tree().quit()
