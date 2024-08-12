class LinksModel {
  final String first;
  final String last;
  final String self;
  final String? next;
  final String? prev;

  LinksModel({
    required this.first,
    required this.last,
    required this.self,
    this.next,
    this.prev,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      first: json['first'],
      last: json['last'],
      self: json['self'],
      next: json['next'],
      prev: json['prev'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'self': self,
      'next': next,
      'prev': prev,
    };
  }
}