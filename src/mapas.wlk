import wollok.game.*
import cosas.*
import jugador.*
import direcciones.*

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
	

	
	method arriba(){
		return (1..18).map({numero => new Pared(position = game.at(numero, 14), direccion = direccionRep.abajo())})
	}
	method izquierda(){
		return (1..13).map({numero => new Pared(position = game.at(0, numero), direccion = direccionRep.izquierda())})
	}
	method derecha(){
			return (1..13).map({numero => new Pared(position = game.at(19, numero), direccion = direccionRep.derecha())})
	}
	method abajo(){

			return (1..18).map({numero => new Pared(position = game.at(numero, 0), direccion = direccionRep.abajo())})

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
			return (1 .. 13).map({ numero => new ParedBoss(position = game.at(17, numero)) })
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
// No funciona. CTRL SHIFT L => lista de comandos ||||| CTRL SHIFT C => comentar rápido
//object estructuras{
//	
//	method puzzle1(){
//		return self.puzzle(self.coordenadasPuzzle1(), (5-> 4), [(2->9), (6->7), (4->6), (1->4)], 13, 8, [direccionRep.izquierda(), direccionRep.derecha()], [(0->6)] )
//	}
//	
//	method puzzle(coordenadasRocas, posicionBase, excepcionesSuelo, alto, ancho, paredes, excepcionesParedes){
//		return self.generarRocas(posicionBase,  coordenadasRocas)
//			   + self.generarSueloRoca(posicionBase, excepcionesSuelo, alto, ancho)
//			   + self.generarParedes(paredes, excepcionesParedes, posicionBase, alto, ancho)
//	}
//	
//	/* posicionBase es un par */
//	method generarRocas(posicionBase, listaDeCoordenadas){
//		return listaDeCoordenadas.map({coordenada => new Roca(initial_position = game.at(coordenada.key() + posicionBase.key() ,
//																						 coordenada.value() + posicionBase.value() ))  })
//	}
//	
//	method generarSueloRoca(posicionBase, excepciones, alto, ancho){
//		return ((posicionBase.key() .. ancho).map{ x => (posicionBase.value() .. alto ).map { y => (x->y)
//				}})//.remove(excepciones).map{ coordenada => new SueloRoca(position = game.at(coordenada.key() + posicionBase.key(),
//					//																	   coordenada.value() + posicionBase.value()))}
//	}
//	
//	/*paredes recibe una lista de numeros determinados por direccionRep, excepcionesParedes recibe un par */
//	method generarParedes(paredes, excepcionesParedes, posicionBase, alto, ancho){
//		return self.generarParedesSimples(paredes, posicionBase, alto, ancho).removeAll({ pared => self.paresACoordenadas(excepcionesParedes).anyone({coordenada=> coordenada == pared.position()}) })
//	}
//	
//	method paresACoordenadas(pares){
//		return pares.map{par => game.at(par.key(), par.value())}
//	}
//	
//	method generarParedesSimples(paredes, posicionBase, alto, ancho){
//		var listaParedes = []
//			 paredes.map{ pared =>
//							if (pared == direccionRep.arriba()){
//								listaParedes + (0 .. ancho).map{ x => new Pared(direccion = direccionRep.arriba(), position = game.at(x, alto + posicionBase.value()))}
//							} else if (pared == direccionRep.abajo()){
//								listaParedes + (0 .. ancho).map{ x => new Pared(direccion = direccionRep.abajo(), position = game.at(x, 0 + posicionBase.value()))}
//							} else if (pared == direccionRep.izquierda()){
//								listaParedes + (0 .. alto).map{ y => new Pared(direccion = direccionRep.izquierda(), position = game.at(0 + posicionBase.key() , y))}
//							} else if (pared == direccionRep.derecha()){
//								listaParedes + (0 .. alto).map{ y => new Pared(direccion = direccionRep.derecha(), position = game.at(ancho + posicionBase.key() , y))}
//							}
//		
//						}
//			return listaParedes
//	}
//	
//	method coordenadasPuzzle1() = 			   [(1->9), (2->9), (3->9), (4->9), (5->9), (6->9), (1->8), (4->8), (6->8), (3->7), (5->7),
//												(7->7), (1->6), (4->6), (5->6), (7->6), (2->5), (6->5), (7->5), (1->4), (3->4), (4->4), 
//												(5->4), (1->3), (3->3), (5->3), (1->2), (2->2), (3->2), (7->2), (2->1), (4->1), (5->1),
//												(6->1), (7->1), (5->0)]
//}

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
											 + [nota,caja1,caja2,caja3]
											 + [jugador]
											 + [columna1Top,columna2Top,columna3Top,columna4Top]
											
											 )  {	 }

object sala_2 inherits Mapa (objetosEnMapa =   [mapa_1 ] 
											 + muroCompleto.todo()
											 + [puerta_2_1] 
											 + [puerta_2_2]
											 + [puerta_2_3]
											 + spikes.spikesFila(5)											
											 + [jugador])   {	}



object sala_3 inherits Mapa (objetosEnMapa =   [mapa_3 ] 
											 + muroCompleto.todo() + lagunita.aguaEnFila(15)+lagunita.aguaEnFila(16)+ muroBoss.todo()+[puerta_3_1] + [boss] + [pepita] + [jaula]
											 + [mascaraPiso]+
											 [puenteParte1,puenteParte2,puenteParte2_2, puenteParte3]
											 + [jugador])   {
											 	override method activarBoss(){
											 		boss.atacar(self)
											 		pepita.pedirAyuda()
											 	}
											 } // ataque x = 1-16, y = 1,13, boss 3-17

object sala_4 inherits Mapa (objetosEnMapa =   [mapa_1 ] 
											 + muroCompleto.todo()
											 + [puerta_4_1]
											 + [jugador]
												) {}

