extends CharacterBody2D

var in_talkable = false
var player = null
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
	else:
			dialogue.hide()
