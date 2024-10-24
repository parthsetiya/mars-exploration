extends Button
@onready var table = $".."
@onready var crafting = $"../.."
var maxNum
var num = 0
var playerdata = PlayerData.new()
signal request_inventory_update

