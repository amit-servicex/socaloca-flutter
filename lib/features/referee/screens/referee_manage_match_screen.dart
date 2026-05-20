import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import '../../../shared/widgets/searchable_dropdown.dart';

class RefereeManageMatchScreen extends ConsumerStatefulWidget {
  RefereeManageMatchScreen({
    super.key,
    required this.matchId,
    required this.match,
  });

  final String matchId;
  final RefereeMatchModel? match;

  @override
  ConsumerState<RefereeManageMatchScreen> createState() =>
      _RefereeManageMatchScreenState();
}

class _RefereeManageMatchScreenState
    extends ConsumerState<RefereeManageMatchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSavingScore = false;

  // Score controllers
  final _scoreACtrl = TextEditingController();
  final _scoreBCtrl = TextEditingController();
  final _extraACtrl = TextEditingController(text: '0');
  final _extraBCtrl = TextEditingController(text: '0');
  final _penaltyACtrl = TextEditingController(text: '0');
  final _penaltyBCtrl = TextEditingController(text: '0');
  bool _showExtra = false;
  bool _showPenalty = false;

  // Goals/Cards state
  final List<_GoalEntry> _goals = [];
  final List<_CardEntry> _cards = [];

  // MVP
  final _mvpACtrl = TextEditingController();
  final _mvpBCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    final m = widget.match;
    if (m != null) {
      _scoreACtrl.text = m.teamAScore ?? '0';
      _scoreBCtrl.text = m.teamBScore ?? '0';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scoreACtrl.dispose();
    _scoreBCtrl.dispose();
    _extraACtrl.dispose();
    _extraBCtrl.dispose();
    _penaltyACtrl.dispose();
    _penaltyBCtrl.dispose();
    _mvpACtrl.dispose();
    _mvpBCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveScore() async {
    final a = int.tryParse(_scoreACtrl.text) ?? 0;
    final b = int.tryParse(_scoreBCtrl.text) ?? 0;
    final eA = int.tryParse(_extraACtrl.text) ?? 0;
    final eB = int.tryParse(_extraBCtrl.text) ?? 0;
    final pA = int.tryParse(_penaltyACtrl.text) ?? 0;
    final pB = int.tryParse(_penaltyBCtrl.text) ?? 0;

    setState(() => _isSavingScore = true);
    final repo = ref.read(refereeRepositoryProvider);
    final ok = await repo.saveMatchScore(
      matchId: widget.matchId,
      tournamentId: widget.match?.tournamentId ?? '',
      teamAScore: a,
      teamBScore: b,
      penaltyScore: pA + pB,
      extraTimeScore: eA + eB,
    );
    if (!mounted) return;
    setState(() => _isSavingScore = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok ? 'Score saved successfully' : 'Failed to save score'),
      backgroundColor: ok ? AppColors.socaBlack : Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.match;
    final teamA = m?.teamA ?? 'Team A';
    final teamB = m?.teamB ?? 'Team B';
    final isCompleted = m?.matchStatus == 'completed';

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.socaBlack),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Manage Match'.tr,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.socaBlack,
          ),
        ),
      ),
      body: Column(
        children: [
          // Match header
          _MatchHeader(match: m),

          // TabBar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.socaBlack,
              unselectedLabelColor: AppColors.socaBlack.withValues(alpha: 0.4),
              indicatorColor: AppColors.socaYellow,
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
              tabs: [
                Tab(text: 'Score'),
                Tab(text: 'Goals'),
                Tab(text: 'Cards'),
                Tab(text: 'MVP'),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildScoreTab(teamA, teamB, isCompleted),
                _buildGoalsTab(teamA, teamB),
                _buildCardsTab(teamA, teamB),
                _buildMvpTab(teamA, teamB),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreTab(String teamA, String teamB, bool isCompleted) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionCard(
            title: 'Full Time Score',
            child: Row(
              children: [
                Expanded(
                  child: _scoreInput(
                    label: teamA,
                    controller: _scoreACtrl,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '–'.tr,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: AppColors.socaBlack),
                  ),
                ),
                Expanded(
                  child: _scoreInput(
                    label: teamB,
                    controller: _scoreBCtrl,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),

          // Extra time toggle
          _expandableSection(
            title: 'Extra Time',
            expanded: _showExtra,
            onTap: () => setState(() => _showExtra = !_showExtra),
            child: Row(
              children: [
                Expanded(
                    child: _scoreInput(label: teamA, controller: _extraACtrl)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('–'.tr,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack)),
                ),
                Expanded(
                    child: _scoreInput(label: teamB, controller: _extraBCtrl)),
              ],
            ),
          ),
          SizedBox(height: 12),

          // Penalty toggle
          _expandableSection(
            title: 'Penalty',
            expanded: _showPenalty,
            onTap: () => setState(() => _showPenalty = !_showPenalty),
            child: Row(
              children: [
                Expanded(
                    child:
                        _scoreInput(label: teamA, controller: _penaltyACtrl)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('–'.tr,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack)),
                ),
                Expanded(
                    child:
                        _scoreInput(label: teamB, controller: _penaltyBCtrl)),
              ],
            ),
          ),
          SizedBox(height: 20),

          AppLoader(size: 24, centered: false),
        ],
      ),
    );
  }

  Widget _buildGoalsTab(String teamA, String teamB) {
    return Column(
      children: [
        Expanded(
          child: _goals.isEmpty
              ? Center(
                  child: Text('No goals recorded'.tr,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.grey)))
              : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: _goals.length,
                  itemBuilder: (_, i) => _GoalCard(
                    goal: _goals[i],
                    onRemove: () => setState(() => _goals.removeAt(i)),
                  ),
                ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showAddGoalSheet(teamA, teamB),
              icon: Icon(Icons.add, size: 18),
              label: Text('ADD GOAL'.tr,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardsTab(String teamA, String teamB) {
    return Column(
      children: [
        Expanded(
          child: _cards.isEmpty
              ? Center(
                  child: Text('No cards recorded'.tr,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.grey)))
              : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: _cards.length,
                  itemBuilder: (_, i) => _CardEntryCard(
                    card: _cards[i],
                    onRemove: () => setState(() => _cards.removeAt(i)),
                  ),
                ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showAddCardSheet(teamA, teamB),
              icon: Icon(Icons.add, size: 18),
              label: Text('ADD CARD'.tr,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMvpTab(String teamA, String teamB) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _sectionCard(
            title: 'Man of the Match',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _labelText(teamA),
                SizedBox(height: 6),
                _textField(controller: _mvpACtrl, hint: 'Player name'),
                SizedBox(height: 14),
                _labelText(teamB),
                SizedBox(height: 6),
                _textField(controller: _mvpBCtrl, hint: 'Player name'),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveMvp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text('SAVE MVP'.tr,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveMvp() async {
    final mvpA = _mvpACtrl.text.trim();
    final mvpB = _mvpBCtrl.text.trim();
    if (mvpA.isEmpty && mvpB.isEmpty) return;
    final repo = ref.read(refereeRepositoryProvider);
    final ok = await repo.saveMatchMgmt(
      matchId: widget.matchId,
      tournamentId: widget.match?.tournamentId ?? '',
      data: {'mvpA': mvpA, 'mvpB': mvpB},
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok ? 'MVP saved' : 'Failed to save MVP'),
      backgroundColor: ok ? AppColors.socaBlack : Colors.red,
    ));
  }

  void _showAddGoalSheet(String teamA, String teamB) {
    final playerCtrl = TextEditingController();
    final minuteCtrl = TextEditingController();
    String selectedTeam = teamA;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Goal'.tr,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
              SizedBox(height: 16),
              Text('Team'.tr,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
              SizedBox(height: 6),
              _teamDropdown(
                value: selectedTeam,
                teamA: teamA,
                teamB: teamB,
                onChanged: (v) =>
                    setSheetState(() => selectedTeam = v ?? teamA),
              ),
              SizedBox(height: 12),
              Text('Player Name'.tr,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
              SizedBox(height: 6),
              TextField(
                  controller: playerCtrl,
                  decoration: _inputDecoration(hint: 'e.g. John Doe')),
              SizedBox(height: 12),
              Text('Minute'.tr,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
              SizedBox(height: 6),
              TextField(
                controller: minuteCtrl,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(hint: "e.g. 45'"),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final player = playerCtrl.text.trim();
                    if (player.isEmpty) return;
                    setState(() => _goals.add(_GoalEntry(
                          team: selectedTeam,
                          player: player,
                          minute: minuteCtrl.text.trim(),
                        )));
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    foregroundColor: AppColors.socaYellow,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text('ADD'.tr,
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddCardSheet(String teamA, String teamB) {
    final playerCtrl = TextEditingController();
    final minuteCtrl = TextEditingController();
    String selectedTeam = teamA;
    String cardType = 'yellow';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Card'.tr,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
              SizedBox(height: 16),
              Text('Card Type'.tr,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
              SizedBox(height: 6),
              Row(children: [
                _cardTypeChip('Yellow', 'yellow', cardType,
                    (v) => setSheetState(() => cardType = v), Colors.amber),
                SizedBox(width: 10),
                _cardTypeChip('Red', 'red', cardType,
                    (v) => setSheetState(() => cardType = v), Colors.red),
              ]),
              SizedBox(height: 12),
              Text('Team'.tr,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
              SizedBox(height: 6),
              _teamDropdown(
                value: selectedTeam,
                teamA: teamA,
                teamB: teamB,
                onChanged: (v) =>
                    setSheetState(() => selectedTeam = v ?? teamA),
              ),
              SizedBox(height: 12),
              Text('Player Name'.tr,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
              SizedBox(height: 6),
              TextField(
                  controller: playerCtrl,
                  decoration: _inputDecoration(hint: 'e.g. John Doe')),
              SizedBox(height: 12),
              Text('Minute'.tr,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
              SizedBox(height: 6),
              TextField(
                controller: minuteCtrl,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(hint: "e.g. 55'"),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final player = playerCtrl.text.trim();
                    if (player.isEmpty) return;
                    setState(() => _cards.add(_CardEntry(
                          team: selectedTeam,
                          player: player,
                          minute: minuteCtrl.text.trim(),
                          type: cardType,
                        )));
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    foregroundColor: AppColors.socaYellow,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text('ADD'.tr,
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────────

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.socaBlack)),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _expandableSection({
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Text(title,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.socaBlack)),
                  Spacer(),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.socaBlack,
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: child,
            ),
        ],
      ),
    );
  }

  Widget _scoreInput(
      {required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: 'Lato', fontSize: 11, color: Colors.grey)),
        SizedBox(height: 6),
        SizedBox(
          width: 60,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: AppColors.socaBlack),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Color(0xFFE0E0E0))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Color(0xFFE0E0E0))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      BorderSide(color: AppColors.socaBlack, width: 1.5)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField({required TextEditingController controller, String? hint}) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(hint: hint),
      style: TextStyle(fontFamily: 'Lato', fontSize: 14),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          TextStyle(fontFamily: 'Poppins', fontSize: 13, color: Colors.grey),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFFE0E0E0))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFFE0E0E0))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: AppColors.socaBlack, width: 1.5)),
    );
  }

  Widget _teamDropdown({
    required String value,
    required String teamA,
    required String teamB,
    required ValueChanged<String?> onChanged,
  }) {
    return SearchableDropdownButton(
      hint: value,
      value: value,
      items: [teamA, teamB],
      onChanged: onChanged,
      fontSize: 13,
    );
  }

  Widget _labelText(String text) => Text(text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: AppColors.socaBlack));

  Widget _cardTypeChip(String label, String value, String current,
      ValueChanged<String> onTap, Color color) {
    final selected = value == current;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Text(label,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: selected ? Colors.white : color)),
      ),
    );
  }
}

