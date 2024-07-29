extends Button
@onready var table = $".."
@onready var crafting = $"../.."
var maxNum
var num = 0

func _ready():
	maxNum = crafting.items.size()


func _on_pressed():
	if num < maxNum:
		num += 1
	else:
		num = 0
	text = str(num)
	table.updateTable()
