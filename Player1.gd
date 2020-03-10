extends KinematicBody2D

var velocidad = Vector2()
const Speed = 7
const Gravity = 20
const Jump_power = -350
const Floor = Vector2(0,-1)
const VelocidadMaxima = 200
var on_ground = false
export var lado = true
export var jugador = 1
var just_pressed = true
var pina = false
signal restar_vida
var vida= 100
var muerto = false

func _ready():
	$AnimatedSprite.animation = 'idle'
	$AnimatedSprite.flip_h = lado

func _physics_process(delta):
	if muerto:
		return
	if($AnimatedSprite.animation == 'morir'):
		return
	#1 es el numero del ultimo frame de la piña
	pina = ($AnimatedSprite.animation =='pina' && $AnimatedSprite.frame < 1)
	
	$Area2D/CollisionShape2D2.disabled = true
	
	if Input.is_action_pressed("ui_right"):
		if on_ground==true:
			$AnimatedSprite.animation = 'caminando'
		if velocidad.x < 0: 
			velocidad.x = 0
		if velocidad.x < VelocidadMaxima: 
			velocidad.x += Speed
		$AnimatedSprite.flip_h = false
		lado = false
		$Area2D/CollisionShape2D2.position.x = abs( $Area2D/CollisionShape2D2.position.x) 
			
	elif Input.is_action_pressed("ui_left"):
		if on_ground==true:
			$AnimatedSprite.animation = 'caminando'
		$AnimatedSprite.flip_h = true
		lado = true
		$Area2D/CollisionShape2D2.position.x = -abs( $Area2D/CollisionShape2D2.position.x)
		if velocidad.x > 0: 
			velocidad.x = 0
		if velocidad.x < VelocidadMaxima: 
			velocidad.x += -Speed
	else:
		if (on_ground==true and pina == false):
			$AnimatedSprite.animation = 'idle'
		velocidad.x = 0
		
	if Input.is_action_pressed("ui_up"):
		if on_ground==true:
			$AnimatedSprite.animation = 'saltar'
			velocidad.y += Jump_power
			on_ground = false

	if Input.is_action_pressed("player1_puno_normal") and just_pressed:
		if on_ground==true:
			$AnimatedSprite.animation = 'pina'
			$Area2D/CollisionShape2D2.disabled = false
			

	velocidad.y += Gravity
	
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
	
	velocidad = move_and_slide(velocidad, Floor)

func _input(event):
	just_pressed = event.is_pressed() and not event.is_echo()

func hacerDano():
	vida-=10
	if vida==0:
		$AnimatedSprite.animation = 'morir'
		muerto=true

func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	print(body.name)
	if body.name == "Player2":
		body.hacerDano()
		emit_signal("restar_vida")
