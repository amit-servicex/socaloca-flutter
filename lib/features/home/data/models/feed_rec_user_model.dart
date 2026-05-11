import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_rec_user_model.freezed.dart';
part 'feed_rec_user_model.g.dart';

/// Model for recommended users in home feed (from getFeedRecUsers API)
@freezed
class FeedRecUserModel with _$FeedRecUserModel {
  const factory FeedRecUserModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'userType') String? userType,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'isFollowing') @Default(false) bool isFollowing,
    @JsonKey(name: 'followCount') @Default(0) int followCount,
  }) = _FeedRecUserModel;

  factory FeedRecUserModel.fromJson(Map<String, dynamic> json) =>
      _$FeedRecUserModelFromJson(json);
}
