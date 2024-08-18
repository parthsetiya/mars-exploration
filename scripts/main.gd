extends Node2D
class_name Main

@onready var pause_menu = $Player/Camera2D/Pausemenu
var paused = false

@onready var interact_to_read = $Sprite2D/startsignpostarea/interact_to_read

@onready var thiswaytomines = $Sprite2D/thiswaytomines
@onready var inventory_gui = $Player/Camera2D/InventoryGui

@onready var spaceship_entered = false
@onready var spaceshiparea_2 = $Spaceship/spaceshiparea2
@onready var crashmessage = $spaceship/spaceshiparea/crashmessage

@onready var recipe_gui = $Player/Camera2D/recipeGui


@onready var start_sign_post_entered = false

var is_showing_thiswaytomines = false

@onready var player = $Player

var playerdata = PlayerData.new()
@onready var character_body_2d = $CharacterBody2D

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
	if spaceship_entered:
		crashmessage.show()
	if Input.is_action_just_pressed("Inventory"):
		if not inventory_gui.visible:
			inventory_gui.show()
		else:
			inventory_gui.hide()
	if Input.is_action_just_pressed("craftinglist"):
		if not recipe_gui.visible:
			recipe_gui.show()
		else:
			recipe_gui.hide()
	
func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale =  1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
func _on_startsignpostarea_body_entered(body):
	if body == player:	
		start_sign_post_entered = true

func _on_startsignpostarea_body_exited(body):
	if body == player:
		start_sign_post_entered = false
		thiswaytomines.hide()
		is_showing_thiswaytomines = false 


func _on_entrancetogoldmine_body_entered(body):
	if body.name == "Player":
		StageManager.changeStage(StageManager.GOLDMINE, 453, -30)



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		StageManager.changeStage(StageManager.HOUSETEST, 194, -41.5)
		

func _on_spaceshiparea_body_entered(body):
	if body == player:
		spaceship_entered = true
		crashmessage.show()


func _on_spaceshiparea_body_exited(body):
	if body == player:
		spaceship_entered = false
		crashmessage.hide()


