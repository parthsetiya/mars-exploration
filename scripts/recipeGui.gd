extends Control


var recipes = {
	"Stick": {"Wood": "2",},
	"Recipe 2": {"Ingredient 3": "1 unit", "Ingredient 4": "3 units"}
}

var recipe_buttons = {}

func _ready():
	create_recipe_list()

func create_recipe_list():
	var vbox = $VBoxContainer  
	
	for recipe_name in recipes.keys():
		var recipe_button = Button.new()
		recipe_button.text = recipe_name
		
		# Store the recipe name with the button
		recipe_buttons[recipe_button] = recipe_name
		
		# Connect the button signal, passing the button as an argument
		recipe_button.connect("pressed", Callable(self, "_on_recipe_pressed").bind(recipe_button))
		vbox.add_child(recipe_button)

		# Create a VBoxContainer for ingredients and hide it by default
		var ingredients_vbox = VBoxContainer.new()
		ingredients_vbox.visible = false  # Start hidden
		ingredients_vbox.name = recipe_name + "_ingredients"
		
		# Add ingredients to the VBoxContainer
		for ingredient in recipes[recipe_name].keys():
			var ingredient_label = Label.new()
			ingredient_label.text = ingredient + ": " + recipes[recipe_name][ingredient]
			ingredients_vbox.add_child(ingredient_label)
		
		vbox.add_child(ingredients_vbox)

func _on_recipe_pressed(button):
	var recipe_name = recipe_buttons[button]
	var ingredients_vbox = $VBoxContainer.get_node(recipe_name + "_ingredients")
	ingredients_vbox.visible = not ingredients_vbox.visible
