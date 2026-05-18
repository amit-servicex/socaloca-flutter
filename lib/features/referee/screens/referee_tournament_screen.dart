import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/tournaments/screens/tournaments_landing_screen.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/referee_tournament_model.dart';
import '../providers/referee_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class RefereeTournamentScreen extends StatelessWidget {
  RefereeTournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TournamentsLandingScreen();
  }
}

// class RefereeTournamentScreen extends ConsumerStatefulWidget {
//   RefereeTournamentScreen({super.key});

//   @override
//   ConsumerState<RefereeTournamentScreen> createState() =>
//       _RefereeTournamentScreenState();
// }

// class _RefereeTournamentScreenState
//     extends ConsumerState<RefereeTournamentScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(refereeTournamentsProvider.notifier).load();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tournamentsState = ref.watch(refereeTournamentsProvider);

//     return tournamentsState.when(
//       loading: () => AppLoader(),
//       error: (e, _) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 48, color: AppColors.error),
//             SizedBox(height: 12),
//             Text(e.toString(),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
//             SizedBox(height: 12),
//             ElevatedButton(
//               onPressed: () =>
//                   ref.read(refereeTournamentsProvider.notifier).load(),
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.socaBlack,
//                   foregroundColor: AppColors.socaYellow),
//               child:
//                   Text('Retry'.tr, style: TextStyle(fontFamily: 'Poppins')),
//             ),
//           ],
//         ),
//       ),
//       data: (tournaments) => tournaments.isEmpty
//           ? _EmptyTournaments()
//           : ListView.builder(
//               padding: EdgeInsets.all(12),
//               itemCount: tournaments.length,
//               itemBuilder: (ctx, i) => _TournamentCard(
//                 tournament: tournaments[i],
//                 onTap: () {
//                   final tmntId = tournaments[i].tournamentId;
//                   if (tmntId != null && tmntId.isNotEmpty) {
//                     context.push(
//                       AppRoutes.refereeTournamentView
//                           .replaceFirst(':tmntId', tmntId),
//                     );
//                   }
//                 },
//               ),
//             ),
//     );
//   }
// }

// class _EmptyTournaments extends StatelessWidget {
//   _EmptyTournaments();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.emoji_events_outlined,
//               size: 60, color: AppColors.socaGrey),
//           SizedBox(height: 16),
//           Text(
//             'No tournaments assigned yet',
//             style: TextStyle(
//                 fontFamily: 'Poppins', fontSize: 14, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TournamentCard extends StatelessWidget {
//   _TournamentCard({
//     required this.tournament,
//     required this.onTap,
//   });

//   final RefereeTournamentModel tournament;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     final imageUrl = ApiConstants.getImageUrl(tournament.tournamentImage);
//     final status = tournament.status ?? '';
//     final isOngoing = status == 'ongoing';

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isOngoing ? AppColors.socaYellow : Color(0xFFE0E0E0),
//             width: isOngoing ? 1.5 : 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(14),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Tournament image
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.socaGrey,
//                   border: Border.all(color: Color(0xFFE0E0E0)),
//                 ),
//                 child: ClipOval(
//                   child: imageUrl.isNotEmpty
//                       ? CachedNetworkImage(
//                           imageUrl: imageUrl,
//                           fit: BoxFit.cover,
//                           errorWidget: (_, __, ___) => Icon(
//                             Icons.emoji_events,
//                             color: AppColors.socaBlack,
//                             size: 28,
//                           ),
//                         )
//                       : Icon(
//                           Icons.emoji_events,
//                           color: AppColors.socaBlack,
//                           size: 28,
//                         ),
//                 ),
//               ),
//               SizedBox(width: 12),

//               // Info
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             tournament.tournamentName ?? '',
//                             style: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 14,
//                               color: AppColors.socaBlack,
//                             ),
//                           ),
//                         ),
//                         _StatusBadge(status: status),
//                       ],
//                     ),
//                     if (tournament.organiserName?.isNotEmpty == true) ...[
//                       SizedBox(height: 3),
//                       Text(
//                         tournament.organiserName!,
//                         style: TextStyle(
//                             fontFamily: 'Lato',
//                             fontSize: 12,
//                             color: Colors.grey),
//                       ),
//                     ],
//                     SizedBox(height: 6),
//                     Wrap(
//                       spacing: 12,
//                       runSpacing: 3,
//                       children: [
//                         if (tournament.startDate != null)
//                           _infoChip(
//                             Icons.calendar_today,
//                             _dateRange(
//                                 tournament.startDate, tournament.endDate),
//                           ),
//                         if (tournament.venue?.isNotEmpty == true)
//                           _infoChip(Icons.location_on, tournament.venue!),
//                         if (tournament.ageGroup?.isNotEmpty == true)
//                           _infoChip(Icons.group, tournament.ageGroup!),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: AppColors.socaBlack,
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: Text(
//                           'VIEW TOURNAMENT',
//                           style: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 10,
//                               color: AppColors.socaYellow),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _dateRange(String? start, String? end) {
//     if (start == null) return '';
//     if (end == null || end.isEmpty) return start;
//     return '$start – $end';
//   }

//   Widget _infoChip(IconData icon, String text) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 12, color: Colors.grey),
//         SizedBox(width: 3),
//         Text(text,
//             style: TextStyle(
//                 fontFamily: 'Lato', fontSize: 12, color: Colors.grey)),
//       ],
//     );
//   }
// }

// class _StatusBadge extends StatelessWidget {
//   _StatusBadge({required this.status});
//   final String status;

//   @override
//   Widget build(BuildContext context) {
//     if (status.isEmpty) return SizedBox.shrink();

//     Color bgColor;
//     String label;
//     switch (status) {
//       case 'ongoing':
//         bgColor = Colors.green;
//         label = 'ONGOING';
//         break;
//       case 'upcoming':
//         bgColor = AppColors.socaBlack;
//         label = 'UPCOMING';
//         break;
//       case 'closed':
//         bgColor = Colors.grey;
//         label = 'CLOSED';
//         break;
//       default:
//         bgColor = Colors.grey;
//         label = status.toUpperCase();
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w700,
//             fontSize: 9,
//             color: Colors.white),
//       ),
//     );
//   }
// }
