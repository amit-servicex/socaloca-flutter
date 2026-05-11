import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/partners_provider.dart';
import '../widgets/club_filter_row.dart';
import '../widgets/partner_card.dart';

// ─── Countries list (shared with clubs screen) ────────────────────────────

const List<String> _countries = [
  'Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda',
  'Argentina', 'Armenia', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain',
  'Bangladesh', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan',
  'Bolivia', 'Bosnia and Herzegovina', 'Botswana', 'Brazil', 'Brunei', 'Bulgaria',
  'Burkina Faso', 'Burundi', 'Cambodia', 'Cameroon', 'Canada', 'Cape Verde',
  'Central African Republic', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros',
  'Congo', 'Costa Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czech Republic', 'Denmark',
  'Djibouti', 'Dominica', 'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador',
  'Equatorial Guinea', 'Eritrea', 'Estonia', 'Eswatini', 'Ethiopia', 'Fiji',
  'Finland', 'France', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Greece',
  'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti', 'Honduras',
  'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel',
  'Italy', 'Ivory Coast', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya',
  'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia',
  'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Madagascar', 'Malawi',
  'Malaysia', 'Maldives', 'Mali', 'Malta', 'Mauritania', 'Mauritius', 'Mexico',
  'Moldova', 'Monaco', 'Mongolia', 'Montenegro', 'Morocco', 'Mozambique', 'Myanmar',
  'Namibia', 'Nepal', 'Netherlands', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria',
  'North Korea', 'North Macedonia', 'Norway', 'Oman', 'Pakistan', 'Palestine',
  'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Poland',
  'Portugal', 'Qatar', 'Romania', 'Russia', 'Rwanda', 'Saudi Arabia', 'Senegal',
  'Serbia', 'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Somalia',
  'South Africa', 'South Korea', 'South Sudan', 'Spain', 'Sri Lanka', 'Sudan',
  'Suriname', 'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 'Tanzania',
  'Thailand', 'Togo', 'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan',
  'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom', 'United States',
  'Uruguay', 'Uzbekistan', 'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe',
];

// ─── Shared empty / loading / error builders ──────────────────────────────

Widget _buildLoading() =>
    const Center(child: CircularProgressIndicator());

Widget _buildEmpty(String label) => Center(
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
    );

