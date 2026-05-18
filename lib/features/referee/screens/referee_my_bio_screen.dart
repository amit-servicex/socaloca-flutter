import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:socaloca/features/my_bio/screens/my_bio_screen.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class RefereeMyBioScreen extends StatelessWidget {
  RefereeMyBioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyBioScreen();
  }
}

// class RefereeMyBioScreen extends ConsumerStatefulWidget {
//   RefereeMyBioScreen({super.key});

//   @override
//   ConsumerState<RefereeMyBioScreen> createState() => _RefereeMyBioScreenState();
// }

// class _RefereeMyBioScreenState extends ConsumerState<RefereeMyBioScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(refereeBioProvider.notifier).load();
//     });
//   }

//   void _handleShare(RefereeBioModel bio) {
//     final name = '${bio.firstName ?? ''} ${bio.lastName ?? ''}'.trim();
//     SharePlus.instance.share(ShareParams(
//       text: '$name is inviting you to join Socaloca! '
//           'Download: https://tinyurl.com/yxrtynk4',
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(refereeBioProvider);

//     if (state.isLoading) {
//       return AppLoader();
//     }

//     if (state.error != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 48, color: AppColors.error),
//             SizedBox(height: 16),
//             Text(state.error!,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => ref.read(refereeBioProvider.notifier).load(),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.socaBlack,
//                 foregroundColor: AppColors.socaYellow,
//               ),
//               child:
//                   Text('Retry'.tr, style: TextStyle(fontFamily: 'Poppins')),
//             ),
//           ],
//         ),
//       );
//     }

//     final bio = state.bio;
//     if (bio == null) {
//       return Center(
//         child: Text('Profile not found'.tr,
//             style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
//       );
//     }

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(bio),
//           Divider(height: 1, color: AppColors.socaBlack),
//           _buildCounters(bio),
//           Divider(height: 1, color: AppColors.socaBlack),
//           _buildActionButtons(bio),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (bio.aboutMe?.isNotEmpty == true) ...[
//                   _sectionTitle('About Me'),
//                   SizedBox(height: 8),
//                   Text(bio.aboutMe!,
//                       style: TextStyle(fontFamily: 'Lato', fontSize: 14)),
//                   SizedBox(height: 20),
//                 ],
//                 _buildFootballStats(bio),
//                 SizedBox(height: 20),
//                 _buildFutsalStats(bio),
//                 SizedBox(height: 20),
//                 _buildRecentActivities(),
//                 SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(RefereeBioModel bio) {
//     final imageUrl = ApiConstants.getImageUrl(bio.imageUrl);
//     final coverUrl = ApiConstants.getImageUrl(bio.coverImage);
//     final fullName = '${bio.firstName ?? ''} ${bio.lastName ?? ''}'.trim();

//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         // Cover photo
//         Container(
//           height: 150,
//           width: double.infinity,
//           color: AppColors.socaGrey,
//           child: coverUrl.isNotEmpty
//               ? CachedNetworkImage(
//                   imageUrl: coverUrl,
//                   fit: BoxFit.cover,
//                   errorWidget: (_, __, ___) => SizedBox(),
//                 )
//               : null,
//         ),
//         // Avatar
//         Positioned(
//           bottom: -40,
//           left: 16,
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.white, width: 3),
//             ),
//             child: CircleAvatar(
//               radius: 40,
//               backgroundColor: AppColors.socaGrey,
//               backgroundImage: imageUrl.isNotEmpty
//                   ? CachedNetworkImageProvider(imageUrl)
//                   : null,
//               child: imageUrl.isEmpty
//                   ? Text(
//                       fullName.isNotEmpty ? fullName[0].toUpperCase() : 'R',
//                       style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.socaBlack),
//                     )
//                   : null,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCounters(RefereeBioModel bio) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(16, 52, 16, 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   '${bio.firstName ?? ''} ${bio.lastName ?? ''}'.trim(),
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w700,
//                     fontSize: 18,
//                     color: AppColors.socaBlack,
//                   ),
//                 ),
//               ),
//               if (bio.isVerifyBadge == true)
//                 Icon(Icons.verified, color: Colors.blue, size: 20),
//             ],
//           ),
//           if (bio.city?.isNotEmpty == true || bio.country?.isNotEmpty == true)
//             Text(
//               [bio.city, bio.country]
//                   .where((v) => v?.isNotEmpty == true)
//                   .join(', '),
//               style: TextStyle(
//                   fontFamily: 'Lato', fontSize: 13, color: Colors.grey),
//             ),
//           SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _statCounter('${bio.postCount ?? 0}', 'Posts'),
//               _statCounter('${bio.likeCount ?? 0}', 'Cheers'),
//               _statCounter('${bio.followCount ?? 0}', 'Followers'),
//               _statCounter('${bio.followingCount ?? 0}', 'Following'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _statCounter(String value, String label) {
//     return Column(
//       children: [
//         Text(value,
//             style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16,
//                 color: AppColors.socaBlack)),
//         Text(label,
//             style: TextStyle(
//                 fontFamily: 'Lato', fontSize: 11, color: Colors.grey)),
//       ],
//     );
//   }

