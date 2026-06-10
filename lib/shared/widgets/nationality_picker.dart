import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/theme/app_colors.dart';

/// Generates a flag emoji from a 2-letter ISO country code.
String flagEmoji(String iso) => iso
    .toUpperCase()
    .codeUnits
    .map((c) => String.fromCharCode(c + 127397))
    .join();

const List<Map<String, String>> kNationalities = [
  {'name': 'Afghanistan', 'iso': 'AF', 'dial': '+93'},
  {'name': 'Albania', 'iso': 'AL', 'dial': '+355'},
  {'name': 'Algeria', 'iso': 'DZ', 'dial': '+213'},
  {'name': 'American Samoa', 'iso': 'AS', 'dial': '+1'},
  {'name': 'Andorra', 'iso': 'AD', 'dial': '+376'},
  {'name': 'Angola', 'iso': 'AO', 'dial': '+244'},
  {'name': 'Anguilla', 'iso': 'AI', 'dial': '+1'},
  {'name': 'Argentina', 'iso': 'AR', 'dial': '+54'},
  {'name': 'Armenia', 'iso': 'AM', 'dial': '+374'},
  {'name': 'Aruba', 'iso': 'AW', 'dial': '+297'},
  {'name': 'Australia', 'iso': 'AU', 'dial': '+61'},
  {'name': 'Austria', 'iso': 'AT', 'dial': '+43'},
  {'name': 'Azerbaijan', 'iso': 'AZ', 'dial': '+994'},
  {'name': 'Bahamas', 'iso': 'BS', 'dial': '+1'},
  {'name': 'Bahrain', 'iso': 'BH', 'dial': '+973'},
  {'name': 'Bangladesh', 'iso': 'BD', 'dial': '+880'},
  {'name': 'Barbados', 'iso': 'BB', 'dial': '+1'},
  {'name': 'Belarus', 'iso': 'BY', 'dial': '+375'},
  {'name': 'Belgium', 'iso': 'BE', 'dial': '+32'},
  {'name': 'Belize', 'iso': 'BZ', 'dial': '+501'},
  {'name': 'Benin', 'iso': 'BJ', 'dial': '+229'},
  {'name': 'Bolivia', 'iso': 'BO', 'dial': '+591'},
  {'name': 'Bosnia and Herzegovina', 'iso': 'BA', 'dial': '+387'},
  {'name': 'Botswana', 'iso': 'BW', 'dial': '+267'},
  {'name': 'Brazil', 'iso': 'BR', 'dial': '+55'},
  {'name': 'Brunei', 'iso': 'BN', 'dial': '+673'},
  {'name': 'Bulgaria', 'iso': 'BG', 'dial': '+359'},
  {'name': 'Burkina Faso', 'iso': 'BF', 'dial': '+226'},
  {'name': 'Burundi', 'iso': 'BI', 'dial': '+257'},
  {'name': 'Cambodia', 'iso': 'KH', 'dial': '+855'},
  {'name': 'Cameroon', 'iso': 'CM', 'dial': '+237'},
  {'name': 'Canada', 'iso': 'CA', 'dial': '+1'},
  {'name': 'Cape Verde', 'iso': 'CV', 'dial': '+238'},
  {'name': 'Chile', 'iso': 'CL', 'dial': '+56'},
  {'name': 'China', 'iso': 'CN', 'dial': '+86'},
  {'name': 'Colombia', 'iso': 'CO', 'dial': '+57'},
  {'name': 'Comoros', 'iso': 'KM', 'dial': '+269'},
  {'name': 'Congo', 'iso': 'CG', 'dial': '+242'},
  {'name': 'Costa Rica', 'iso': 'CR', 'dial': '+506'},
  {'name': 'Croatia', 'iso': 'HR', 'dial': '+385'},
  {'name': 'Cuba', 'iso': 'CU', 'dial': '+53'},
  {'name': 'Cyprus', 'iso': 'CY', 'dial': '+357'},
  {'name': 'Czech Republic', 'iso': 'CZ', 'dial': '+420'},
  {'name': 'Denmark', 'iso': 'DK', 'dial': '+45'},
  {'name': 'Dominican Republic', 'iso': 'DO', 'dial': '+1'},
  {'name': 'Ecuador', 'iso': 'EC', 'dial': '+593'},
  {'name': 'Egypt', 'iso': 'EG', 'dial': '+20'},
  {'name': 'El Salvador', 'iso': 'SV', 'dial': '+503'},
  {'name': 'England', 'iso': 'GB', 'dial': '+44'},
  {'name': 'Estonia', 'iso': 'EE', 'dial': '+372'},
  {'name': 'Ethiopia', 'iso': 'ET', 'dial': '+251'},
  {'name': 'Fiji', 'iso': 'FJ', 'dial': '+679'},
  {'name': 'Finland', 'iso': 'FI', 'dial': '+358'},
  {'name': 'France', 'iso': 'FR', 'dial': '+33'},
  {'name': 'Gabon', 'iso': 'GA', 'dial': '+241'},
  {'name': 'Gambia', 'iso': 'GM', 'dial': '+220'},
  {'name': 'Georgia', 'iso': 'GE', 'dial': '+995'},
  {'name': 'Germany', 'iso': 'DE', 'dial': '+49'},
  {'name': 'Ghana', 'iso': 'GH', 'dial': '+233'},
  {'name': 'Greece', 'iso': 'GR', 'dial': '+30'},
  {'name': 'Guatemala', 'iso': 'GT', 'dial': '+502'},
  {'name': 'Guinea', 'iso': 'GN', 'dial': '+224'},
  {'name': 'Haiti', 'iso': 'HT', 'dial': '+509'},
  {'name': 'Honduras', 'iso': 'HN', 'dial': '+504'},
  {'name': 'Hungary', 'iso': 'HU', 'dial': '+36'},
  {'name': 'Iceland', 'iso': 'IS', 'dial': '+354'},
  {'name': 'India', 'iso': 'IN', 'dial': '+91'},
  {'name': 'Indonesia', 'iso': 'ID', 'dial': '+62'},
  {'name': 'Iran', 'iso': 'IR', 'dial': '+98'},
  {'name': 'Iraq', 'iso': 'IQ', 'dial': '+964'},
  {'name': 'Ireland', 'iso': 'IE', 'dial': '+353'},
  {'name': 'Israel', 'iso': 'IL', 'dial': '+972'},
  {'name': 'Italy', 'iso': 'IT', 'dial': '+39'},
  {'name': 'Jamaica', 'iso': 'JM', 'dial': '+1'},
  {'name': 'Japan', 'iso': 'JP', 'dial': '+81'},
  {'name': 'Jordan', 'iso': 'JO', 'dial': '+962'},
  {'name': 'Kazakhstan', 'iso': 'KZ', 'dial': '+7'},
  {'name': 'Kenya', 'iso': 'KE', 'dial': '+254'},
  {'name': 'Kuwait', 'iso': 'KW', 'dial': '+965'},
  {'name': 'Korea Republic', 'iso': 'KR', 'dial': '+82'},
  {'name': 'Latvia', 'iso': 'LV', 'dial': '+371'},
  {'name': 'Lebanon', 'iso': 'LB', 'dial': '+961'},
  {'name': 'Libya', 'iso': 'LY', 'dial': '+218'},
  {'name': 'Lithuania', 'iso': 'LT', 'dial': '+370'},
  {'name': 'Luxembourg', 'iso': 'LU', 'dial': '+352'},
  {'name': 'Madagascar', 'iso': 'MG', 'dial': '+261'},
  {'name': 'Malawi', 'iso': 'MW', 'dial': '+265'},
  {'name': 'Malaysia', 'iso': 'MY', 'dial': '+60'},
  {'name': 'Maldives', 'iso': 'MV', 'dial': '+960'},
  {'name': 'Mali', 'iso': 'ML', 'dial': '+223'},
  {'name': 'Malta', 'iso': 'MT', 'dial': '+356'},
  {'name': 'Mauritius', 'iso': 'MU', 'dial': '+230'},
  {'name': 'Mexico', 'iso': 'MX', 'dial': '+52'},
  {'name': 'Moldova', 'iso': 'MD', 'dial': '+373'},
  {'name': 'Mongolia', 'iso': 'MN', 'dial': '+976'},
  {'name': 'Morocco', 'iso': 'MA', 'dial': '+212'},
  {'name': 'Mozambique', 'iso': 'MZ', 'dial': '+258'},
  {'name': 'Myanmar', 'iso': 'MM', 'dial': '+95'},
  {'name': 'Namibia', 'iso': 'NA', 'dial': '+264'},
  {'name': 'Nepal', 'iso': 'NP', 'dial': '+977'},
  {'name': 'Netherlands', 'iso': 'NL', 'dial': '+31'},
  {'name': 'New Zealand', 'iso': 'NZ', 'dial': '+64'},
  {'name': 'Nicaragua', 'iso': 'NI', 'dial': '+505'},
  {'name': 'Niger', 'iso': 'NE', 'dial': '+227'},
  {'name': 'Nigeria', 'iso': 'NG', 'dial': '+234'},
  {'name': 'North Macedonia', 'iso': 'MK', 'dial': '+389'},
  {'name': 'Norway', 'iso': 'NO', 'dial': '+47'},
  {'name': 'Oman', 'iso': 'OM', 'dial': '+968'},
  {'name': 'Pakistan', 'iso': 'PK', 'dial': '+92'},
  {'name': 'Panama', 'iso': 'PA', 'dial': '+507'},
  {'name': 'Papua New Guinea', 'iso': 'PG', 'dial': '+675'},
  {'name': 'Paraguay', 'iso': 'PY', 'dial': '+595'},
  {'name': 'Peru', 'iso': 'PE', 'dial': '+51'},
  {'name': 'Philippines', 'iso': 'PH', 'dial': '+63'},
  {'name': 'Poland', 'iso': 'PL', 'dial': '+48'},
  {'name': 'Portugal', 'iso': 'PT', 'dial': '+351'},
  {'name': 'Qatar', 'iso': 'QA', 'dial': '+974'},
  {'name': 'Romania', 'iso': 'RO', 'dial': '+40'},
  {'name': 'Russia', 'iso': 'RU', 'dial': '+7'},
  {'name': 'Rwanda', 'iso': 'RW', 'dial': '+250'},
  {'name': 'Saudi Arabia', 'iso': 'SA', 'dial': '+966'},
  {'name': 'Senegal', 'iso': 'SN', 'dial': '+221'},
  {'name': 'Serbia', 'iso': 'RS', 'dial': '+381'},
  {'name': 'Sierra Leone', 'iso': 'SL', 'dial': '+232'},
  {'name': 'Singapore', 'iso': 'SG', 'dial': '+65'},
  {'name': 'Slovakia', 'iso': 'SK', 'dial': '+421'},
  {'name': 'Slovenia', 'iso': 'SI', 'dial': '+386'},
  {'name': 'Somalia', 'iso': 'SO', 'dial': '+252'},
  {'name': 'South Africa', 'iso': 'ZA', 'dial': '+27'},
  {'name': 'South Korea', 'iso': 'KR', 'dial': '+82'},
  {'name': 'Spain', 'iso': 'ES', 'dial': '+34'},
  {'name': 'Sri Lanka', 'iso': 'LK', 'dial': '+94'},
  {'name': 'Sudan', 'iso': 'SD', 'dial': '+249'},
  {'name': 'Sweden', 'iso': 'SE', 'dial': '+46'},
  {'name': 'Switzerland', 'iso': 'CH', 'dial': '+41'},
  {'name': 'Syria', 'iso': 'SY', 'dial': '+963'},
  {'name': 'Taiwan', 'iso': 'TW', 'dial': '+886'},
  {'name': 'Tanzania', 'iso': 'TZ', 'dial': '+255'},
  {'name': 'Thailand', 'iso': 'TH', 'dial': '+66'},
  {'name': 'Togo', 'iso': 'TG', 'dial': '+228'},
  {'name': 'Trinidad and Tobago', 'iso': 'TT', 'dial': '+1'},
  {'name': 'Tunisia', 'iso': 'TN', 'dial': '+216'},
  {'name': 'Türkiye', 'iso': 'TR', 'dial': '+90'},
  {'name': 'Uganda', 'iso': 'UG', 'dial': '+256'},
  {'name': 'Ukraine', 'iso': 'UA', 'dial': '+380'},
  {'name': 'United Arab Emirates', 'iso': 'AE', 'dial': '+971'},
  {'name': 'Uruguay', 'iso': 'UY', 'dial': '+598'},
  {'name': 'USA', 'iso': 'US', 'dial': '+1'},
  {'name': 'Uzbekistan', 'iso': 'UZ', 'dial': '+998'},
  {'name': 'Venezuela', 'iso': 'VE', 'dial': '+58'},
  {'name': 'Vietnam', 'iso': 'VN', 'dial': '+84'},
  {'name': 'Yemen', 'iso': 'YE', 'dial': '+967'},
  {'name': 'Zambia', 'iso': 'ZM', 'dial': '+260'},
  {'name': 'Zimbabwe', 'iso': 'ZW', 'dial': '+263'},
];

