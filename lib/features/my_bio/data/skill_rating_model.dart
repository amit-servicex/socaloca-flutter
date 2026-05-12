/// Skill rating entry from the getMySkillSet API.
/// Fields differ from getPlayerSkills (which returns `rating`),
/// so this is a separate plain class — no code-gen needed.
class SkillRatingModel {
  final String? skillName;
  final String? skillShort;
  final double skillAvg;
  final int ratingCounter;

  const SkillRatingModel({
    this.skillName,
    this.skillShort,
    this.skillAvg = 0,
    this.ratingCounter = 0,
  });

  factory SkillRatingModel.fromJson(Map<String, dynamic> json) =>
      SkillRatingModel(
        skillName: json['skillName'] as String?,
        skillShort: json['skillShort'] as String?,
        skillAvg: (json['skillAvg'] as num?)?.toDouble() ?? 0,
        ratingCounter: (json['ratingCounter'] as num?)?.toInt() ?? 0,
      );
}
