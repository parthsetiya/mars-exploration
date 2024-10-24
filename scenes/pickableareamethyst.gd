extends Area2D
var animation = preload("res://scenes/iron_collectable.tscn") as PackedScene
@onready var amethyst_collectable = $amethyst_collectable
@onready var amethyst_block = $".."
var entered = false
var collectable = false

