extends CharacterBody2D

class_name Player

#@export var speed = 100

@onready var animations = $AnimationPlayer

@onready var inv_ui = $Inv_UI

@export var inv: Inv




#testing new loading code
var speed = 100
var health = 100

var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"
var playerData = PlayerData.new()

func _ready():
	verify_save_directory(save_file_path)
	
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
	
func _process(delta):
	position += velocity * delta
	if Input.is_action_just_pressed("Inventory"):
		invmenu()
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()
	emit_signal("update_ui", playerData.health, self.position)
	playerData.UpdatePos(self.position)

func load_data():
	playerData = ResourceLoader.load(save_file_path + save_file_name). duplicate(true)
	on_start_load()
	print("loaded data")
	
func on_start_load():
	self.position = playerData.SavePos

func save():
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("saved data")

func take_damage():
	playerData.change_health(-5)
	
func gain_health():
	playerData.change_health(5)

func _on_control_change_health(action):
	if action == "+":
		gain_health()
	elif action == "-":
		take_damage()
		
#end new code test



var invopen = false
	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func updateAnimation():
	if velocity.length() == 0: 
		animations.stop()
		
	else: 
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		elif velocity.y < 0: direction = "Idle"

		animations.play("walk" + direction)

func _physics_process(delta):
	get_input()
	move_and_slide()
	updateAnimation()
	
	
#func _process(delta):
	#position += velocity * delta
	#if Input.is_action_just_pressed("Inventory"):
		#invmenu()

func invmenu():
	if invopen:
		inv_ui.hide()
		speed = 100
	else:
		inv_ui.show()
		speed = 0
	invopen = !invopen
	
func collect(item):
	if inv != null:
		inv.insert(item)
	else:
		print("Inventory is not initialized, cannot collect item")

#
#var health: int = 100
#var inventory: Array = ["Test"]
#var save_file_path: String = "user://save_game.json"
#
## Function to get save data as a dictionary
#func get_save_data() -> Dictionary:
	#return {
		#"position": position,
		#"health": health,
		#"inventory": inventory
	#}
#
## Function to load save data from a dictionary
#func load_save_data(data: Dictionary) -> void:
	#if data.has("position"):
		#position = data["position"]
	#if data.has("health"):
		#health = data["health"]
	#if data.has("inventory"):
		#inventory = data["inventory"]
		
