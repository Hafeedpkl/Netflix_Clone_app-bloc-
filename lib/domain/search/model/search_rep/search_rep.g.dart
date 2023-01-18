// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_rep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRep _$SearchRepFromJson(Map<String, dynamic> json) => SearchRep(
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => SearchResultData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SearchRepToJson(SearchRep instance) => <String, dynamic>{
      'results': instance.results,
    };

SearchResultData _$SearchResultDataFromJson(Map<String, dynamic> json) =>
    SearchResultData(
      originalTitle: json['original_title'] as String?,
      posterPath: json['poster_path'] as String?,
    );

Map<String, dynamic> _$SearchResultDataToJson(SearchResultData instance) =>
    <String, dynamic>{
      'original_title': instance.originalTitle,
      'poster_path': instance.posterPath,
    };
