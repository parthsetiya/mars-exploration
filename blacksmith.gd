extends CharacterBody2D

var playerdata = PlayerData.new()
var playerscript = Player.new()
var main = Main.new()
var resource = load("res://dialogue/testing.dialogue")
@onready var blacksmithshop = $blacksmithshop
var playerinarea = false
var shopshow = false
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("bobbing")

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		DialogueManager.show_example_dialogue_balloon(resource, "blacksmith")
		playerinarea = true



func _process(delta):
	if playerinarea && Input.is_action_just_pressed("shop"):
		get_tree().change_scene_to_file("res://blacksmithshop.tscn")

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		playerinarea = false

#func shopopen():
	#if shopshow:
		#main.change_lock(false)
		#blacksmithshop.hide()
	#else:
		#blacksmithshop.show()
		#main.change_lock(true)
	#shopshow = !shopshow
