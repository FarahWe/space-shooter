extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var pause_menu = $UILayer/PauseMenu
@onready var pb = $ParallaxBackground

var player = null

var scroll_speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		pause_menu.open()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
	if timer.wait_time > 0.5:
		timer.wait_time =- delta*0.005
		
	pb.scroll_offset.y += delta * scroll_speed
	if pb.scroll_offset.y >= 960:
		pb.scroll_offset.y = 0

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)

func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50 , 500), -50)
	enemy_container.add_child(e)
