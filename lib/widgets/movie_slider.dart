import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Populares",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //Nos permite mostrar widgets dentro de nuestra Column como el ListView
          Expanded(
            child: ListView.builder(
              //nos permite hacer el scroll de forma horizontal
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: ((context, index) => const _MoviePoster()),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 190,
      //color: Colors.green,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              "details",
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage("assets/no-image.jpg"),
                image: NetworkImage("https://via.placeholder.com/300x340.jpg"),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Star Wars",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
