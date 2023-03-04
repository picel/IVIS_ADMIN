class Application {
  final String intro;
  final List<String> language;
  final String project;
  final String etc;

  Application({
    required this.intro,
    required this.language,
    required this.project,
    required this.etc,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      intro: json['intro'],
      language: List<String>.from(json['language'].map((x) => x)),
      project: json['project'],
      etc: json['etc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'intro': intro,
      'language': List<dynamic>.from(language.map((x) => x)),
      'project': project,
      'etc': etc,
    };
  }
}
