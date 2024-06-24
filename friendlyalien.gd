extends CharacterBody2D

var in_talkable = false
var player = null
var playerData = PlayerData.new()
@onready var dialogue = $dialogue


func _on_talkablearea_body_entered(body):
	in_talkable = true
	player = body
	

func _on_talkablearea_body_exited(body):
	in_talkable = false
	player = null
	
func _process(delta):
	if in_talkable == true:
		dialogue.show()
		if Input.is_action_just_pressed("Interact"):
			playerData.add_invGoldIngot(-2)
			print("Jhao is taking yo ahh gold")
			print(playerData.invGoldIngot)
			dialogue.hide()
	else:
		dialogue.hide()
