class_name LittlePlayer extends CharacterBody2D

var playerName:String = "steamuser99"
var authID:int = 1
var steamID:int = 1

@onready var avatarSprite: Sprite2D = $Avatar

var raw_dir : float = 0

const walk_speed : float = 130.0

func _setupAll():
	avatarSprite.texture = util.getPlayerAvatar(steamID,64)

func _setupOthers():
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	set_process_unhandled_input(false)

func _setupAuthority():
	pass

func _ready() -> void:
	print("hi")
	_setupAll()
	if !is_multiplayer_authority():
		print("other..")
		_setupOthers()
		return
	_setupAuthority()

func _physics_process(delta: float) -> void:
	raw_dir = Input.get_axis("player_left","player_right")
	if not is_on_floor():
		velocity.y += 400 * delta
	velocity.x = raw_dir * walk_speed
	move_and_slide()
