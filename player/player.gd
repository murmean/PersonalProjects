extends KinematicBody2D

const MAXSPEED = 300
const ACCELERATION =6666666
const FRICTION = 666666666
const BULLET = preload("res://player/playerbullet.tscn")
const BAR = preload("res://ui/bar.tscn")
const SHOTGUN = preload("res://player/shotgun.tscn")
const UZI = preload("res://player/uzi.tscn")
onready var world = get_tree().get_root().get_node("World")


var motion = Vector2.ZERO
var bar = BAR.instance()
var can_fire = true
var picked_shotgun = false
var picked_uzi = false
var facing_r = true
onready var gun = $GunSprite
onready var anim = $PlayerSprite
onready var uzi = $CanvasLayer/GunPos/Uzi_popup
onready var shotgun =$CanvasLayer/GunPos/Shotgun_popup
onready var pickup_sound = $PickupSound
onready var first_song = $FirstSong
onready var second_song = $SecondSong
onready var change_scene = $ChangeScene
onready var death_sound = $DeathSound
onready var gun_pos =$CanvasLayer/GunPos
onready var bullet_spread =$BulletSpread
onready var gun_timer = $GunTimer
onready var bar_loc = $CanvasLayer/Barposition
onready var bullet_loc = $GunSprite/BulletFireLoc
onready var fire_rate = $FireRate
onready var shotgun_loc = $GunSprite/ShotgunPos
onready var shotgun_loc2 = $GunSprite/ShotgunPos2


func _ready():
	
	first_song.play()
func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector, delta)
	apply_friction(input_vector, delta)
	motion = move_and_slide(motion) 
	fire()
	
func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if Input.is_action_pressed("move_left"):
		facing_r = false
	if Input.is_action_pressed("move_right"):
		facing_r = true
	if facing_r == true:
		$PlayerSprite.flip_h = false	
	else:
		$PlayerSprite.flip_h = true 
			
	return input_vector.normalized()

func apply_movement(input_vector, delta):
	gun.look_at(get_global_mouse_position())
	if input_vector != Vector2.ZERO:
		motion = motion.move_toward(input_vector * MAXSPEED, ACCELERATION * delta)
		anim.play("run")
	else:
		anim.play("idle")

func apply_friction(input_vector, delta):
	if input_vector == Vector2.ZERO:
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)

func damage():	
	set_physics_process(false)
	death_sound.play()
	hide()
	if get_tree().change_scene("res://screens/endscreen/endscreen.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")
	
func fire():
	if Input.is_action_pressed("fire") and can_fire:
		can_fire = false
		spawn_bullet()
		if picked_shotgun == true:
			shotgun_bullet()
			fire_rate.start(0.50)
		elif picked_uzi == true:
			fire_rate.start(0.2)
			
		else:
			fire_rate.start(1)

sync func spawn_bullet():
	var bullet_instance = BULLET.instance()
	world.add_child(bullet_instance)
	bullet_instance.transform = bullet_loc.global_transform

func shotgun_bullet():
	var bullet_instance1 = BULLET.instance()
	var bullet_instance2 = BULLET.instance()
	world.add_child(bullet_instance1)
	world.add_child(bullet_instance2)
	bullet_instance1.transform = shotgun_loc.global_transform
	bullet_instance2.transform = shotgun_loc2.global_transform
	

func _on_FireRate_timeout():
	can_fire = true


func _on_Pick_range_area_entered(area):
	if area.is_in_group("Shotgun"):
		picked_shotgun =true
		picked_uzi =false
		pickup_sound.play()
		gun_decay()
	if area.is_in_group("Uzi"):
		picked_uzi = true
		picked_shotgun =false
		gun_decay()
		pickup_sound.play()

func gun_decay():
	if picked_uzi ==true:
		gun_timer.start(14)
		picked_shotgun =false
		add_bar()
		#uzi.show()
	#	shotgun.hide()
			
		
	elif picked_shotgun ==true :
		gun_timer.start(18)
		picked_uzi = false
		add_bar()
		#shotgun.show()
	#	uzi.hide()
			
		
		
		
func _on_GunTimer_timeout():
	if picked_uzi ==true:
		picked_uzi = false
		bar_loc.remove_child(bar)
		#uzi.hide()
	elif picked_shotgun == true:
		picked_shotgun = false
		bar_loc.remove_child(bar)
		#shotgun.hide()
		
func add_bar():
	if picked_shotgun == true:
		if bar_loc.get_child_count() == 0:
			bar_loc.add_child(bar)
		bar.set_frame(0)
		bar.play("bar")
		bar.set_speed_scale(0.41)
	if picked_uzi == true:
		if bar_loc.get_child_count() == 0:
			bar_loc.add_child(bar)
		bar.set_frame(0)
		bar.play("bar")
		bar.set_speed_scale(0.536)


func _on_MusicTimer_timeout():
	second_song.play()


	
