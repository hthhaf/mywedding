class FrameModel {
  final String url;
  final String? name;

  FrameModel({required this.url, this.name});

  factory FrameModel.fromStorage(String url, {String? name}) {
    return FrameModel(url: url, name: name);
  }

  factory FrameModel.fromJson(Map<String, dynamic> json) {
    return FrameModel(
      url: json['url'] as String,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
      };

  @override
  String toString() => 'FrameModel(name: $name, url: $url)';
}
