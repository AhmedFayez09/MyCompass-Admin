import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(Locale('en'));  // Default to English

  // Method to change the language
  void toggleLanguage() {
    // Toggle between English and Arabic
    if (state.languageCode == 'en') {
      emit(Locale('de')); // Change to Arabic
    } else {
      emit(Locale('en')); // Change to English
    }
  }
}