/// Shows the nationality picker bottom sheet.
/// Returns a map with keys 'name', 'iso', 'dial', or null if dismissed.
Future<Map<String, String>?> showNationalityPicker(
  BuildContext context, {
  String? selectedIso,
}) {
  return showModalBottomSheet<Map<String, String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => NationalityPickerSheet(selectedIso: selectedIso),
  );
}

class NationalityPickerSheet extends StatefulWidget {
  const NationalityPickerSheet({super.key, this.selectedIso});
  final String? selectedIso;

  @override
  State<NationalityPickerSheet> createState() => _NationalityPickerSheetState();
}

class _NationalityPickerSheetState extends State<NationalityPickerSheet> {
  final _searchCtrl = TextEditingController();
  List<Map<String, String>> _filtered = kNationalities;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? kNationalities
          : kNationalities
              .where((c) =>
                  c['name']!.toLowerCase().contains(q) ||
                  c['iso']!.toLowerCase().contains(q) ||
                  c['dial']!.contains(q))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxH = MediaQuery.of(context).size.height * 0.8;
    return Container(
      height: maxH,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Text(
              AppStrings.selectNationality,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.socaBlack,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              autofocus: false,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
              decoration: const InputDecoration(
                fillColor: Colors.transparent,
                hintText: 'Search country...',
                hintStyle: TextStyle(
                    fontFamily: 'Poppins', fontSize: 13, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.socaBlack),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.socaBlack),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.socaBlack, width: 1.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final c = _filtered[i];
                      final iso = c['iso']!;
                      final name = c['name']!;
                      final dial = c['dial']!;
                      final isSelected = iso == widget.selectedIso;
                      return InkWell(
                        onTap: () => Navigator.of(context).pop(c),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                flagEmoji(iso),
                                style: const TextStyle(fontSize: 30),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '$name ($iso)',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                              ),
                              Text(
                                dial,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 8),
                                const Icon(Icons.check,
                                    size: 18, color: AppColors.socaBlack),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
