/// Skill rating entry from the getMySkillSet API.
/// Fields differ from getPlayerSkills (which returns `rating`),
/// so this is a separate plain class — no code-gen needed.
class SkillRatingModel {
  final String? skillName;
  final String? skillShort;
  final double skillAvg;
  final int ratingCounter;
  final int myRating;

  const SkillRatingModel({
    this.skillName,
    this.skillShort,
    this.skillAvg = 0,
    this.ratingCounter = 0,
    this.myRating = 0,
  });

  static int _parseInt(dynamic v) =>
      v == null ? 0 : (v is num ? v.toInt() : int.tryParse(v.toString()) ?? 0);

  static double _parseDouble(dynamic v) =>
      v == null ? 0 : (v is num ? v.toDouble() : double.tryParse(v.toString()) ?? 0);

  factory SkillRatingModel.fromJson(Map<String, dynamic> json) =>
      SkillRatingModel(
        skillName: json['skillName'] as String?,
        skillShort: json['skillShort'] as String?,
        skillAvg: _parseDouble(json['skillAvg']),
        ratingCounter: _parseInt(json['ratingCounter']),
        myRating: _parseInt(json['myRating']),
      );
}