// ─── Match header ─────────────────────────────────────────────────────────────

class _MatchHeader extends StatelessWidget {
  _MatchHeader({required this.match});
  final RefereeMatchModel? match;

  @override
  Widget build(BuildContext context) {
    if (match == null) return SizedBox.shrink();
    final isLive = match!.matchStatus == 'live';
    final isCompleted = match!.matchStatus == 'completed';
    final hasScore = match!.teamAScore != null && match!.teamBScore != null;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          if (match!.tournamentName != null)
            Text(
              '${match!.tournamentName}${match!.roundName != null ? ' — ${match!.roundName}' : ''}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Poppins', fontSize: 12, color: Colors.grey),
            ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(match!.teamA ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColors.socaBlack)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isLive ? Colors.red : AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  (isLive || isCompleted) && hasScore
                      ? '${match!.teamAScore} - ${match!.teamBScore}'
                      : 'vs',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: isLive ? Colors.white : AppColors.socaYellow),
                ),
              ),
              Expanded(
                child: Text(match!.teamB ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColors.socaBlack)),
              ),
            ],
          ),
          if (match!.matchDate != null || match!.venue != null) ...[
            SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              children: [
                if (match!.matchDate != null)
                  _chip(Icons.calendar_today, match!.matchDate!),
                if (match!.matchTime != null)
                  _chip(Icons.access_time, match!.matchTime!),
                if (match!.venue != null)
                  _chip(Icons.location_on, match!.venue!),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _chip(IconData icon, String text) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: Colors.grey),
          SizedBox(width: 3),
          Text(text,
              style: TextStyle(
                  fontFamily: 'Lato', fontSize: 11, color: Colors.grey)),
        ],
      );
}

