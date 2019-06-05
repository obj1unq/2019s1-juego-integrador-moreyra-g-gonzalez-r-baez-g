import wollok.game.*
import cosas.*

class Mapa {
	var property objetosEnMapa
	
	method limpiarMapa() {
		objetosEnMapa.forEach( {objeto => game.removeVisual(objeto) })
	}
	
	method cargarMapa() {
		objetosEnMapa.forEach({ objeto => game.addVisual(objeto) })		
		// Quizás haga falta un " crearColisiones() "
		// o un objetosEnMapa.foreach({ objeto => objeto.crearColisiones() })
	}
	
	
}

object mapa_1 {
	method position() = game.at(0, 0)
	method image() = "Mapa_1.png"
	method id() = 0
} 

object mapa_2{
	method position() = game.at(0, 0)
	method image() = "MakingMap1.png"
	method id() = 0
}

object muroCompleto{
	
	var posicionDelMuro = 0
	
	method arriba(){
		if (posicionDelMuro < 18){
			posicionDelMuro += 1
			return [new Pared(position = game.at(posicionDelMuro, 14), direccion = direccion.arriba())] + self.arriba()
		
		} else {
			posicionDelMuro = 0
			return [new Pared(position = game.at(18, 14), direccion = direccion.arriba())]
		}
	}
	method izquierda(){
		if (posicionDelMuro < 13){
			posicionDelMuro += 1
			return [new Pared(position = game.at(0, posicionDelMuro), direccion = direccion.izquierda())] + self.izquierda()
		
		} else {
			posicionDelMuro = 0
			return [new Pared(position = game.at(0,13), direccion = direccion.izquierda())]
		}
	}
	method derecha(){
		if (posicionDelMuro < 13){
			posicionDelMuro += 1
			return [new Pared(position = game.at(19, posicionDelMuro), direccion = direccion.derecha())] + self.derecha()
		
		} else {
			posicionDelMuro = 0
			return [new Pared(position = game.at(19, 13), direccion = direccion.derecha())]
		}
	}
	method abajo(){
		if (posicionDelMuro < 18){
			posicionDelMuro += 1
			return [new Pared(position = game.at(posicionDelMuro, 0), direccion = direccion.abajo())] + self.abajo()
		
		} else {
			posicionDelMuro = 0
			return [new Pared(position = game.at(18, 0), direccion = direccion.abajo())]
		}
	}
	method esquinas(){
		return [new Pared(position = game.at(0, 0), direccion = 5), 
				new Pared(position = game.at(0, 14), direccion = 6),
				new Pared(position = game.at(19, 0), direccion = 7),
				new Pared(position = game.at(19, 14), direccion = 8)]
	}
	
	method todo(){
		return self.derecha() + self.abajo() + self.izquierda() + self.arriba() + self.esquinas()
	}
}

object direccion{
	method arriba() = 3
	method abajo() = 1
	method izquierda() = 2
	method derecha() = 4
}

object sala_1 inherits Mapa (objetosEnMapa =   [mapa_2 ] 
											 + muroCompleto.todo()
											 + [puerta_1_1]
											 + [boton1]
											 + [caja1] )  {	 }

object sala_2 inherits Mapa (objetosEnMapa =   [mapa_1 ] 
											 + muroCompleto.todo()
											 + [puerta_2_1] )   {	}



object sala_3 inherits Mapa (objetosEnMapa =   [mapa_1 ] 
											 + muroCompleto.todo() )   {	}



