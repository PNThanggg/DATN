import 'package:flutter/material.dart';

import 'country.dart';
import 'country_localizations.dart';
import 'res/country_codes.dart';
import 'res/strings/ar.dart';
import 'res/strings/cn.dart';
import 'res/strings/de.dart';
import 'res/strings/en.dart';
import 'res/strings/es.dart';
import 'res/strings/et.dart';
import 'res/strings/fr.dart';
import 'res/strings/gr.dart';
import 'res/strings/hr.dart';
import 'res/strings/ku.dart';
import 'res/strings/lt.dart';
import 'res/strings/lv.dart';
import 'res/strings/nb.dart';
import 'res/strings/nl.dart';
import 'res/strings/nn.dart';
import 'res/strings/np.dart';
import 'res/strings/pl.dart';
import 'res/strings/pt.dart';
import 'res/strings/ru.dart';
import 'res/strings/tr.dart';
import 'res/strings/tw.dart';
import 'res/strings/uk.dart';

class CountryParser {
  static Country parse(String country) {
    return tryParseCountryCode(country) ?? parseCountryName(country);
  }

  static Country? tryParse(String country) {
    return tryParseCountryCode(country) ?? tryParseCountryName(country);
  }

  static Country parseCountryCode(String countryCode) {
    return _getFromCode(countryCode.toUpperCase());
  }

  static Country parsePhoneCode(String phoneCode) {
    return _getFromPhoneCode(phoneCode);
  }

  static Country? tryParseCountryCode(String countryCode) {
    try {
      return parseCountryCode(countryCode);
    } catch (_) {
      return null;
    }
  }

  static Country? tryParsePhoneCode(String phoneCode) {
    try {
      return parsePhoneCode(phoneCode);
    } catch (_) {
      return null;
    }
  }

  static Country parseCountryName(
    String countryName, {
    BuildContext? context,
    List<Locale>? locales,
  }) {
    final String countryNameLower = countryName.toLowerCase();

    final CountryLocalizations? localizations = context != null ? CountryLocalizations.of(context) : null;

    final String languageCode = _anyLocalizedNameToCode(
      countryNameLower,
      localizations?.locale,
      locales,
    );

    return _getFromCode(languageCode);
  }

  static Country? tryParseCountryName(
    String countryName, {
    BuildContext? context,
    List<Locale>? locales,
  }) {
    try {
      return parseCountryName(countryName, context: context, locales: locales);
    } catch (_) {
      return null;
    }
  }

  static Country _getFromPhoneCode(String phoneCode) {
    return Country.from(
      json: countryCodes.singleWhere(
        (Map<String, dynamic> c) => c['e164_cc'] == phoneCode,
      ),
    );
  }

  static Country _getFromCode(String countryCode) {
    return Country.from(
      json: countryCodes.singleWhere(
        (Map<String, dynamic> c) => c['iso2_cc'] == countryCode,
      ),
    );
  }

  static String _anyLocalizedNameToCode(
    String name,
    Locale? locale,
    List<Locale>? locales,
  ) {
    String? code;

    if (locale != null) code = _localizedNameToCode(name, locale);
    if (code == null && locales == null) {
      code = _localizedNameToCode(name, const Locale('en'));
    }
    if (code != null) return code;

    final List<Locale> localeList = locales ?? <Locale>[];

    if (locales == null) {
      final List<Locale> exclude = <Locale>[const Locale('en')];
      if (locale != null) exclude.add(locale);
      localeList.addAll(_supportedLanguages(exclude: exclude));
    }

    return _nameToCodeFromGivenLocales(name, localeList);
  }

  static String _nameToCodeFromGivenLocales(String name, List<Locale> locales) {
    String? code;

    for (int i = 0; i < locales.length && code == null; i++) {
      code = _localizedNameToCode(name, locales[i]);
    }

    if (code == null) {
      throw ArgumentError.value('No country found');
    }

    return code;
  }

  static String? _localizedNameToCode(String name, Locale locale) {
    final Map<String, String> translation = _getTranslation(locale);

    String? code;

    translation.forEach((key, value) {
      if (value.toLowerCase() == name) code = key;
    });

    return code;
  }

  static Map<String, String> _getTranslation(Locale locale) {
    switch (locale.languageCode) {
      case 'zh':
        switch (locale.scriptCode) {
          case 'Hant':
            return tw;
          case 'Hans':
          default:
            return cn;
        }
      case 'el':
        return gr;
      case 'ar':
        return ar;
      case 'ku':
        return ku;
      case 'es':
        return es;
      case 'et':
        return et;
      case 'pt':
        return pt;
      case 'nb':
        return nb;
      case 'nn':
        return nn;
      case 'uk':
        return uk;
      case 'pl':
        return pl;
      case 'tr':
        return tr;
      case 'hr':
        return hr;
      case 'ru':
        return ru;
      case 'hi':
      case 'ne':
        return np;
      case 'fr':
        return fr;
      case 'de':
        return de;
      case 'lv':
        return lv;
      case 'lt':
        return lt;
      case 'nl':
        return nl;
      case 'en':
      default:
        return en;
    }
  }

  static List<Locale> _supportedLanguages({
    List<Locale> exclude = const <Locale>[],
  }) {
    return <Locale>[
      const Locale('en'),
      const Locale('ar'),
      const Locale('ku'),
      const Locale('es'),
      const Locale('el'),
      const Locale('et'),
      const Locale('fr'),
      const Locale('nb'),
      const Locale('nn'),
      const Locale('pl'),
      const Locale('pt'),
      const Locale('ru'),
      const Locale('hi'),
      const Locale('ne'),
      const Locale('uk'),
      const Locale('tr'),
      const Locale('hr'),
      const Locale('de'),
      const Locale('lv'),
      const Locale('lv'),
      const Locale('nl'),
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    ]..removeWhere((Locale l) => exclude.contains(l));
  }
}
