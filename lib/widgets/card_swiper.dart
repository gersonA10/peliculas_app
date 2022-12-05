import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //para manejar el ancho y alto de nuestra pantalla nos creamos
    //nuestro [size] para maneajarlo de una mejor manera
    final size = MediaQuery.of(context).size;

    return SizedBox(
      //color: Colors.red,
      width: double.infinity,
      //Indicamos que vamos a tomar el 50% de nuestra pantalla
      height: size.height * 0.5,
      //Utilizamos nuestro Widget con el paquete que acabamos de importar
      child: Swiper(
        //el layout nos indica de que manera mostraremos nuestro swiper
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: size.height * 0.45,
        itemCount: 20,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (() => Navigator.pushNamed(context, "details",
                arguments: "movie-instance")),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage("assets/no-image.jpg"),
                image: NetworkImage("https://via.placeholder.com/300x400.jpg"),
              ),
            ),
          );
        },
      ),
    );
  }
}
