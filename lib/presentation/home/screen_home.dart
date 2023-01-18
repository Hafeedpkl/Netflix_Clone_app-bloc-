import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone_app/application/home/home_bloc.dart';
import 'package:netflix_clone_app/core/colors/colors.dart';
import 'package:netflix_clone_app/core/constants.dart';
import 'package:netflix_clone_app/presentation/home/widgets/backgroud_card.dart';
import 'package:netflix_clone_app/presentation/home/widgets/number_title_card.dart';
import 'package:netflix_clone_app/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: SafeArea(
            child: ValueListenableBuilder(
      valueListenable: scrollNotifier,
      builder: (context, value, child) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            if (direction == ScrollDirection.reverse) {
              scrollNotifier.value = false;
            } else if (direction == ScrollDirection.forward) {
              scrollNotifier.value = true;
            }
            return true;
          },
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  } else if (state.hasError) {
                    return const Center(
                      child: Text(
                        'Error while getting data',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    );
                  }
                  // released past year
                  final _releasedPastYear = state.pastYearMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  _releasedPastYear.shuffle();

                  // trending
                  final _trending = state.trendingMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  _trending.shuffle();
                  // tense dramas
                  final _tenseDramas = state.tenseDramaMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  // south indian movies
                  _tenseDramas.shuffle();
                  final _southIndianMovies =
                      state.southIndianMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  _southIndianMovies.shuffle();

                  //top 10 tv shows

                  final _top10TvShows = state.southIndianMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  _top10TvShows.shuffle();

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BackgroundCard(),
                        kHeight10,
                        if (_releasedPastYear.length >= 10)
                          MainTitleCard(
                            title: 'Released in the past year',
                            posterList: _releasedPastYear.sublist(0, 10),
                          ),
                        kHeight10,
                        if (_trending.length >= 10)
                          MainTitleCard(
                            title: 'Trending Now',
                            posterList: _trending.sublist(0, 10),
                          ),
                        kHeight10,
                        NumberTitleCard(
                          posterList: _top10TvShows,
                        ),
                        kHeight10,
                        if (_tenseDramas.length >= 10)
                          MainTitleCard(
                            title: 'Tense Dramas',
                            posterList: _tenseDramas.sublist(0, 10),
                          ),
                        kHeight10,
                        if (_southIndianMovies.length >= 10)
                          MainTitleCard(
                            title: 'South Indian Cinema',
                            posterList: _southIndianMovies.sublist(0, 10),
                          ),
                        kHeight10,
                      ],
                    ),
                  );
                },
              ),
              scrollNotifier.value == true
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 2000),
                      width: double.infinity,
                      height: 90,
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image(
                                    image: NetworkImage(
                                        'https://pngimg.com/uploads/netflix/netflix_PNG10.png'),
                                  )),
                              Spacer(),
                              Icon(
                                Icons.cast,
                                color: kWhiteColor,
                                size: 30,
                              ),
                              kWidth10,
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Image(
                                  image: NetworkImage(
                                      'https://i.pinimg.com/originals/0d/dc/ca/0ddccae723d85a703b798a5e682c23c1.png'),
                                ),
                              ),
                              kWidth10,
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text('TV Shows', style: kHomeTitleText),
                              Text('Movies', style: kHomeTitleText),
                              Text('Categories', style: kHomeTitleText),
                            ],
                          ),
                        ],
                      ),
                    )
                  : kHeight10,
            ],
          ),
        );
      },
    )));
  }
}
