extends Node2D


@onready var pause_menu = $Player/Camera2D/Pausemenu
var paused = false

@onready var interact_to_read = $Sprite2D/startsignpostarea/interact_to_read

@onready var thiswaytomines = $Sprite2D/thiswaytomines

@onready var inventory_gui = $Player/Camera2D/InventoryGui

@onready var start_sign_post_entered = false

var is_showing_thiswaytomines = false

var inv_open = false
	
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
	if start_sign_post_entered:
		interact_to_read.show()
		if Input.is_action_just_pressed("Interact"):
			if is_showing_thiswaytomines:
				thiswaytomines.hide()
				is_showing_thiswaytomines = false
			else:
				interact_to_read.hide()
				thiswaytomines.show()
				is_showing_thiswaytomines = true
	else:
		interact_to_read.hide()
	if Input.is_action_just_pressed("Inventory"):
		inventory()
		
		
		
func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale =  1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
func _on_startsignpostarea_body_entered(body):
	start_sign_post_entered = true

func _on_startsignpostarea_body_exited(body):
	start_sign_post_entered = false
	thiswaytomines.hide()
	is_showing_thiswaytomines = false 


func inventory():
	if inv_open:
		inventory_gui.hide()
	else:
		inventory_gui.show()
	inv_open = !inv_open 
	


func _on_entrancetogoldmine_body_entered(body):
	if body.name == "Player":
		StageManager.changeStage(StageManager.GOLDMINE, 453, -30)
