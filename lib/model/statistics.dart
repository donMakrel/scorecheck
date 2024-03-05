import 'package:scorecheck/model/statistic.dart';

class Statistics {
  final List <Statistic> teamHome;
  final List <Statistic> teamAway;

  Statistics({
    required this.teamHome,
    required this.teamAway,
  });

  factory Statistics.fromJson(List<dynamic> json) {
    return Statistics(
      teamHome: json[0],
      teamAway: json[1],
    );
  }
}
