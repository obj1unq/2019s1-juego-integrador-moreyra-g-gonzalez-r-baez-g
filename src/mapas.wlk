import wollok.game.*
import cosas.*

class Mapa {
	const objetosEnMapa
	
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
	
}
object muroCompleto{
	
	var posicionDelMuro = 0
	
	method arriba(){
		if (posicionDelMuro < 18){
			posicionDelMuro += 1
			return [new Pared(position = game.at(posicionDelMuro, 14))] + self.arriba()
		
		} else {
			posicionDelMuro = 0
			return [new Pared(position = game.at(18, 14))]
		}
	}
	method izquierda(){
		if (posicionDelMuro < 13){
			posicionDelMuro += 1
			return [new Pared(position = game.at(0, posicionDelMuro))] + self.izquierda()
		
		} else {
			posicionDelMuro = 0
			return [new Pared(position = game.at(0,13))]
		}
	}
	method derecha(){
		if (posicionDelMuro < 13){
			posicionDelMuro += 1
			return [new Pared(position = game.at(19, posicionDelMuro))] + self.derecha()
		
		} else {
			posicionDelMuro = 0
			return [new Pared(position = game.at(19, 13))]
		}
	}
	method abajo(){
		if (posicionDelMuro < 18){
			posicionDelMuro += 1
			return [new Pared(position = game.at(posicionDelMuro, 0))] + self.abajo()
		
		} else {
			posicionDelMuro = 0
			return [new Pared(position = game.at(18, 0))]
		}
	}
	method esquinas(){
		return [new Pared(position = game.at(0, 0)), 
				new Pared(position = game.at(0, 14)),
				new Pared(position = game.at(19, 0)),
				new Pared(position = game.at(19, 14))]
	}
}

object sala_1 inherits Mapa (objetosEnMapa =   [mapa_1 ] 
											 + muroCompleto.derecha()
											 + muroCompleto.abajo()
											 + muroCompleto.izquierda()
											 + muroCompleto.arriba() 
											 + muroCompleto.esquinas()
											 
							) {		}



