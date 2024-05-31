extends Node

var save_file_path: String = "user://save_game.json"

# Function to save the game
func save_game(player: CharacterBody2D) -> void:
	var save_data = player.get_save_data()
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))  # Use JSON.stringify to convert the dictionary to a string
		file.close()
		print("Game saved successfully.")
	else:
		print("Failed to save game.")

# Function to load the game
func load_game(player: CharacterBody2D) -> void:
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	if file:
		var json = JSON.new()
		var file_content = file.get_as_text()
		print("Loaded file content:", file_content)  # Debugging: print the file content
		var parse_result = json.parse(file_content)

		# parse_result is a JSONParseResult
		if parse_result.error == OK:  # Check for OK
			var save_data = parse_result.result  # Access the result property from JSON.parse
			player.load_save_data(save_data)
			print("Game loaded successfully.")
		else:
			print("Failed to parse save file:", parse_result.error)  # Print the error code for debugging
		file.close()
	else:
		print("No save file found or failed to load game.")
		

