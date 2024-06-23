extends CharacterBody2D

var in_talkable = false
var player = null
var playerData = PlayerData.new()
@onready var dialogue = $dialogue


func _on_talkablearea_body_entered(body):
	in_talkable = true
	player = body
	if in_talkable && playerData.invGoldIngot >= 2:
		playerData.add_invGoldIngot(-2)
		print("Jhao is taking yo ahh gold")
		print(playerData.invGoldIngot)

func _on_talkablearea_body_exited(body):
	in_talkable = false
	player = null
	
func _process(delta):
	if in_talkable == true:
		dialogue.show()
	else:
		dialogue.hide()
