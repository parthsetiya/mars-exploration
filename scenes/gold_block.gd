extends Node2D

var state = "no_gold" 
var player_in_area = false

var gold = preload("res://scenes/gold_collectable.tscn")

@export var item: InvItem
var player = null

func _ready():
	print(gold)
	if state == "no_gold":
		$respawn_timer.start()
	
	
func _process(delta):
	if state == "no_gold":
		$AnimatedSprite2D.play("no_gold")
	if state == "gold":
		$AnimatedSprite2D.play("gold")
		if player_in_area == true:
			print("yeeeeee")
			if Input.is_action_just_pressed("Interact"):
				state = "no_gold"
				drop_gold()


func _on_respawn_timer_timeout():
	if state == "no_gold":
		state = "gold"

func drop_gold():
	
	var gold_instance = gold.instantiate()
	gold_instance.global_position = $Marker2D.global_position
	get_parent().add_child(gold_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$respawn_timer.start()
	




func _on_area_2d_body_entered(body):
	player_in_area = true
	player = body
	



func _on_area_2d_body_exited(body):
	player_in_area = false
