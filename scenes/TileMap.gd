extends TileMap

var map_size_x := 50
var map_size_y := 50

var tile_sea = Vector2(5, 13)
var tile_beach = Vector2(1, 13)
var tile_bound = Vector2(19, 2)

@onready var file = 'res://data/map.txt'

func _ready():
	load_file(file)

func load_file(file):
	
	var this_tile_set = tile_set
	
	var f = FileAccess.open(file, FileAccess.READ)
	var x_index = 0
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		var y_index := 0
		for c in line:
			var tile_type = Vector2.ZERO
			var tile = tile_set.til
			match c:
				"x":
					tile_type = tile_bound
				"w":
					tile_type = tile_sea
				"b":
					tile_type = tile_beach			
					
					
			set_cell(0, Vector2(x_index, y_index), 0, tile_type)
			y_index += 1
		x_index += 1
	f.close()
	return