//   Widget _buildActionButtons(RefereeBioModel bio) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             _ActionBtn(
//               label: 'CREATE A POST',
//               onTap: () => context.push(AppRoutes.createPost),
//             ),
//             SizedBox(width: 8),
//             _ActionBtn(
//               label: 'MY ACTIVITIES',
//               onTap: () => context.push(AppRoutes.refereeActivities),
//             ),
//             SizedBox(width: 8),
//             GestureDetector(
//               onTap: () => _handleShare(bio),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 5),
//                 child: Icon(Icons.share, color: AppColors.socaBlack, size: 24),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFootballStats(RefereeBioModel bio) {
//     return _buildStatCard(
//       icon: Icons.sports_soccer,
//       title: 'Football Stats',
//       officiated: bio.ftOfficiated,
//       thisYear: bio.ftMatchesYear,
//       pastYears: bio.ftPastYears,
//       yellowCards: bio.ftYellowCards,
//       redCards: bio.ftRedCards,
//     );
//   }

//   Widget _buildFutsalStats(RefereeBioModel bio) {
//     return _buildStatCard(
//       icon: Icons.sports_soccer_outlined,
//       title: 'Futsal Stats',
//       officiated: bio.fsOfficiated,
//       thisYear: bio.fsMatchesYear,
//       pastYears: bio.fsPastYears,
//       yellowCards: bio.fsYellowCards,
//       redCards: bio.fsRedCards,
//     );
//   }

//   Widget _buildStatCard({
//     required IconData icon,
//     required String title,
//     String? officiated,
//     String? thisYear,
//     String? pastYears,
//     String? yellowCards,
//     String? redCards,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Color(0xFFE0E0E0)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(children: [
//             Icon(icon, size: 18, color: AppColors.socaBlack),
//             SizedBox(width: 8),
//             Text(title,
//                 style: TextStyle(
//                     fontFamily: 'Lato',
//                     fontWeight: FontWeight.w700,
//                     fontSize: 15,
//                     color: AppColors.socaBlack)),
//           ]),
//           SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _miniStat(officiated ?? '0', 'Officiated'),
//               _miniStat(thisYear ?? '0', 'This Year'),
//               _miniStat(pastYears ?? '0', 'Past Years'),
//             ],
//           ),
//           SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _cardStat('🟡', yellowCards ?? '0', 'Yellow Cards'),
//               _cardStat('🔴', redCards ?? '0', 'Red Cards'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _miniStat(String value, String label) {
//     return Column(
//       children: [
//         Text(value,
//             style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//                 color: AppColors.socaBlack)),
//         Text(label,
//             style: TextStyle(
//                 fontFamily: 'Lato', fontSize: 11, color: Colors.grey)),
//       ],
//     );
//   }

//   Widget _cardStat(String emoji, String value, String label) {
//     return Row(children: [
//       Text(emoji, style: TextStyle(fontSize: 16)),
//       SizedBox(width: 6),
//       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(value,
//             style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16,
//                 color: AppColors.socaBlack)),
//         Text(label,
//             style: TextStyle(
//                 fontFamily: 'Lato', fontSize: 11, color: Colors.grey)),
//       ]),
//     ]);
//   }

//   Widget _buildRecentActivities() {
//     final activities = ref.watch(refereeBioProvider).recentActivities;
//     final isLoading = ref.watch(refereeBioProvider).isLoadingActivities;

//     if (isLoading) {
//       return AppLoader();
//     }
//     if (activities.isEmpty) return SizedBox.shrink();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _sectionTitle('Recent Activities'),
//         SizedBox(height: 8),
//         ...activities.take(5).map((a) => _ActivityCard(activity: a)),
//       ],
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontFamily: 'Lato',
//         fontWeight: FontWeight.w700,
//         fontSize: 16,
//         color: AppColors.socaBlack,
//       ),
//     );
//   }
// }

// class _ActionBtn extends StatelessWidget {
//   _ActionBtn({required this.label, required this.onTap});
//   final String label;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         decoration: BoxDecoration(
//           color: AppColors.socaBlack,
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Text(label,
//             style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontSize: 9,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.socaYellow)),
//       ),
//     );
//   }
// }

// class _ActivityCard extends StatelessWidget {
//   _ActivityCard({required this.activity});
//   final RefereeActivityModel activity;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 8),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Color(0xFFE0E0E0)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             activity.tournamentName ?? '',
//             style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w600,
//                 fontSize: 13,
//                 color: AppColors.socaBlack),
//           ),
//           SizedBox(height: 4),
//           Row(children: [
//             Expanded(
//               child: Text(
//                 '${activity.teamA ?? ''} ${activity.teamAScore ?? ''} - ${activity.teamBScore ?? ''} ${activity.teamB ?? ''}',
//                 style: TextStyle(
//                     fontFamily: 'Lato',
//                     fontSize: 13,
//                     color: AppColors.socaBlack),
//               ),
//             ),
//           ]),
//           SizedBox(height: 4),
//           Row(children: [
//             Icon(Icons.calendar_today, size: 12, color: Colors.grey),
//             SizedBox(width: 4),
//             Text(activity.matchDate ?? '',
//                 style: TextStyle(
//                     fontFamily: 'Lato', fontSize: 12, color: Colors.grey)),
//             SizedBox(width: 12),
//             Text(
//                 '🟡 ${activity.yellowCardsGiven ?? 0}  🔴 ${activity.redCardsGiven ?? 0}',
//                 style: TextStyle(fontSize: 12)),
//           ]),
//         ],
//       ),
//     );
//   }
// }
