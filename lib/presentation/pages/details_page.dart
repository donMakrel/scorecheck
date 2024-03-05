import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scorecheck/main.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scorecheck/model/statistic.dart';
import 'package:scorecheck/model/statistics.dart';
import 'package:scorecheck/model/tournament.dart';
import 'package:scorecheck/presentation/widget/details_row_widget.dart';
import 'package:scorecheck/presentation/widget/info_row_widget.dart';
import 'package:scorecheck/presentation/typography.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final Tournament tournament;

  const DetailsPage({Key? key, required this.tournament}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<Statistic> statisticsHome = [];
  List<Statistic> statisticsAway = [];
  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  fetchMatches() async {
    var response = await http.get(
      Uri.parse(
          'https://api-football-v1.p.rapidapi.com/v3/fixtures/statistics?fixture=${widget.tournament.id}'),
      headers: {
        'x-rapidapi-key': '82796156b2mshc03ecd095d6d1c0p13c26fjsnc974c2cea9bd',
        'x-rapidapi-host': 'api-football-v1.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        // Wydruk odpowiedzi JSON w konsoli
        print(data);

        var homeTeamData = data['response'][0]['statistics'] as List;
        var awayTeamData = data['response'][1]['statistics'] as List;

        statisticsHome =
            homeTeamData.map((e) => Statistic.fromJson(e)).toList();
        statisticsAway =
            awayTeamData.map((e) => Statistic.fromJson(e)).toList();

      });
    } else {
      // Możesz również dodać wydruk w przypadku błędu
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "scorecheck",
            style: GoogleFonts.poppins(
              letterSpacing: -2,
              color: const Color(0xFF3C58F9),
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              "Statystyki meczu",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF080A38),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const MyApp(),
                //         ),
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       padding: const EdgeInsets.symmetric(
                //           vertical: 16, horizontal: 8),
                //       backgroundColor: Colors.white,
                //       foregroundColor: const Color(0xFF3C58F9),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         side: const BorderSide(
                //           color: Color(0xFF3C58F9),
                //         ),
                //       ),
                //     ),
                //     child: Text(
                //       'test1',
                //       textAlign: TextAlign.center,
                //       style: GoogleFonts.karla(
                //         fontStyle: FontStyle.normal,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 14.0,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 16), // Dodany odstęp między przyciskami
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const MyApp(),
                //         ),
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       padding: const EdgeInsets.all(16.0),
                //       backgroundColor: const Color(0xFF3C58F9),
                //       foregroundColor: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         side: const BorderSide(
                //           color: Color(0xFF3C58F9),
                //         ),
                //       ),
                //     ),
                //     child: Text(
                //       'Test2',
                //       maxLines: 1,
                //       style: GoogleFonts.karla(
                //         fontStyle: FontStyle.normal,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 14.0,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 26.0,
                  vertical: 18.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF3C58F9),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 30,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 3,
                ),
                child: Card(
                  elevation: 1.5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 24.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the value as needed
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Szczegóły",
                          style: AppTypography.titleStyle,
                        ),
                        const SizedBox(height: 18),
                        Column(
                          children: List.generate(
                            statisticsHome.length,
                            (index) => DetailsRowWidget(
                              leftStats: ( statisticsHome
                                  .elementAt(index)
                                  .value ?? 0 )
                                  .toString(),
                              centerInfo: statisticsHome
                                  .elementAt(index)
                                  .type
                                  .toString(),
                              rightStats:(  statisticsAway
                                  .elementAt(index)
                                  .value ?? 0)
                                  .toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
