extends KinematicBody2D

var MAXSPEED = 80
var acceleration = 300
var motion = Vector2.ZERO
var possible_players 
var target_player
var dead = 0
var direction = 1
signal enemy_died
onready var death_sound1 = $DeathSound
onready var players = get_tree().get_root().find_node("Players", true, false)
onready var world = get_tree().root.get_node("World")
onready var speed_timer = $SpeedTimer
onready var sprite = $AnimatedSprite
onready var death_timer = $DeathTimer
onready var hurtbox =$HurtBox/hurtbox
onready var hitbox = $HitBox/hitbox

func _ready():
	possible_players = players.get_children()	
	target_player = possible_players[0]
	speed_timer.start(1)

remote func select_player_target(idx):
	target_player = possible_players[idx]
	
func _physics_process(delta):
	var player_direction = (target_player.position - global_position).normalized()
	if dead !=1:
		motion = motion.move_toward(player_direction * MAXSPEED , acceleration * delta)
		motion = move_and_slide(motion)
		sprite.play("walk")
		sprite.set_scale(Vector2(sign(motion.x), 1))

func _on_PlayerDetection_body_entered(body):
	if body.is_in_group('Player'):
		target_player = body
		
		

func _on_HurtBox_area_entered(area):
	if area.is_in_group("Bullet"):
		sprite.play("death")
		dead =1
		emit_signal("enemy_died",true)
		death_sound1.play()
		hurtbox.set_deferred("disabled",true)
		hitbox.set_deferred("disabled",true)
		death_timer.start()
		
		
func _on_HitBox_body_entered(body):
	if body.is_in_group("Player"):
		if dead !=1:
			body.damage()


func _on_SpeedTimer_timeout():
	MAXSPEED += 5




func _on_DeathTimer_timeout():
	queue_free()
	
