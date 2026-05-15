import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_training_status_model.freezed.dart';
part 'match_training_status_model.g.dart';

int? _toInt(dynamic v) =>
    v == null ? null : (v is num ? v.toInt() : int.tryParse(v.toString()));

double? _toDouble(dynamic v) =>
    v == null ? null : (v is num ? v.toDouble() : double.tryParse(v.toString()));

Map<String, dynamic> _sanitize(Map<String, dynamic> json) => {
      ...json,
      'matches': _toInt(json['matches']),
      'mins': _toInt(json['mins']),
      'goals': _toInt(json['goals']),
      'assists': _toInt(json['assists']),
      'rating': _toDouble(json['rating']),
      'year': _toInt(json['year']),
      'cleanSheetCount': _toInt(json['cleanSheetCount']),
      'sessions': _toInt(json['sessions']),
      'month': _toInt(json['month']),
    };

/// Model for match and training status from getMiniActivity API
@freezed
class MatchTrainingStatusModel with _$MatchTrainingStatusModel {
  const factory MatchTrainingStatusModel({
    @JsonKey(name: 'matches') int? matches,
    @JsonKey(name: 'mins') int? mins,
    @JsonKey(name: 'goals') int? goals,
    @JsonKey(name: 'assists') int? assists,
    @JsonKey(name: 'rating') double? rating,
    @JsonKey(name: 'year') int? year,
    @JsonKey(name: 'cleanSheetCount') int? cleanSheetCount,
    @JsonKey(name: 'sessions') int? sessions, // for training
    @JsonKey(name: 'month') int? month, // for training
  }) = _MatchTrainingStatusModel;

  factory MatchTrainingStatusModel.fromJson(Map<String, dynamic> json) =>
      _$MatchTrainingStatusModelFromJson(_sanitize(json));
}
