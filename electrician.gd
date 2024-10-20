extends CharacterBody2D

var playerdata = PlayerData.new()
var playerscript = Player.new()
var resource = load("res://dialogue/testing.dialogue")
@onready var electricianshop = $electricianshop
var playerinarea = false
var shopshow = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		DialogueManager.show_example_dialogue_balloon(resource, "electrician")
		playerinarea = true



func _process(delta):
	if playerinarea && Input.is_action_just_pressed("g"):
		shopopen()

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		playerinarea = false

func shopopen():
	if shopshow:
		electricianshop.hide()
	else:
		electricianshop.show()
	shopshow = !shopshow
