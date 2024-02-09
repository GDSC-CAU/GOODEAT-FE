class NativeModel {
  final String native;

  NativeModel.fromJson(Map<String, dynamic> json)
      : native = json['languageName'];
}
