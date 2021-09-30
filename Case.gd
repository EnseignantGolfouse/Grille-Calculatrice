extends ReferenceRect

var is_number: bool
var number: int
var symbol: String
var tile_id: int


func init(is_number: bool, number_or_symbol, size: int):
	self.is_number = is_number
	if self.is_number:
		self.number = number_or_symbol
	else:
		self.symbol = number_or_symbol
	#$Center/Text.bbcode_text = "[center]" + String(number_or_symbol) + "[/center]"
	self.rect_size = Vector2(size, size)
	self.rect_min_size = Vector2(size, size)
	$Text.text = String(number_or_symbol)

func set_color(color: Color):
	$Color.color = color
