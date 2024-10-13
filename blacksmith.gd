extends CharacterBody2D

var playerdata = PlayerData.new()
var resource = load("res://dialogue/testing.dialogue")
@onready var blacksmithshop = $blacksmithshop
var playerinarea = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		DialogueManager.show_example_dialogue_balloon(resource, "blacksmith")
		playerinarea = true



func _process(delta):
	if playerinarea && Input.is_action_just_pressed("g"):
		blacksmithshop.show()
	#if not playerinarea or Input.is_action_just_pressed("left_mouse"):
		#blacksmithshop.hide()

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		playerinarea = false
