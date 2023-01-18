

import 'package:dartz/dartz.dart';
import 'package:netflix_clone_app/domain/core/failures/main_failures.dart';
import 'package:netflix_clone_app/domain/hot_and_new_response/model/hot_and_new_response.dart';

abstract class HotAndNewServices{

  Future<Either<MainFailures,HotAndNewResponse>> getHotAndNewMovieData();
   Future<Either<MainFailures,HotAndNewResponse>> getHotAndNewTvData();
}