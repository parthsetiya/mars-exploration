extends CanvasLayer


const MAINTEST = ("res://scenes/maintest.tscn")
const HOUSETEST = ("res://scenes/housetest.tscn")

func _ready():
	get_node("ColorRect").hide()
	get_node("Label").hide()
	
func changeStage(stage_path):
	get_node("ColorRect").show()
	get_node("Label").show()
	get_node("anim").play("TransIn")
	await get_node("anim").animation_finished
	
	get_tree().change_scene_to_file(stage_path)
	
	get_node("anim").play("TransOut")
	await get_node("anim").animation_finished
	get_node("ColorRect").hide()
