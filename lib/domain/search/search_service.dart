import 'package:dartz/dartz.dart';
import 'package:netflix_clone_app/domain/core/failures/main_failures.dart';
import 'package:netflix_clone_app/domain/search/model/search_rep/search_rep.dart';

abstract class SearchService {
  Future<Either<MainFailures, SearchRep>> searchMovies({
    required String movieQuery,
  });
}
