import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';

/// Tournament Info Card Widget
/// Displays comprehensive tournament information in a card layout
/// Matches Android TournamentDetailsFragment info card
class TournamentInfoCard extends StatelessWidget {
  final TournamentModel tournament;

  TournamentInfoCard({
    super.key,
    required this.tournament,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.socaBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.socaYellow,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Tournament Information'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaYellow,
                  ),
                ),
              ],
            ),
          ),

          // Info Grid
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoRow('Age Category', tournament.ageCat ?? 'N/A'),
                _buildDivider(),
                _buildInfoRow('Gender', tournament.gender ?? 'N/A'),
                _buildDivider(),
                _buildInfoRow('Game Type', tournament.gameType ?? 'N/A'),
                _buildDivider(),
                _buildInfoRow('Tournament Type', _getTournamentType()),
                _buildDivider(),
                _buildInfoRow('Country', tournament.country ?? 'N/A'),
                _buildDivider(),
                _buildInfoRow('Location / Place', tournament.location ?? 'N/A'),
                _buildDivider(),
                _buildInfoRow('Tournament Date', tournament.startDate ?? 'N/A'),
                _buildDivider(),
                _buildInfoRow('Venue', tournament.venue ?? 'N/A'),
                _buildDivider(),
                _buildInfoRow('Total Teams', '${tournament.teamCount}'),
                _buildDivider(),
                _buildInfoRow(
                    'Players Per Team', '${tournament.teamPlayerLimit}'),
              ],
            ),
          ),

          // Optional sections
          if (tournament.notes != null && tournament.notes!.isNotEmpty)
            _buildOptionalSection('Notes', tournament.notes!),

          if (tournament.description != null &&
              tournament.description!.isNotEmpty)
            _buildOptionalSection('Description', tournament.description!,
                isHtml: true),

          if (tournament.prize != null && tournament.prize!.isNotEmpty)
            _buildOptionalSection('Prizes', tournament.prize!),

          if (tournament.regFee != null && tournament.regFee!.isNotEmpty)
            _buildOptionalSection('Registration Fees', tournament.regFee!),

          if (tournament.orgDetails != null &&
              tournament.orgDetails!.isNotEmpty)
            _buildOptionalSection('Organizer Details', tournament.orgDetails!),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[200],
    );
  }

  Widget _buildOptionalSection(String title, String content,
      {bool isHtml = false}) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 8),
          isHtml
              ? _buildHtmlText(content)
              : Text(
                  content,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildHtmlText(String htmlContent) {
    // Simple HTML link detection and rendering
    // Matches Android's Linkify behavior
    final urlPattern = RegExp(
      r'https?://[^\s]+',
      caseSensitive: false,
    );

    final matches = urlPattern.allMatches(htmlContent);

    if (matches.isEmpty) {
      return Text(
        htmlContent,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          color: Colors.grey[700],
          height: 1.5,
        ),
      );
    }

    final spans = <TextSpan>[];
    int lastMatchEnd = 0;

    for (final match in matches) {
      // Add text before the link
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: htmlContent.substring(lastMatchEnd, match.start),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ));
      }

      // Add the link
      final url = match.group(0)!;
      spans.add(TextSpan(
        text: url,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
      ));

      lastMatchEnd = match.end;
    }

    // Add remaining text
    if (lastMatchEnd < htmlContent.length) {
      spans.add(TextSpan(
        text: htmlContent.substring(lastMatchEnd),
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          color: Colors.grey[700],
        ),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _getTournamentType() {
    final type = tournament.tmntType ?? tournament.rule ?? 'N/A';
    return type.toUpperCase();
  }
}
