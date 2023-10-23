extends Node2D

const PLAYER = preload("res://player/player.tscn")
const ENEMY = preload("res://enemy/enemy.tscn")
const TIMER = preload("res://ui/ui.tscn")
const SHOTGUN = preload("res://player/shotgun.tscn")
const UZI = preload("res://player/uzi.tscn")

var time =3

onready var spawninten = $EnemySpawnTimer
onready var player_spawn = $PlayerSpawn
onready var players = $Players
onready var enemies = $Enemies
onready var guns = $Guns

func _ready():
	spawn_player()
	spawninten.start(3.5)
remote func spawn_player():
	var player = PLAYER.instance()
	players.add_child(player)
	player.position = player_spawn.position

remote func spawn_enemy():
	var player = PLAYER.instance()
	randomize()
	var x_range = Vector2(-445, 2170)
	var y_range = Vector2(50, 1750)
	var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
	var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
	var random_pos1 = Vector2(random_x, random_y)
	var enemy_instance = ENEMY.instance()
	enemies.add_child(enemy_instance)
	if player.position != random_pos1:
		enemy_instance.position = random_pos1

remote func spawn_guns():
	var player = PLAYER.instance()
	randomize()
	var x_range = Vector2(382, 650)
	var y_range = Vector2(374, 640)
	var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
	var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
	var random_pos = Vector2(random_x, random_y)
	var array = [SHOTGUN.instance(),UZI.instance()]
	array.shuffle()
	var gun_instance =array[0]
	guns.add_child(gun_instance)
	if player.position != random_pos:
		gun_instance.position = random_pos

func _on_EnemySpawnTimer_timeout():
	spawn_enemy()
		
	
func _on_GunSpawnTImer_timeout():
	spawn_guns()


func _on_EnemySpawnIntensifier_timeout():
	if time >= 2:
		time -=1
	if time <=2 && time >=1.5:
		time -=0.5
	spawninten.start(time)
