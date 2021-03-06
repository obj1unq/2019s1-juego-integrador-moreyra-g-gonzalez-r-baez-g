import wollok.game.*
import personajes.*
import mapas.*
import colisiones.*
import direcciones.*

class RondaDeAtaques {
	const property ataques = []
	method lanzarAtaque(sala){
		ataques.forEach({ataque => if (jugador.estaVivo())
										{ataque.lanzarAtaque(sala)}
		})
	}
}
 class Ataque{
 	var property position
 	var property image = "alerta.png"
 	var property tiempo
 	var property numeroDeAtaque
 	method esTraspasable()=true
 	method chocar(){
 		if(image=="ataque.png"){
 			jugador.muerto()
 		}
 	}
 	method lanzarAtaque(sala){
 		if(sala == sala_3){
 			game.addVisual(self)

 			game.onTick(tiempo,"incendio"+numeroDeAtaque,{
 				self.cambiarAFuego()
 				game.removeTickEvent("incendio"+numeroDeAtaque)
 			})
 		}
 	}
 	method cambiarAFuego(){
		 self.image("ataque.png")
		 game.onTick(tiempo/2,"cambiar incendio"+numeroDeAtaque,{
		 	game.removeVisual(self)
		 	game.removeTickEvent("cambiar incendio" +numeroDeAtaque)
		 })
	}
	method serGolpeado(){}	
	method tenerInteraccion(){/* No hace nada */}	
 }