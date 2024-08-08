extends Node2D
@onready var spaceship_entered = false
@onready var crashmessage = $spaceshiparea/crashmessage
#
#
#func _process(delta):
	#if spaceship_entered:
		#crashmessage.show()
#
#func _on_spaceship_entered(body):
	#if body == player:
		#spaceship_entered = true
#
#func _on_spaceship_exited(body):
	#if body == player:
		#spaceship_entered = false
