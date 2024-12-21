library country_picker;

import 'package:flutter/material.dart';

import 'src/country.dart';
import 'src/country_list_bottom_sheet.dart';
import 'src/country_list_theme_data.dart';

export 'src/country.dart';
export 'src/country_list_theme_data.dart';
export 'src/country_localizations.dart';
export 'src/country_parser.dart';
export 'src/country_service.dart';

void showCountryPicker({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  VoidCallback? onClosed,
  List<String>? favorite,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode = false,
  CountryListThemeData? countryListTheme,
  bool searchAutofocus = false,
  bool showWorldWide = false,
  bool showSearch = true,
}) {
  assert(
    exclude == null || countryFilter == null,
    'Cannot provide both exclude and countryFilter',
  );
  showCountryListBottomSheet(
    context: context,
    onSelect: onSelect,
    onClosed: onClosed,
    exclude: exclude,
    favorite: favorite,
    countryFilter: countryFilter,
    showPhoneCode: showPhoneCode,
    countryListTheme: countryListTheme,
    searchAutofocus: searchAutofocus,
    showWorldWide: showWorldWide,
    showSearch: showSearch,
  );
}
