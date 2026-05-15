import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/partners_provider.dart';
import '../widgets/club_filter_row.dart';
import '../widgets/partner_card.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

// ─── Countries list (shared with clubs screen) ────────────────────────────

const List<String> _countries = [
  'Afghanistan',
  'Albania',
  'Algeria',
  'Andorra',
  'Angola',
  'Antigua and Barbuda',
  'Argentina',
  'Armenia',
  'Australia',
  'Austria',
  'Azerbaijan',
  'Bahamas',
  'Bahrain',
  'Bangladesh',
  'Barbados',
  'Belarus',
  'Belgium',
  'Belize',
  'Benin',
  'Bhutan',
  'Bolivia',
  'Bosnia and Herzegovina',
  'Botswana',
  'Brazil',
  'Brunei',
  'Bulgaria',
  'Burkina Faso',
  'Burundi',
  'Cambodia',
  'Cameroon',
  'Canada',
  'Cape Verde',
  'Central African Republic',
  'Chad',
  'Chile',
  'China',
  'Colombia',
  'Comoros',
  'Congo',
  'Costa Rica',
  'Croatia',
  'Cuba',
  'Cyprus',
  'Czech Republic',
  'Denmark',
  'Djibouti',
  'Dominica',
  'Dominican Republic',
  'Ecuador',
  'Egypt',
  'El Salvador',
  'Equatorial Guinea',
  'Eritrea',
  'Estonia',
  'Eswatini',
  'Ethiopia',
  'Fiji',
  'Finland',
  'France',
  'Gabon',
  'Gambia',
  'Georgia',
  'Germany',
  'Ghana',
  'Greece',
  'Grenada',
  'Guatemala',
  'Guinea',
  'Guinea-Bissau',
  'Guyana',
  'Haiti',
  'Honduras',
  'Hungary',
  'Iceland',
  'India',
  'Indonesia',
  'Iran',
  'Iraq',
  'Ireland',
  'Israel',
  'Italy',
  'Ivory Coast',
  'Jamaica',
  'Japan',
  'Jordan',
  'Kazakhstan',
  'Kenya',
  'Kuwait',
  'Kyrgyzstan',
  'Laos',
  'Latvia',
  'Lebanon',
  'Lesotho',
  'Liberia',
  'Libya',
  'Liechtenstein',
  'Lithuania',
  'Luxembourg',
  'Madagascar',
  'Malawi',
  'Malaysia',
  'Maldives',
  'Mali',
  'Malta',
  'Mauritania',
  'Mauritius',
  'Mexico',
  'Moldova',
  'Monaco',
  'Mongolia',
  'Montenegro',
  'Morocco',
  'Mozambique',
  'Myanmar',
  'Namibia',
  'Nepal',
  'Netherlands',
  'New Zealand',
  'Nicaragua',
  'Niger',
  'Nigeria',
  'North Korea',
  'North Macedonia',
  'Norway',
  'Oman',
  'Pakistan',
  'Palestine',
  'Panama',
  'Papua New Guinea',
  'Paraguay',
  'Peru',
  'Philippines',
  'Poland',
  'Portugal',
  'Qatar',
  'Romania',
  'Russia',
  'Rwanda',
  'Saudi Arabia',
  'Senegal',
  'Serbia',
  'Sierra Leone',
  'Singapore',
  'Slovakia',
  'Slovenia',
  'Somalia',
  'South Africa',
  'South Korea',
  'South Sudan',
  'Spain',
  'Sri Lanka',
  'Sudan',
  'Suriname',
  'Sweden',
  'Switzerland',
  'Syria',
  'Taiwan',
  'Tajikistan',
  'Tanzania',
  'Thailand',
  'Togo',
  'Trinidad and Tobago',
  'Tunisia',
  'Turkey',
  'Turkmenistan',
  'Uganda',
  'Ukraine',
  'United Arab Emirates',
  'United Kingdom',
  'United States',
  'Uruguay',
  'Uzbekistan',
  'Venezuela',
  'Vietnam',
  'Yemen',
  'Zambia',
  'Zimbabwe',
];

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

    return RefreshIndicator(
      onRefresh: () => ref.read(fasProvider.notifier).refresh(),
      child: CustomScrollView(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "These are the Football Associations that have partnered with SOCALOCA to provide content and services to our users.\n\n"
                "If you are a Football Association, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Association's stakeholders through SOCALOCA Analytics, plus much more.",
                style: TextStyle(
                    color: AppColors.socaBlack,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
          ),
          if (state.isLoading && state.fas.isEmpty)
            const SliverFillRemaining(
                child: const AppLoader())
          else if (state.fas.isEmpty)
            const SliverFillRemaining(
                child: Center(
                    child: Text('No FAs found',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack))))
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == state.fas.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: const AppLoader(),
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
                childCount: state.fas.length + (state.isLoadingMore ? 1 : 0),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
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

    return RefreshIndicator(
      onRefresh: () => ref.read(confedsProvider.notifier).refresh(),
      child: CustomScrollView(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "These are the Football Confederations that have partnered with SOCALOCA to provide content and services to our users.\n\n"
                "If you are a Confederation, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Confederation's stakeholders through SOCALOCA Analytics, plus much more.",
                style: TextStyle(
                    color: AppColors.socaBlack,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
          ),
          if (state.isLoading && state.confeds.isEmpty)
            const SliverFillRemaining(
                child: const AppLoader())
          else if (state.confeds.isEmpty)
            const SliverFillRemaining(
                child: Center(
                    child: Text('No confederations found',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack))))
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == state.confeds.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: const AppLoader(),
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
                childCount:
                    state.confeds.length + (state.isLoadingMore ? 1 : 0),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
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

    return RefreshIndicator(
      onRefresh: () => ref.read(sponsorsProvider.notifier).refresh(),
      child: CustomScrollView(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "These are the Sponsors that have partnered with SOCALOCA to provide content and services to our users.\n\n"
                    "If you are a Sponsor, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase merchandise and services, promote your company through news and announcements, expand your reach, send push notifications to segmented audiences, measure your CSR impact, and much more.",
                    style: TextStyle(
                        color: AppColors.socaBlack,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  ClubFilterRow(
                    selectedCountry: state.country,
                    selectedPartnership: state.partnership,
                    countries: _countries,
                    onCountryChanged: (v) =>
                        ref.read(sponsorsProvider.notifier).setCountry(v),
                    onPartnershipChanged: (v) =>
                        ref.read(sponsorsProvider.notifier).setPartnership(v),
                  ),
                ],
              ),
            ),
          ),
          if (state.isLoading && state.sponsors.isEmpty)
            const SliverFillRemaining(
                child: const AppLoader())
          else if (state.sponsors.isEmpty)
            const SliverFillRemaining(
                child: Center(
                    child: Text('No sponsors found',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack))))
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == state.sponsors.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: const AppLoader(),
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
                childCount:
                    state.sponsors.length + (state.isLoadingMore ? 1 : 0),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
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

    return RefreshIndicator(
      onRefresh: () => ref.read(charitiesProvider.notifier).refresh(),
      child: CustomScrollView(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "These are the Charities, NGOs, and Social Enterprises that have partnered with SOCALOCA to provide content and services to our users.\n\n"
                    "If you are a Charity, NGO, or Social Enterprise, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase your projects and initiatives, reach a wider audience, upload videos and photos, engage with followers, measure the impact of your CSR activities, and positively influence the SOCALOCA community.",
                    style: TextStyle(
                        color: AppColors.socaBlack,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  ClubFilterRow(
                    selectedCountry: state.country,
                    selectedPartnership: state.partnership,
                    countries: _countries,
                    onCountryChanged: (v) =>
                        ref.read(charitiesProvider.notifier).setCountry(v),
                    onPartnershipChanged: (v) =>
                        ref.read(charitiesProvider.notifier).setPartnership(v),
                  ),
                ],
              ),
            ),
          ),
          if (state.isLoading && state.charities.isEmpty)
            const SliverFillRemaining(
                child: const AppLoader())
          else if (state.charities.isEmpty)
            const SliverFillRemaining(
                child: Center(
                    child: Text('No charities & NGOs found',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack))))
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == state.charities.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: const AppLoader(),
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
                childCount:
                    state.charities.length + (state.isLoadingMore ? 1 : 0),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