// ─── Data classes ─────────────────────────────────────────────────────────────

class _GoalEntry {
  final String team;
  final String player;
  final String minute;
  _GoalEntry({required this.team, required this.player, required this.minute});
}

class _CardEntry {
  final String team;
  final String player;
  final String minute;
  final String type; // 'yellow' | 'red'
  _CardEntry(
      {required this.team,
      required this.player,
      required this.minute,
      required this.type});
}

class _GoalCard extends StatelessWidget {
  _GoalCard({required this.goal, required this.onRemove});
  final _GoalEntry goal;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Row(children: [
        Text('⚽'.tr, style: TextStyle(fontSize: 18)),
        SizedBox(width: 10),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(goal.player,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.socaBlack)),
            Text(
                '${goal.team}${goal.minute.isNotEmpty ? "  ${goal.minute}'" : ""}',
                style: TextStyle(
                    fontFamily: 'Lato', fontSize: 12, color: Colors.grey)),
          ]),
        ),
        IconButton(
          icon: Icon(Icons.close, size: 18, color: Colors.grey),
          onPressed: onRemove,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ]),
    );
  }
}

class _CardEntryCard extends StatelessWidget {
  _CardEntryCard({required this.card, required this.onRemove});
  final _CardEntry card;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final isYellow = card.type == 'yellow';
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Row(children: [
        Container(
          width: 14,
          height: 20,
          decoration: BoxDecoration(
            color: isYellow ? Colors.amber : Colors.red,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(card.player,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.socaBlack)),
            Text(
                '${card.team}${card.minute.isNotEmpty ? "  ${card.minute}'" : ""}',
                style: TextStyle(
                    fontFamily: 'Lato', fontSize: 12, color: Colors.grey)),
          ]),
        ),
        IconButton(
          icon: Icon(Icons.close, size: 18, color: Colors.grey),
          onPressed: onRemove,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ]),
    );
  }
}
