extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
var save_file_path: String = "user://save_game.json"

func save_game(player: Sprite2D) -> void:
	var save_data = player.get_save_data()
	var file = File.new()
	if file.open(save_file_path, File.WRITE) == OK:
			file.store_string(to_json(save_data))
			file.close()
			print("Game saved successfully.")
	else:
		print("Failed to save game.")


func load_game(player: Sprite2D) -> void:
	var file = File.new()
	if file.file_exists(save_file_path):
		if file.open(save_file_path, File.READ) == OK:
			var save_data = parse_json(file.get_as_text())
			file.close()
			player.load_save_data(save_data)
			print("Game loaded successfully.")
		else:
			print("Failed to load game.")
	else:
		print("No save file found.")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
