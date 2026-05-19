// Plain Dart models for Academy Bio screen (no Freezed to avoid build_runner)

class AcademyBioData {
  final String? joinedStatus; // "PENDING" | "ACCEPTED" | "CANCEL" | null
  final AcademyDetailModel? academyDetails;
  final List<AcademyBannerModel> banners;
  final AcademyTrialStatusModel? trialDetails;
  final List<AcademyNewsModel> newsList;
  final List<AcademyPostModel> postList;
  final List<AcademySponsorModel> sponsorList;
  final List<AcademyTeamModel> teams;
  final List<AcademyPostModel> skillVdos;
  final List<AcademyPostModel> matchVdos;

  const AcademyBioData({
    this.joinedStatus,
    this.academyDetails,
    this.banners = const [],
    this.trialDetails,
    this.newsList = const [],
    this.postList = const [],
    this.sponsorList = const [],
    this.teams = const [],
    this.skillVdos = const [],
    this.matchVdos = const [],
  });
}

class AcademyDetailModel {
  final String? academyId;
  final String? name;
  final String? imageUrl;
  final String? country;
  final String? city;
  final String? category;
  final String? formedYear;
  final String? headOfAcademy;
  final String? director;
  final String? manager;
  final String? mobile;
  final String? email;
  final String? about;
  final String? website;
  final bool following;
  final int followCount;

  const AcademyDetailModel({
    this.academyId,
    this.name,
    this.imageUrl,
    this.country,
    this.city,
    this.category,
    this.formedYear,
    this.headOfAcademy,
    this.director,
    this.manager,
    this.mobile,
    this.email,
    this.about,
    this.website,
    this.following = false,
    this.followCount = 0,
  });

  factory AcademyDetailModel.fromJson(Map<String, dynamic> json) {
    return AcademyDetailModel(
      academyId: json['academyId'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      category: json['category'] as String?,
      formedYear: json['formedYear'] as String?,
      headOfAcademy: json['headOfAcademy'] as String?,
      director: json['director'] as String?,
      manager: json['manager'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      about: json['about'] as String?,
      website: json['website'] as String?,
      following: json['following'] == true,
      followCount: (json['followCount'] as num?)?.toInt() ?? 0,
    );
  }
}

class AcademyBannerModel {
  final int seq;
  final String imageUrl;

  const AcademyBannerModel({required this.seq, required this.imageUrl});

  factory AcademyBannerModel.fromJson(Map<String, dynamic> json) {
    return AcademyBannerModel(
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}

class AcademyTrialStatusModel {
  final bool trialBadge;
  final bool canRegister;
  final bool registered;

  const AcademyTrialStatusModel({
    this.trialBadge = false,
    this.canRegister = false,
    this.registered = false,
  });

  factory AcademyTrialStatusModel.fromJson(Map<String, dynamic> json) {
    return AcademyTrialStatusModel(
      trialBadge: json['trialBadge'] == true,
      canRegister: json['canRegister'] == true,
      registered: json['registered'] == true,
    );
  }
}

class AcademyNewsModel {
  final String? newsId;
  final String? title;
  final String? description;
  final String? newsDate;
  final String? imageUrl;
  final int likeCount;
  final int commentCount;
  final bool myLike;

  const AcademyNewsModel({
    this.newsId,
    this.title,
    this.description,
    this.newsDate,
    this.imageUrl,
    this.likeCount = 0,
    this.commentCount = 0,
    this.myLike = false,
  });

  factory AcademyNewsModel.fromJson(Map<String, dynamic> json) {
    return AcademyNewsModel(
      newsId: json['newsId'] as String? ?? json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      newsDate: json['newsDate'] as String?,
      imageUrl: json['imageUrl'] as String?,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      myLike: json['myLike'] == true,
    );
  }
}

class AcademyVideoTagModel {
  final String? skillShort;
  final String? skillName;

  const AcademyVideoTagModel({this.skillShort, this.skillName});

  factory AcademyVideoTagModel.fromJson(Map<String, dynamic> json) {
    return AcademyVideoTagModel(
      skillShort: json['skillShort'] as String?,
      skillName: json['skillName'] as String?,
    );
  }
}

class AcademyPostModel {
  final String? postId;
  final String? academyId;
  final String? videoType;
  final String? title;
  final String? videoId;
  final String? description;
  final String? imageUrl;
  final String? thumbnail;
  final String? videoUrl;
  final String? postType;
  final int likeCount;
  final int commentCount;
  final bool myLike;
  final int addedOn;
  final int size;
  final List<Map<String, dynamic>> files;
  final List<AcademyVideoTagModel> tags;

  const AcademyPostModel({
    this.postId,
    this.academyId,
    this.videoType,
    this.title,
    this.videoId,
    this.description,
    this.imageUrl,
    this.thumbnail,
    this.videoUrl,
    this.postType,
    this.likeCount = 0,
    this.commentCount = 0,
    this.myLike = false,
    this.addedOn = 0,
    this.size = 0,
    this.files = const [],
    this.tags = const [],
  });

  factory AcademyPostModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> files = [];
    if (json['sources'] != null) {
      final sources = json['sources'] as List;
      files = sources.map((s) => Map<String, dynamic>.from(s as Map)).toList();
    }
    List<AcademyVideoTagModel> tags = [];
    if (json['tags'] != null) {
      final tagsList = json['tags'] as List;
      tags = tagsList
          .map((t) => AcademyVideoTagModel.fromJson(t as Map<String, dynamic>))
          .toList();
    }
    return AcademyPostModel(
      postId: json['postId'] as String? ??
          json['acaPostId'] as String? ??
          json['acaVdoPostId'] as String? ??
          json['videoId'] as String? ??
          json['_id'] as String?,
      academyId: json['academyId'] as String?,
      videoType: json['videoType'] as String?,
      title: json['title'] as String?,
      videoId: json['videoId'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      thumbnail: json['thumbnail'] as String?,
      videoUrl: json['videoUrl'] as String?,
      postType: json['postType'] as String?,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      myLike: json['myLike'] == true,
      addedOn: (json['addedOn'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 0,
      files: files,
      tags: tags,
    );
  }

  // Returns the best available preview image URL (thumbnail takes priority for videos)
  String get effectiveImageUrl {
    if (thumbnail != null && thumbnail!.isNotEmpty) return thumbnail!;
    if (imageUrl != null && imageUrl!.isNotEmpty) return imageUrl!;
    if (files.isNotEmpty) {
      final first = files.first;
      return first['url'] as String? ?? first['imageUrl'] as String? ?? '';
    }
    return '';
  }
}

class AcademySponsorModel {
  final String? sponsorId;
  final String? name;
  final String? logo;
  final int seq;
  final String? website;

  const AcademySponsorModel({
    this.sponsorId,
    this.name,
    this.logo,
    this.seq = 0,
    this.website,
  });

  factory AcademySponsorModel.fromJson(Map<String, dynamic> json) {
    return AcademySponsorModel(
      sponsorId: json['sponsorId'] as String? ?? json['_id'] as String?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      website: json['website'] as String?,
    );
  }
}

class AcademyTeamModel {
  final String? teamId;
  final String? name;
  final String? imageUrl;
  final String? country;

  const AcademyTeamModel({
    this.teamId,
    this.name,
    this.imageUrl,
    this.country,
  });

  factory AcademyTeamModel.fromJson(Map<String, dynamic> json) {
    return AcademyTeamModel(
      teamId: json['teamId'] as String? ?? json['_id'] as String?,
      name: json['name'] as String? ?? json['teamName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      country: json['country'] as String?,
    );
  }
}
