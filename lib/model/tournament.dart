class Tournament {
  final int id;
  final String homeName;
  final String awayName;
  final int homeId;
  final int awayId;
  final String city;
  final String stadium;
  final String referee;
  final String date;

  Tournament({
    required this.id,
    required this.homeName,
    required this.awayName,
    required this.homeId,
    required this.awayId,
    required this.city,
    required this.stadium,
    required this.referee,
    required this.date,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['fixture']['id'],
      homeName: json['teams']['home']['name'],
      awayName: json['teams']['away']['name'],
      homeId: 0,
      awayId: 0,
      city: json['fixture']['venue']['city'],
      stadium: json['fixture']['venue']['name'],
      referee: json['fixture']['referee'],
      date: json['fixture']['date'],
    );
  }
}
