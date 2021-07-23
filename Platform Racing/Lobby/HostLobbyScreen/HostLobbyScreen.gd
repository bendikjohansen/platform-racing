extends CenterContainer

onready var ip_address = $VBoxContainer/IpAdressValue

const PORT = 8000
const MAX_PLAYERS = 8

signal start_game()

func _ready():
	ip_address.set_text(IP.get_local_addresses()[-2] + ":" + str(PORT))

func _on_StartGameButton_pressed():
	emit_signal("start_game")
