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
		return (1..18).map({numero => new Pared(position = game.at(numero, 14), direccion = direccionRep.arriba())})
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
				new Pared(position = game.at(0, 14), direccion = 7),
				new Pared(position = game.at(19, 0), direccion = 6),
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
			return ([1, 2] + (4..13)).map({ numero => new ParedBoss(position = game.at(17, numero)) })
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
object estructuras{
	
	method puzzle1(){
		return self.generarParedes(self.paredesPuzzle1(), (5->4)) + self.generarSuelo(10, 7, [(1->1), (2->6), (4->3), (6->4)], (6->4)) + self.generarRocas(self.coordenadasPuzzle1(), (5->3))
	}
	
	method coordenadasPuzzle1() = 			   [(1->9), (2->9), (3->9), (4->9), (5->9), (6->9), (1->8), (4->8), (6->8), (3->7), (5->7),
												(7->7), (1->6), (4->6), (5->6), (7->6), (2->5), (6->5), (7->5), (1->4), (3->4), (4->4), 
												(5->4), (1->3), (3->3), (5->3), (1->2), (2->2), (3->2), (7->2), (2->1), (4->1), (5->1),
												(6->1), (7->1), (5->0)]

	method generarSuelo(alto, ancho, excepciones, base){
		return (self.generarSueloPlano(alto, ancho, base).filter{ suelo => not self.paresACoordenadas(excepciones, base).contains(suelo.position()) })
	}
	
	method paresACoordenadas(pares, base){ 
		return pares.map({ par => game.at(par.key() + base.key() - 1, par.value() + base.key() - 3) })
	}




	method generarSueloPlano(alto, ancho, base){
		return (0 .. alto - 1).map({ altura => self.generarLineaHorizontal(ancho, base, altura) }).flatten()
	}	

	method generarLineaHorizontal(ancho, base, altura){
		return (0 .. ancho - 1).map({ anchura => new SueloRoca(position = game.at(base.key() + anchura, base.value() + altura) )})
	}
	
	method generarRocas(coordenadas, base){
		return coordenadas.map({ coordenada => new Roca(position = game.at(coordenada.key() + base.key(), coordenada.value() + base.value() ))})
	}
	
	method generarParedes(listaCoordenadas, base){
		return listaCoordenadas.map({ coordenada => new ParedBoss(position = game.at(coordenada.key() + base.key(), coordenada.value() + base.value()))})
	}
	method paredesPuzzle1(){
		return ([0,1,2,3,4,6,7,8,9]).map({ altura => (0->altura)}) + 
				(0..9).map({ altura => (8->altura)})
	}
	
	method puzzleChiquito(){
		return [ new SueloRoca(position = game.at(7, 13)), new SueloRoca(position = game.at(8,13)),
				 new Roca (position = game.at(7,13))]
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
											 + [alfombra]
											 + [columna1,columna2,columna3,columna4]
											 + [nota,caja1,caja2,caja3]
											 + estructuras.puzzleChiquito()	
											 + [jugador]
											 + [columna1Top,columna2Top,columna3Top,columna4Top]
											
											 )  {	 }

object sala_2 inherits Mapa (objetosEnMapa =   [mapa_1 ] 
											 + muroCompleto.todo()
											 + [puerta_2_1] 
											 + [puerta_2_2]
//											 + spikes.spikesFila(5)		
//											 + [puerta_2_3]					   //<-
											 + estructuras.puzzle1()           //<- de poner algo más en en sala_2, eliminar o descomentar
											 + [palancaResetearPuzzle1]		   //<- las lineas marcadas y quitar de comentario la sala 4
											 + [palancaPuzzle1]				   //<- y cambiarle la sala a las palancas
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
											 + estructuras.puzzle1()
											 + [palancaResetearPuzzle1]
											 + [palancaPuzzle1]
											 + [jugador]
												) {}

