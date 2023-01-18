import 'package:flutter/material.dart';
import 'package:netflix_clone_app/core/constants.dart';
import 'package:netflix_clone_app/presentation/widgets/main_card_widget.dart';
import 'package:netflix_clone_app/presentation/widgets/main_title.dart';

class MainTitleCard extends StatelessWidget {
   final String title;
  final List<String> posterList;
  const MainTitleCard({
    Key? key,
    required this.title,
    required this.posterList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: title),
        kHeight10,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: List.generate(posterList.length, (index) {
              return  MainCards(imageUrl: posterList[index]);
            }),
          ),
        ),
      ],
    );
  }
}
