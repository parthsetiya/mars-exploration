extends CharacterBody2D

var playerdata = PlayerData.new()
var playerscript = Player.new()
var resource = load("res://dialogue/testing.dialogue")
@onready var electricianshop = $electricianshop
var playerinarea = false
var shopshow = false
@onready var animation_player = $AnimationPlayer


# Plays NPC dialogue when the player is in the area
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		DialogueManager.show_example_dialogue_balloon(resource, "electrician")
		playerinarea = true

# Allows player to open the show when in the area if shop button pressed
func _process(delta):
	if playerinarea and Input.is_action_just_pressed("shop"):
		get_tree().change_scene_to_file("res://electricianshop.tscn")


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		playerinarea = false

