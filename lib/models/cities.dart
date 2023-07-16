class Citiy {
  final String name;
  final int id;
  final Translations translation;
  Citiy({required this.translation, required this.name, required this.id});
}

class Translations {
  final String locale;
  final String name;
  Translations({required this.locale, required this.name});
}
