extends GridContainer

export (PackedScene) var Case

export var DIMENSIONS: int = 80
var selected_cases: Array = []

func load_cases(c: Array):
	self.columns = int(sqrt(c.size()))
	while self.get_child_count() != 0:
		self.remove_child(self.get_child(0))
	for case in c:
		var new_case = Case.instance()
		new_case.init(case is int, case, DIMENSIONS)
		new_case.show()
		self.add_child(new_case)
	self.rect_size = Vector2(DIMENSIONS * self.columns, DIMENSIONS * self.columns)

func _input(event: InputEvent):
	if (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT and event.pressed:
			var position: Vector2 = event.position - self.rect_position
			var x: int = position.x / DIMENSIONS
			var y: int = position.y / DIMENSIONS
			if x >= 0 and x < self.columns and y >= 0 and y < self.columns:
				var child_index = x + self.columns * y
				var change_color: bool = false
				if self.selected_cases.empty():
					change_color = (x == 0 and y == 0)
				else:
					var last_case = self.selected_cases.back()
					change_color = (last_case.x == x and last_case.y + 1 == y) \
						or (last_case.x + 1 == x and last_case.y == y)
				if change_color:
					self.selected_cases.push_back(Vector2(x, y))
					var child = self.get_child(child_index)
					child.set_color(Color(1.0, 0.5, 0.0))
	if (event is InputEventKey):
		if (event.scancode == KEY_Z and Input.is_key_pressed(KEY_Z)):
			if !self.selected_cases.empty():
				var last_case = self.selected_cases.pop_back()
				self.get_child(last_case.x + self.columns * last_case.y) \
					.set_color(Color(0.0, 0.0, 0.0, 0.0))
