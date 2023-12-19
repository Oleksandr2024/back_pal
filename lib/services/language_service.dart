import 'package:flutter/material.dart';
import 'package:back_pal/strings/strings_en.dart';
import 'package:back_pal/strings/strings_uk.dart';
import 'package:back_pal/strings/strings_ar.dart';
import 'package:back_pal/strings/strings_de.dart';
import 'package:back_pal/strings/strings_es.dart';
import 'package:back_pal/strings/strings_fr.dart';
import 'package:back_pal/strings/strings_it.dart';
import 'package:back_pal/strings/strings_ja.dart';
import 'package:back_pal/strings/strings_ko.dart';
import 'package:back_pal/strings/strings_nl.dart';
import 'package:back_pal/strings/strings_zh.dart';

class LanguageService {
  static Map<String, String> translations = {};

  static Future<void> loadTranslations(Locale locale) async {
    String languageCode = locale.languageCode;
    switch (languageCode) {
      case 'en':
        translations = englishStrings;
        break;
      case 'uk':
        translations = ukrainianStrings;
        break;
      case 'ar':
        translations = arabicStrings;
        break;
      case 'de':
        translations = germanStrings;
        break;
      case 'es':
        translations = spanishStrings;
        break;
      case 'fr':
        translations = frenchStrings;
        break;
      case 'it':
        translations = italianStrings;
        break;
      case 'ja':
        translations = japaneseStrings;
        break;
      case 'ko':
        translations = koreanStrings;
        break;
      case 'nl':
        translations = dutchStrings;
        break;
      case 'zh':
        translations = chineseStrings;
        break;

    // Add cases for other languages
      default:
        translations = englishStrings;
    }
  }

  static String getTranslation(String key) {
    // Split the key into parts using ':' as a delimiter
    List<String> keyParts = key.split(':');
    // If there are multiple parts, concatenate them with ':'
    if (keyParts.length > 1) {
      return keyParts.map((part) => translations[part] ?? part).join(' - ');
    }
    // Otherwise, return the translation for the key or the key itself
    return translations[key] ?? key;
  }

  static List<String> getTranslationList(String key) { //added
    String combinedString = translations[key] ?? '';
    return combinedString.split(';');
  }
}

