part of 'locale_cubit.dart';

@immutable
abstract class LocaleState {
  const LocaleState();
}

class ChangeLocaleState extends LocaleState {
  final Locale locale;

  const ChangeLocaleState({required this.locale}) : super();
}

class LocaleStateLoading extends LocaleState {
  const LocaleStateLoading();


}

