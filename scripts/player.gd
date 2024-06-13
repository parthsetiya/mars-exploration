extends CharacterBody2D

class_name Player

@onready var animations = $AnimationPlayer

@onready var inv_ui = $Inv_UI

@export var inv: Inv


var speed = 100
var health = 100

var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"
var playerData = PlayerData.new()

func _ready():
	verify_save_directory(save_file_path)
	if inv == null:
		inv = Inv.new()
		print("Inventory was null, created a new instance.")
	else:
		print("Inventory initialized successfully!")
	
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
		print("Collected item: ", item.name)
	else:
		print("Inventory is not initialized, cannot collect item")


