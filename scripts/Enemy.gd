class_name Enemy extends Area2D

@export var speed = 200
@export var hp = 1
	
func _physics_process(delta):
	global_position.y += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func die():
	queue_free()

func take_damage(damage):
	if hp - damage == 0:
		die()
	else:
		hp -= 1

func _on_body_entered(body):
	if body is Player:
		body.die()
		die()

