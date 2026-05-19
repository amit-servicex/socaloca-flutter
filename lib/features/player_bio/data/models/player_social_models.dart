class PlayerSocialUserModel {
  PlayerSocialUserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
    this.isPlayer = false,
    this.isCoach = false,
    this.isAdmin = false,
    this.isFan = false,
    this.followedByMe = false,
  });

  factory PlayerSocialUserModel.fromJson(Map<String, dynamic> json) {
    return PlayerSocialUserModel(
      userId: json['userId']?.toString() ?? json['_id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString(),
      isPlayer: json['isPlayer'] == true,
      isCoach: json['isCoach'] == true,
      isAdmin: json['isAdmin'] == true,
      isFan: json['isFan'] == true,
      followedByMe: json['followedByMe'] == true,
    );
  }

  final String userId;
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final bool isPlayer;
  final bool isCoach;
  final bool isAdmin;
  final bool isFan;
  final bool followedByMe;

  String get fullName => '$firstName $lastName'.trim();

  PlayerSocialUserModel copyWith({bool? followedByMe}) {
    return PlayerSocialUserModel(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      imageUrl: imageUrl,
      isPlayer: isPlayer,
      isCoach: isCoach,
      isAdmin: isAdmin,
      isFan: isFan,
      followedByMe: followedByMe ?? this.followedByMe,
    );
  }
}

class PlayerLikeModel extends PlayerSocialUserModel {
  PlayerLikeModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    super.imageUrl,
    super.isPlayer,
    super.isCoach,
    super.isAdmin,
    super.isFan,
    this.likeType = 'profile',
  });

  factory PlayerLikeModel.fromJson(Map<String, dynamic> json) {
    return PlayerLikeModel(
      userId: json['userId']?.toString() ?? json['_id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString(),
      isPlayer: json['isPlayer'] == true,
      isCoach: json['isCoach'] == true,
      isAdmin: json['isAdmin'] == true,
      isFan: json['isFan'] == true,
      likeType: json['likeType']?.toString() ?? 'profile',
    );
  }

  final String likeType;
}
