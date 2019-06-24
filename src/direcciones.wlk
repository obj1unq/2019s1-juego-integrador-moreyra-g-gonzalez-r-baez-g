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