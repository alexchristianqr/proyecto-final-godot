extends Area2D

var BalaEnemigo = load("res://BalaEnemigo.tscn") # Instanciar la escena

var screen_size
func _ready():
	screen_size = get_viewport_rect().size
	add_to_group("GroupEnemy") # Añadir escena a un grupo

func _on_TimeDisparo_timeout():
	disparar()

func disparar():
	var main = get_tree().get_root().get_node('Main')
	
	if (!main.GameOver && (randi() % 100) <= 1): 
		var nueva_bala = BalaEnemigo.instantiate()
		# Tomamos la posición del enemigo
		nueva_bala.position = Vector2(position.x, position.y)
		get_tree().get_root().get_node("Main").add_child(nueva_bala)

# Mover nave enemigo
# Tres movimientos de las naves
# Velocidad reemplaza a position
var i = 1 # I incrementa
var velocidad = Vector2(0,0);
func mover_nave():
	match(i):
		1: # Movimiento a la derecha
			if ((position.x + 33)  < (screen_size.x)):
				position.x += 1;
			else:
				get_tree().call_group('GroupEnemy', 'mover_izquierda');
		2: # Movimiento a la izquierda
			if(position.x > 33):
				position.x -= 1;
			else:
				get_tree().call_group('GroupEnemy', 'mover_abajo');
		3: # Movimento vertical abajo
		   # 65 por el alto de la nave y 32 para que decienda la mitad y choque
			if((position.y + 65) < screen_size.y):
				position.y += 65;
				get_tree().call_group('GroupEnemy', 'mover_derecha');
				
	return position

# Cambiar dirección del movimiento
func mover_izquierda():
	i=2;

func mover_abajo():
	i=3;

func mover_derecha():
	i=1;

# Cambiar el color de las naves
var e = 0
var mob_types
var n = 2
var nn = 1
func cambiar_nave():
	mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()

	match(nn):
		1:
			$AnimatedSprite2D.animation = mob_types[n]
			n = n - 1
			nn = 2
		2:
			$AnimatedSprite2D.animation = mob_types[n]
			n = n - 1
			nn = 3
		3:
			$AnimatedSprite2D.animation = mob_types[n]
			nn = 3

# Naves caidas
var lista_enemigos
func _on_Enemy_area_entered(_area):
	get_tree().get_root().get_node("Main/Gameover").contar_muertos()
	
	lista_enemigos = get_tree().get_nodes_in_group("GroupEnemy")
	
	if(lista_enemigos.size() == 1):
		get_tree().get_root().get_node("Main/Gameover").show()
		get_tree().get_root().get_node("Main/Gameover").label_ganaste()
		print("Cualquier cosa")
