class Statistic {
  final dynamic value;
  final String? type;


  Statistic({
    required this.value,
    required this.type,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      value: json['value'],
      type: json['type'],
    );
  }
}
