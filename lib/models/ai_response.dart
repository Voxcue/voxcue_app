class AIResponse {
  final String answer;
  final List<Source> sources;

  AIResponse({required this.answer, required this.sources});

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    var sourcesJson = json['sources'] as List;
    List<Source> sourcesList = sourcesJson.map((i) => Source.fromJson(i)).toList();

    return AIResponse(
      answer: json['answer'],
      sources: sourcesList,
    );
  }
}

class Source {
  final String content;
  final Metadata metadata;

  Source({required this.content, required this.metadata});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      content: json['content'],
      metadata: Metadata.fromJson(json['metadata']),
    );
  }
}

class Metadata {
  final int id;
  final double similarity;

  Metadata({required this.id, required this.similarity});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      id: json['id'],
      similarity: json['similarity'],
    );
  }
}