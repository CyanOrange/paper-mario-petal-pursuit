extends Spatial
export (PackedScene) var Mob

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$Mario.new_game()
	
	$HUD.update_hp(hp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
