extends Control


@onready var backgroundsprite: Sprite2D = $background
@onready var itemsprite: Sprite2D = $CenterContainer/Panel/item

func update(item: InventoryItem):
	if !item:
		itemsprite.visible = false
	else:
		itemsprite.visible = true
		itemsprite.texture = item.texture
