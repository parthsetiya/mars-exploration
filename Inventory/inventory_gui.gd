extends Control

signal slot_clicked(slot_index)

func _ready():
	var grid_container = $NinePatchRect/GridContainer
	var slots = grid_container.get_children()
	for i in range(slots.size()):
		var slot = slots[i]
		slot.connect("gui_input", Callable(self, "_on_slot_gui_input").bind(i))

func _on_slot_gui_input(event, slot_index):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("slot_clicked", slot_index)
