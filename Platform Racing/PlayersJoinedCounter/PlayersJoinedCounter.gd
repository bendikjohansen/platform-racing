extends Label

var label_text = "Players joined: "
var counter = 1

func _ready():
	set_text(label_text + str(counter))
	var peer = get_tree().get_network_peer()

	if not peer:
		return

	peer.connect("peer_connected", self, "_on_peer_connected")
	peer.connect("peer_disconnected", self, "_on_peer_disconnected")

func _on_peer_connected(id: int):
	counter += 1
	set_text(label_text + str(counter))

func _on_peer_disconnected(id: int):
	counter -= 1
	set_text(label_text + str(counter))
