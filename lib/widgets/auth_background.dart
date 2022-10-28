import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  
  final Widget child;

  const AuthBackground({super.key, required this.child});//Voy a esperar un widget 


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        //Es una columna que apila widgets uno encima del otro
        children: [
          const _PurpleBox(),
          
          const HeatherIcon(),

          child,//Hijo pasado desde login_screen
        ],
      ),
    );
  }
}

class HeatherIcon extends StatelessWidget {
  const HeatherIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(//añade un area segura en caso de que el telefono venga con algo raro en la pantalla
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top:30),
        child: const Icon(Icons.person_pin , color: Colors.white, size: 100),
      ),
    );
  }
}

//Widget de la caja purpura
class _PurpleBox extends StatelessWidget {
  const _PurpleBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //obtengo el tamaño total de la pantalla en una variable

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children:const  [
          Positioned(top: 90, left: 30, child: _Bubble()),
          Positioned(top: -40, left: -30, child: _Bubble()),
          Positioned(top: -50, right: -20, child: _Bubble()),
          Positioned(bottom: -50, left: 10, child: _Bubble()),
          Positioned(bottom: 120, right: 20, child: _Bubble()),
          
        ],
      ),
    );
  }
//Color de fondo del widget en una clase tipo Box decoration 
  BoxDecoration _purpleBackground() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1)
          ]
        )
    );
}

//Widget de la burbuja
class _Bubble extends StatelessWidget {
  const _Bubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromARGB(11, 255, 255, 255)
      ),
    );
  }
}
