extends Node

export (PackedScene) var Grid
var active_grid_child = null

const GRIDS = [
	[24, "+", 3, "-", 5, "÷", 21, "×", 2],
	[
		80 , "+", 10  ,
		"-", 20 , "÷",
		12 , "×", 5  ,
	],
	[
		30 , "+", 13 , "-", 8,
		"-", 21 , "-", 7  , "×",
		10 , "×", 4  , "×", 3,
		"+", 6  , "×", 2  , "+",
		15 , "÷", 3  , "-", 11
	],
]

const GOALS = [14, 20, 24]

func _ready():
	randomize()
	$Regles.hide()

func load_grid(grid: Array, goal: float):
	var new_grid = Grid.instance()
	new_grid.load_cases(grid)
	$Result.text = "BUT : " + String(goal)
	$Menu.hide()
	$RandomGrid.hide()
	$Result.show()
	$Regles.show()
	self.add_child(new_grid)
	self.active_grid_child = new_grid

func on_click_button_1():
	self.load_grid(GRIDS[0], GOALS[0])

func on_click_button_2():
	self.load_grid(GRIDS[1], GOALS[1])

func on_click_button_3():
	self.load_grid(GRIDS[2], GOALS[2])

static func make_random_grid() -> Array:
	var random_grid: Array = [24, "+", 3, "-", 5, "÷", 21, "×", 2]
	random_grid[0] = randi() % 30 + 1 # 24
	random_grid[2] = randi() % 30 + 1 # 3
	random_grid[4] = randi() % 9 + 1 # 5
	random_grid[6] = randi() % random_grid[0] + 1 # 21
	random_grid[8] = randi() % 9 + 1 # 2
	return random_grid

func on_click_button_random():
	var random_grid
	var random_goal: float = -1.0
	while random_goal < 0 or (round(random_goal) != random_goal):
		random_grid = make_random_grid()
		match (randi() % 6):
			0: random_goal = random_grid[0] + float(random_grid[2]) / random_grid[8]
			1: random_goal = random_grid[0] + float(random_grid[4]) / random_grid[8]
			2: random_goal = random_grid[0] + float(random_grid[4]) * random_grid[8]
			3: random_goal = random_grid[0] - float(random_grid[4]) / random_grid[8]
			4: random_goal = random_grid[0] - float(random_grid[4]) * random_grid[8]
			5: random_goal = random_grid[0] - float(random_grid[6]) * random_grid[8]
	self.load_grid(random_grid, random_goal)

func _input(event: InputEvent) -> void:
	if (event is InputEventKey):
		if (event.scancode == KEY_Q and Input.is_key_pressed(KEY_Q)):
			if self.active_grid_child != null:
				self.remove_child(self.active_grid_child)
				self.active_grid_child.queue_free()
				self.active_grid_child = null
				$Menu.show()
				$RandomGrid.show()
				$Result.hide()
				$Regles.hide()
