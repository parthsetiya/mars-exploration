extends CharacterBody2D

class_name Player

@onready var animations = $AnimationPlayer


@onready var death_screen = $DeathScreen
@onready var death_screen_color_rect = $Deathscreen/ColorRect
@onready var death_screen_label = $Deathscreen/ColorRect/Label

var speed = 100
var health = 100

var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"
var playerData = PlayerData.new()
signal update_ui(health, position)
#added reswawn location needs to be changed to last save location
var respawn_position = Vector2(playerData.SavePos)

func _ready():
	verify_save_directory(save_file_path)
	
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
	
func _process(delta):
	position += velocity * delta
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()
	#emit_signal("update_ui", playerData.health, self.position)
	emit_signal("update_ui", playerData.health, self.position)
	playerData.UpdatePos(self.position)

#checks players health
func check_health():
	print("checking health")
	if playerData.health >= 0:
		print("health removal worked running player death")
		on_player_death()

func on_player_death():
	$DeathScreen.show()
	print("showing deathscreen")
	#death_screen_color_rect.modulate = Color(0, 0, 0, 0)  # Set initial color to transparent
	$AnimationPlayer.play("fade_in")  # Play the fade-in animation
	print("playing fade_in")
	await get_tree().create_timer(2.0).timeout  # Show death screen for 2 seconds
	respawn()

func respawn():
	print("respawn function running")
	$DeathScreen.hide()
	self.position = respawn_position
	playerData.change_health(+100) 
	print(playerData.health)  # Reset health or any other parameters

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