// ─── Partners landing (nested 4-tab screen) ───────────────────────────────

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        ColoredBox(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: AppColors.socaBlack,
            indicatorWeight: 3,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            tabs: const [
              Tab(text: 'FAs'),
              Tab(text: 'Confederations'),
              Tab(text: 'Sponsors'),
              Tab(text: 'Charities & NGOs'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              _FAsTab(),
              _ConfedsTab(),
              _SponsorsTab(),
              _CharitiesTab(),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// FAs Tab
// ═══════════════════════════════════════════════════════════════════════════

class _FAsTab extends ConsumerStatefulWidget {
  const _FAsTab();

  @override
  ConsumerState<_FAsTab> createState() => _FAsTabState();
}

class _FAsTabState extends ConsumerState<_FAsTab>
    with AutomaticKeepAliveClientMixin {
  final _scroll = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fasProvider.notifier).load();
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      ref.read(fasProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(fasProvider);

    if (state.isLoading && state.fas.isEmpty) return _buildLoading();
    if (state.fas.isEmpty) return _buildEmpty('No FAs found');

    return RefreshIndicator(
      onRefresh: () => ref.read(fasProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: state.fas.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.fas.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final fa = state.fas[index];
          return PartnerCard(
            name: fa.faName,
            fullImageUrl: fa.fullImageUrl,
            partnerLabel: fa.displayPartnerLabel,
            country: fa.country,
            trialBadge: fa.trialBadge,
            onView: () => context.push('/fa/${fa.faId}'),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Confederations Tab
// ═══════════════════════════════════════════════════════════════════════════

class _ConfedsTab extends ConsumerStatefulWidget {
  const _ConfedsTab();

  @override
  ConsumerState<_ConfedsTab> createState() => _ConfedsTabState();
}

class _ConfedsTabState extends ConsumerState<_ConfedsTab>
    with AutomaticKeepAliveClientMixin {
  final _scroll = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(confedsProvider.notifier).load();
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      ref.read(confedsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(confedsProvider);

    if (state.isLoading && state.confeds.isEmpty) return _buildLoading();
    if (state.confeds.isEmpty) return _buildEmpty('No confederations found');

    return RefreshIndicator(
      onRefresh: () => ref.read(confedsProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: state.confeds.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.confeds.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final confed = state.confeds[index];
          return PartnerCard(
            name: confed.confedName,
            fullImageUrl: confed.fullImageUrl,
            partnerLabel: confed.displayPartnerLabel,
            country: confed.country,
            onView: () => context.push('/confed/${confed.confedId}'),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Sponsors Tab
// ═══════════════════════════════════════════════════════════════════════════

class _SponsorsTab extends ConsumerStatefulWidget {
  const _SponsorsTab();

  @override
  ConsumerState<_SponsorsTab> createState() => _SponsorsTabState();
}

class _SponsorsTabState extends ConsumerState<_SponsorsTab>
    with AutomaticKeepAliveClientMixin {
  final _scroll = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sponsorsProvider.notifier).load();
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      ref.read(sponsorsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(sponsorsProvider);

    return Column(
      children: [
        ClubFilterRow(
          selectedCountry: state.country,
          selectedPartnership: state.partnership,
          countries: _countries,
          onCountryChanged: (v) =>
              ref.read(sponsorsProvider.notifier).setCountry(v),
          onPartnershipChanged: (v) =>
              ref.read(sponsorsProvider.notifier).setPartnership(v),
        ),
        Expanded(child: _buildList(state)),
      ],
    );
  }

  Widget _buildList(SponsorsState state) {
    if (state.isLoading && state.sponsors.isEmpty) return _buildLoading();
    if (state.sponsors.isEmpty) return _buildEmpty('No sponsors found');

    return RefreshIndicator(
      onRefresh: () => ref.read(sponsorsProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: state.sponsors.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.sponsors.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final sponsor = state.sponsors[index];
          return PartnerCard(
            name: sponsor.sponsorName,
            fullImageUrl: sponsor.fullImageUrl,
            partnerLabel: sponsor.displayPartnerLabel,
            country: sponsor.country,
            onView: () => context.push('/sponsor/${sponsor.sponsorId}'),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Charities & NGOs Tab
// ═══════════════════════════════════════════════════════════════════════════

class _CharitiesTab extends ConsumerStatefulWidget {
  const _CharitiesTab();

  @override
  ConsumerState<_CharitiesTab> createState() => _CharitiesTabState();
}

class _CharitiesTabState extends ConsumerState<_CharitiesTab>
    with AutomaticKeepAliveClientMixin {
  final _scroll = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(charitiesProvider.notifier).load();
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      ref.read(charitiesProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(charitiesProvider);

    return Column(
      children: [
        ClubFilterRow(
          selectedCountry: state.country,
          selectedPartnership: state.partnership,
          countries: _countries,
          onCountryChanged: (v) =>
              ref.read(charitiesProvider.notifier).setCountry(v),
          onPartnershipChanged: (v) =>
              ref.read(charitiesProvider.notifier).setPartnership(v),
        ),
        Expanded(child: _buildList(state)),
      ],
    );
  }

  Widget _buildList(CharitiesState state) {
    if (state.isLoading && state.charities.isEmpty) return _buildLoading();
    if (state.charities.isEmpty) return _buildEmpty('No charities & NGOs found');

    return RefreshIndicator(
      onRefresh: () => ref.read(charitiesProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: state.charities.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.charities.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final charity = state.charities[index];
          return PartnerCard(
            name: charity.charityName,
            fullImageUrl: charity.fullImageUrl,
            partnerLabel: charity.displayPartnerLabel,
            country: charity.country,
            onView: () => context.push('/charity/${charity.charityId}'),
          );
        },
      ),
    );
  }
}
