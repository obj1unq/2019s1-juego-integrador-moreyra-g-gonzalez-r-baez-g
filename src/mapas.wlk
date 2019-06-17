import wollok.game.*
import cosas.*
import jugador.*

class Mapa {
	var property objetosEnMapa
	
	method limpiarMapa() {
		objetosEnMapa.forEach( {objeto => game.removeVisual(objeto) })
	}
	
	method cargarMapa() {
		objetosEnMapa.forEach({ objeto => game.addVisual(objeto) })		
		self.activarBoss()
	}
	
	method removerObjeto(objeto){
		game.removeVisual(objeto)
		objetosEnMapa.remove(objeto)
	}	

	method activarBoss(){
		//No hace nada
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
	method id() = 5
}
object mapa_3{
	method position() = game.at(0, 0)
	method image() = "mapa3.png"
	method id() = 5
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
object muroBoss{
		 method todo(){
		 	return self.defensaBoss()+self.parteIzquierdaMapa()+self.parteDerechaMapa()+self.parteArribaMapa()
		 	}
		 method defensaBoss(){
			return [1,2,4,5,6,7,8,9,10,11,12,13].map({ numero => new ParedBoss(position = game.at(17, numero)) })
					}
		method parteIzquierdaMapa(){
			return (1 .. 14).map({numero => new BushBoss(position = game.at(0, numero),perspectiva = 2)})
		}
		method parteDerechaMapa(){
			return (1 .. 14).map({numero => new BushBoss(position = game.at(19, numero),perspectiva = 2)})
		}
		method parteArribaMapa(){
			return (0 .. 19).map({numero => new BushBoss(position = game.at(numero,14),perspectiva = 1)})
		}
		
}

object sala_1 inherits Mapa (objetosEnMapa =   [mapa_2 ] 
											 + muroCompleto.todo()
											 + [puerta_1_1]
											 + [spawn]
											 + [boton1]
											 + [boton2]
											 + [boton3]
											 + [estatua1,estatua2]
											 + [alfombra]/*Cambiar asset, muy afeminado me quedó */
											 + [columna1,columna2,columna3,columna4]
											 )  {	 }

object sala_2 inherits Mapa (objetosEnMapa =   [mapa_1 ] 
											 + muroCompleto.todo()
											 + [puerta_2_1] 
											 + [puerta_2_2])   {	}



object sala_3 inherits Mapa (objetosEnMapa =   [mapa_3 ] 
											 + muroCompleto.todo() + lagunita.aguaEnFila(15)+lagunita.aguaEnFila(16)+ muroBoss.todo()+[puerta_3_1] + [boss] + [pepita] + [jaula]
											 + [mascaraPiso]+
											 [puenteParte1,puenteParte2, puenteParte3,puenteParte4,puenteParte5,puenteParte6,puenteParte7,puenteParte8])   {
											 	override method activarBoss(){
											 		boss.atacar(self)
											 	}
											 } // ataque x = 1-16, y = 1,13, boss 3-17



