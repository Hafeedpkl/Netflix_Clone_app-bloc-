import 'package:flutter/material.dart';
import 'package:netflix_clone_app/core/constants.dart';

class MainCards extends StatelessWidget {
   final String imageUrl;
  const MainCards({
    Key? key, required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 130,
        height: 200,
        decoration: BoxDecoration(
          image:  DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              imageUrl,
            ),
          ),
          borderRadius: kRadius,
        ),
      ),
    );
  }
}
