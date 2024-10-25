extends Control
signal slot_clicked(slot_index)


# Connect the slot's input event to the _on_slot_gui_input function, passing the slot index
func _ready():
	var grid_container = $GridContainer
	var slots = grid_container.get_children()
	for i in range(slots.size()):
		var slot = slots[i]
		slot.connect("gui_input", Callable(self, "_on_slot_gui_input").bind(i))


# Called when the user interacts with a slot (e.g., clicks)
func _on_slot_gui_input(event, slot_index):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("slot_clicked", slot_index)  # Emit the slot_clicked signal with the slot's index

