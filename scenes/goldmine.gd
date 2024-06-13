extends Node2D

var player_position = Vector2()


func get_player_position():
	# Access the player's position property and store it in the variable
	player_position = position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_backtomain_body_entered(body):
	if body.name == "Player":
		get_player_position()
		StageManager.changeStage(StageManager.MAINTEST, -381, -277)
