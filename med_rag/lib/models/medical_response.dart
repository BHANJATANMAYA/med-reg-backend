class MedicalResponse {
  final String answer;
  final List<String> sources;
  final String intent;
  final String? riskLevel;
  final double? confidence;

  const MedicalResponse({
    required this.answer,
    required this.sources,
    required this.intent,
    this.riskLevel,
    this.confidence,
  });


  factory MedicalResponse.fromJson(Map<String, dynamic> json) {
  final rawSources = json['sources'] as List<dynamic>? ?? [];

  final sources = rawSources.map((e) {
    if (e is String) return e;
    if (e is Map<String, dynamic>) return e['url']?.toString() ?? '';
    return e.toString();
  }).toList();

  return MedicalResponse(
    answer: json['answer']?.toString() ?? '',
    sources: sources,
    intent: json['intent']?.toString() ?? 'general',
    riskLevel: json['risk_level']?.toString(),
    confidence: (json['confidence'] as num?)?.toDouble(),
  );
}
}
