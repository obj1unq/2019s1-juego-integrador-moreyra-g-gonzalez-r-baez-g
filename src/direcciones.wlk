class Direction {
	method siguiente(position)
}

object izquierda inherits Direction { 
	override method siguiente(position) = position.left(1) 
	method opuesto() = derecha
}

object derecha inherits Direction { 
	override method siguiente(position) = position.right(1) 
	method opuesto() = izquierda
}

object abajo inherits Direction { 
	override method siguiente(position) = position.down(1) 
	method opuesto() = arriba
}

object arriba inherits Direction { 
	override method siguiente(position) = position.up(1) 
	method opuesto() = abajo
}