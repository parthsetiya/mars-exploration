extends Control
var playerdata = PlayerData.new()
@onready var rich_text_label = $RichTextLabel


func _process(delta):
	rich_text_label.clear()


	var text = ""
	text += "Amethyst Gears: " + str(playerdata.spaceship_amethyst_gears) + "/5\n"
	text += "Cartons of Oil: " + str(playerdata.spaceship_carton_of_oil) + "/3\n"
	text += "Cobalt Gears: " + str(playerdata.spaceship_cobalt_gears) + "/5\n"
	text += "Computer Chips: " + str(playerdata.spaceship_computer_chip) + "/1\n"
	text += "Gold Gears: " + str(playerdata.spaceship_gold_gears) + "/5\n"
	text += "Machine Parts: " + str(playerdata.spaceship_machine_parts) + "/4\n"
	text += "Thruster Repair Kits: " + str(playerdata.spaceship_thruster_repair_kits) + "/2\n"
	text += "Wires: " + str(playerdata.spaceship_wires) + "/10\n"
	rich_text_label.text = text

