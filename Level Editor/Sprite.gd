extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func load_img(path):
	var img = Image.new()
	img.load(str(path))
	img.decompress()
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	texture = tex
#	$'../Panel/HBoxContainer/Right/HBoxContainer/LineEdit'.set_text(str(path))
