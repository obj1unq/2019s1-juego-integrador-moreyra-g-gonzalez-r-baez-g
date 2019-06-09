import wollok.game.*
import jugador.*
import mapas.*
import colisiones.*
import direcciones.*

class RondaDeAtaques {
	const property ataques = []
	method lanzarAtaque(sala){
		ataques.forEach({ataque => ataque.lanzarAtaque(sala)})
	}
}
 class Ataque{
 	var property position
 	var property image = "1.png"
 	var property tiempo
 	var property numeroDeAtaque
 	method esTraspasable()=true
 	method chocar(){}
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
		 self.image("2.png")
		 game.onTick(tiempo/2,"cambiar incendio"+numeroDeAtaque,{
		 	game.removeVisual(self)
		 	game.removeTickEvent("cambiar incendio" +numeroDeAtaque)
		 })
	}
 }