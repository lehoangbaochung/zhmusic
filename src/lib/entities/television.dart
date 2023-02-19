class Television {
  final Iterable<String>? stickers;
  final Iterable<String> informations;

  Television({
    this.stickers,
    required this.informations,
  });

  factory Television.fromJson(Map<String, dynamic> fields) {
    return Television(
      informations: [],
    );
  }
}
