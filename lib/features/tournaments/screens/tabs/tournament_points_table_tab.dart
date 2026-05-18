import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../data/tournament_models.dart';
import '../../data/tournament_repository.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Points table tab — mirrors Android TournamentsPointTableFragment
class TournamentPointsTableTab extends ConsumerStatefulWidget {
  TournamentPointsTableTab({super.key, required this.tournamentId});
  final String tournamentId;

  @override
  ConsumerState<TournamentPointsTableTab> createState() =>
      _TournamentPointsTableTabState();
}

class _TournamentPointsTableTabState
    extends ConsumerState<TournamentPointsTableTab>
    with AutomaticKeepAliveClientMixin {
  List<PointsTableEntry> _table = [];
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final data = await ref.read(tournamentRepositoryProvider).getPointsTable(
          userId: user.id,
          tournamentId: widget.tournamentId,
        );

    // Sort by seq (same as Android)
    data.sort((a, b) {
      if (a.seq != b.seq) return a.seq.compareTo(b.seq);
      return (a.teamName ?? '').compareTo(b.teamName ?? '');
    });

    if (mounted) {
      setState(() {
        _table = data;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_loading) {
      return AppLoader();
    }

    if (_table.isEmpty) {
      return Center(
        child: Text(
          'No points table available'.tr,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: AppColors.socaBlack.withOpacity(0.4),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _loading = true);
        await _load();
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              _TableHeader(),
              Divider(height: 1, color: AppColors.socaGrey),
              // Data rows
              ..._table.asMap().entries.map((entry) {
                final index = entry.key;
                final row = entry.value;
                return Column(
                  children: [
                    _TableRow(entry: row, position: index + 1),
                    Divider(height: 1, color: AppColors.socaGrey),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.socaBlack,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        children: [
          SizedBox(width: 28, child: _HeaderCell(text: 'Pos')),
          SizedBox(width: 36),
          SizedBox(width: 120, child: _HeaderCell(text: 'Team')),
          SizedBox(width: 32, child: _HeaderCell(text: 'P')),
          SizedBox(width: 32, child: _HeaderCell(text: 'W')),
          SizedBox(width: 32, child: _HeaderCell(text: 'D')),
          SizedBox(width: 32, child: _HeaderCell(text: 'L')),
          SizedBox(width: 36, child: _HeaderCell(text: 'GF')),
          SizedBox(width: 36, child: _HeaderCell(text: 'GA')),
          SizedBox(width: 36, child: _HeaderCell(text: 'GD')),
          SizedBox(width: 36, child: _HeaderCell(text: 'Pts')),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  _HeaderCell({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 12,
        color: AppColors.socaYellow,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _TableRow extends StatelessWidget {
  _TableRow({required this.entry, required this.position});
  final PointsTableEntry entry;
  final int position;

  @override
  Widget build(BuildContext context) {
    final logoUrl = ApiConstants.getImageUrl(entry.teamLogo);

    return Container(
      color:
          position.isEven ? AppColors.socaGrey.withOpacity(0.3) : Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          // Position
          SizedBox(
            width: 28,
            child: Text(
              '$position',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Team logo
          SizedBox(
            width: 36,
            child: Center(
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.socaGrey,
                ),
                child: ClipOval(
                  child: logoUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: logoUrl,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => Icon(
                            Icons.shield,
                            size: 14,
                            color: AppColors.socaBlack,
                          ),
                        )
                      : Icon(Icons.shield,
                          size: 14, color: AppColors.socaBlack),
                ),
              ),
            ),
          ),
          // Team name
          SizedBox(
            width: 120,
            child: Text(
              entry.teamName ?? '',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _DataCell(value: entry.played),
          _DataCell(value: entry.won),
          _DataCell(value: entry.drawn),
          _DataCell(value: entry.lost),
          _DataCell(value: entry.goalsFor, width: 36),
          _DataCell(value: entry.goalsAgainst, width: 36),
          _DataCell(value: entry.goalDifference, width: 36),
          _DataCell(value: entry.points, width: 36, bold: true),
        ],
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  _DataCell({required this.value, this.width = 32, this.bold = false});
  final int value;
  final double width;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        '$value',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          fontSize: 12,
          color: AppColors.socaBlack,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
