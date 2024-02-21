class ScriptModel {
  final String userScript, originScript;

  ScriptModel.fromJson(Map<String, dynamic> json)
      : userScript = json['userScript'],
        originScript = json['originScript'];
}
