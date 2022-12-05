import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      //color: Colors.red,
      margin: const EdgeInsets.only(bottom: 30),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          //NUESTRAS CARDS
          return const _CastCard();
        },
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      //color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage("assets/no-image.jpg"),
              image: NetworkImage("https://via.placeholder.com/150x300.jpg"),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "actor.name",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
