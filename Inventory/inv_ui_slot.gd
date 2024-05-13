extends Panel

@onready var item_visuals: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label


func update(slot: invslot):
	if !slot.item:
		item_visuals.visible = false
		amount_text.visible = false
	else:
		item_visuals.visible = true
		item_visuals.texture = slot.item.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)
