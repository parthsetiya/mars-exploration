extends CanvasLayer


const MAINTEST = preload("res://scenes/maintest.tscn")
const HOUSETEST = preload("res://scenes/housetest.tscn")

func _ready():
	get_node("ColorRect").hide()
	get_node("Label").hide()
	
func changeStage(stage_path, x, y):
	get_node("ColorRect").show()
	get_node("Label").hide()
	get_node("anim").play("TransIn")
	await get_node("anim").animation_finished
	
	var stage = stage_path.instantiate()
	get_tree().get_root().get_child(1).free()
	get_tree().get_root().add_child(stage)
	stage.get_node("Player").position = Vector2(x, y)
	#get_tree().change_scene_to_file(stage_path)
	
	get_node("anim").play("TransOut")
	await get_node("anim").animation_finished
	get_node("ColorRect").hide()
