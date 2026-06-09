import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';

class TournamentInfoCard extends StatelessWidget {
  const TournamentInfoCard({
    super.key,
    required this.tournament,
  });

  final TournamentModel tournament;

  @override
  Widget build(BuildContext context) {
    final leftFields = <_InfoField>[
      _InfoField(AppStrings.ageCategory, tournament.ageCat),
      _InfoField(AppStrings.genderPlain, tournament.gender),
      _InfoField(AppStrings.gameType, tournament.gameType),
      _InfoField(AppStrings.tournamentType, _getTournamentType()),
      _InfoField(AppStrings.country, tournament.country),
    ].where((field) => field.value != null && field.value!.isNotEmpty).toList();

    String? tournamentDateDisplay = tournament.startDate;
    if (tournamentDateDisplay != null &&
        tournamentDateDisplay.isNotEmpty &&
        !tournamentDateDisplay.toLowerCase().startsWith('started')) {
      tournamentDateDisplay = 'Started on $tournamentDateDisplay';
    }

    final rightFields = <_InfoField>[
      _InfoField(AppStrings.location, tournament.location),
      _InfoField(AppStrings.tournamentDate, tournamentDateDisplay),
      _InfoField(AppStrings.venue, tournament.venue),
      _InfoField(AppStrings.totalNumberOfTeams,
          tournament.teamCount > 0 ? '${tournament.teamCount}' : null),
      _InfoField(
          AppStrings.numberOfPlayerPerTeam,
          tournament.teamPlayerLimit > 0
              ? '${tournament.teamPlayerLimit}'
              : (tournament.teamPlayerLimit == 0 ? AppStrings.noLimit : null)),
    ].where((field) => field.value != null && field.value!.isNotEmpty).toList();

    return Card(
      margin: const EdgeInsets.only(top: 25, bottom: 5),
      // color: AppColors.socaGrey,
      // elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < leftFields.length; i++)
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: i == leftFields.length - 1 ? 0 : 18),
                            child: _buildInfoField(leftFields[i]),
                          ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.black26,
                    width: 32,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < rightFields.length; i++)
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: i == rightFields.length - 1 ? 0 : 18),
                            child: _buildInfoField(rightFields[i]),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _optionalSection(AppStrings.notes, tournament.notes),
            _optionalSection(AppStrings.description, tournament.description,
                isHtml: true),
            _optionalSection(AppStrings.prizes, tournament.prize),
            _optionalSection(AppStrings.registrationFees, tournament.regFee),
            _optionalSection(
                AppStrings.organizerDetails, tournament.orgDetails),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(_InfoField field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.socaBlack,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          field.value!,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.socaBlack,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _optionalSection(String title, String? content,
      {bool isHtml = false}) {
    if (content == null || content.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 1),
          isHtml
              ? _buildHtmlText(content)
              : Text(
                  content,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                    height: 1.35,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildHtmlText(String htmlContent) {
    final urlPattern = RegExp(r'https?://[^\s]+', caseSensitive: false);
    final matches = urlPattern.allMatches(htmlContent);

    if (matches.isEmpty) {
      return Text(
        htmlContent,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
          height: 1.35,
        ),
      );
    }

    final spans = <TextSpan>[];
    var lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(
            TextSpan(text: htmlContent.substring(lastMatchEnd, match.start)));
      }

      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < htmlContent.length) {
      spans.add(TextSpan(text: htmlContent.substring(lastMatchEnd)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
          height: 1.35,
        ),
        children: spans,
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String? _getTournamentType() {
    final type = tournament.tmntType ?? tournament.rule;
    if (type == null || type.isEmpty) return null;
    if (type.length > 1) {
      return type[0].toUpperCase() + type.substring(1).toLowerCase();
    }
    return type.toUpperCase();
  }
}

class _InfoField {
  const _InfoField(this.label, this.value);

  final String label;
  final String? value;
}
