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

object direccionRep{
	method abajo() = 1
	method izquierda() = 2
	method arriba() = 3
	method derecha() = 0

	method opuesto(direccion) = (direccion + 2) % 4
	
	method adelante(posicionActual, direccion){
		if (direccion == self.arriba() ){
			return posicionActual.up(1)
		} else if(direccion == self.izquierda()) {
			return posicionActual.left(1)
		} else if(direccion == self.abajo()) {
			return posicionActual.down(1)
		} else {
			return posicionActual.right(1)		
		}
	}
}