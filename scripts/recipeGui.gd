extends Control
var recipes = {
	"Stick": {"Wood": "2",},
	"Golden Pickaxe": {"Stick": "2", "Gold": "2"},
}

var recipe_buttons = {}


func _ready():
	create_recipe_list()


func create_recipe_list():
	var vbox = $VBoxContainer  
	for recipe_name in recipes.keys():
		var recipe_button = Button.new()
		recipe_button.text = recipe_name
		
		recipe_buttons[recipe_button] = recipe_name
		
		recipe_button.connect("pressed", Callable(self, "_on_recipe_pressed").bind(recipe_button))
		vbox.add_child(recipe_button)

		var ingredients_vbox = VBoxContainer.new()
		ingredients_vbox.visible = false  
		#ingredients_vbox.name = recipe_name + "_ingredients"
		
		for ingredient in recipes[recipe_name].keys():
			var ingredient_label = Label.new()
			ingredient_label.text = ingredient + ": " + recipes[recipe_name][ingredient]
			ingredients_vbox.add_child(ingredient_label)
		
		vbox.add_child(ingredients_vbox)


func _on_recipe_pressed(button):
	var recipe_name = recipe_buttons[button]
	var ingredients_vbox = $VBoxContainer.get_node(recipe_name + "_ingredients")
	ingredients_vbox.visible = not ingredients_vbox.visible

