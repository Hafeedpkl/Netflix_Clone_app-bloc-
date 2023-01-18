import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone_app/domain/core/failures/main_failures.dart';
import 'package:netflix_clone_app/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_clone_app/domain/downloads/models/downloads.dart';
import 'package:netflix_clone_app/domain/search/model/search_rep/search_rep.dart';
import 'package:netflix_clone_app/domain/search/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadService;
  final SearchService _searchService;
  SearchBloc(this._downloadService, this._searchService)
      : super(SearchState.initial()) {
//idle state
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
          searchResultList: [],
          idleList: state.idleList,
          isLoading: false,
          isError: false,
        ));
        return;
      }

      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      //get trending
      final uresult = await _downloadService.getDownloadsImages();
      final ustate = uresult.fold(
        (MainFailures f) {
          return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true,
          );
        },
        (List<Downloads> list) {
          return SearchState(
            searchResultList: [],
            idleList: list,
            isLoading: false,
            isError: false,
          );
        },
      );
      //show to ui
      emit(ustate);
    });

//search result state
    on<SearchMovie>((event, emit) async {
      //call search movie api
      log("Searching for ${event.movieQuery}");
      final uresult =
          await _searchService.searchMovies(movieQuery: event.movieQuery);
      final ustate = uresult.fold(
        (MainFailures l) {
          return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true,
          );
        },
        (SearchRep r) {
          return SearchState(
            searchResultList: r.results!,
            idleList: [],
            isLoading: false,
            isError: false,
          );
        },
      );
      //show to ui
      emit(ustate);
    });
  }
}
