#extends CanvasLayer
#
#var has_just_changed_scene = false
#var is_player_inside = false
#
#const MAINTEST = preload("res://scenes/maintest.tscn")
#const HOUSETEST = preload("res://scenes/housetest.tscn")
#const PLAYER = preload("res://scenes/player.tscn")
#
#func _ready():
	#get_node("ColorRect").hide()
	#get_node("Label").hide()
#
#func _on_body_entered(body):
	#if body.name == "Player" and not has_just_changed_scene:
		#is_player_inside = true
		##changeStage(HOUSETEST, 100, 100)
#
#func _on_body_exited(body):
	#if body.name == "Player":
		#is_player_inside = false
#
#
#func changeStage (stage_path, x, y):
	#has_just_changed_scene = true
	#get_node("ColorRect").show()
	#get_node("Label").hide()
	#get_node("anim").play("TransIn")
	#await get_node("anim").animation_finished
	#
	#var stage = stage_path.instantiate()
	#get_tree().get_root().get_child(1).free()
	#get_tree().get_root().add_child(stage)
	#if stage.has_node("Player"):
		#stage.get_node("Player").position = Vector2(x, y)
	#
	#get_node("anim").play("TransOut")
	#await get_node("anim").animation_finished
	#get_node("ColorRect").hide()
#
#func _on_animation_finished(anim_name):
	#if anim_name == "TransOut":
		#has_just_changed_scene = false

extends CanvasLayer

signal stageChangeCompleted

var is_transitioning = false

const MAINTEST = preload("res://scenes/maintest.tscn")
const HOUSETEST = preload("res://scenes/housetest.tscn")
const PLAYER = preload("res://scenes/player.tscn")

func _ready():
	get_node("ColorRect").hide()
	get_node("Label").hide()

func changeStage(stage_path, x, y):
	if is_transitioning:
		return

	is_transitioning = true

	get_node("ColorRect").show()
	get_node("Label").hide()
	get_node("anim").play("TransIn")
	await get_node("anim").animation_finished
	
	var stage = stage_path.instantiate()
	get_tree().get_root().get_child(1).free()
	get_tree().get_root().add_child(stage)
	if stage.has_node("Player"):
		stage.get_node("Player").position = Vector2(x, y)
	
	get_node("anim").play("TransOut")
	await get_node("anim").animation_finished
	get_node("ColorRect").hide()

	is_transitioning = false
	emit_signal("stageChangeCompleted")

