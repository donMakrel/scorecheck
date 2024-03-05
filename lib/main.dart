import 'package:flutter/material.dart';
import 'package:scorecheck/model/tournament.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scorecheck/presentation/pages/details_page.dart';
import 'package:scorecheck/presentation/typography.dart';
import 'package:scorecheck/presentation/widget/info_row_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.indigo),
      home: const ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  TextEditingController searchController = TextEditingController();
  List<Tournament> allMatches = [];
  List<Tournament> matches = [];
  int teamId = 55;

  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  fetchMatches() async {
    var response = await http.get(
      Uri.parse(
          'https://api-football-v1.p.rapidapi.com/v3/fixtures?league=39&season=2021&team=$teamId&from=2021-12-01&to=2021-12-16'),
      headers: {
        'x-rapidapi-key': 'API-KEY-HERE',
        'x-rapidapi-host': 'api-football-v1.p.rapidapi.com'
      },
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        allMatches = (data['response'] as List)
            .map((e) => Tournament.fromJson(e))
            .toList();
        matches = allMatches;
      });
    }
  }

  void _updateFilteredMatches() {
    final searchQuery = searchController.text.toLowerCase();
    setState(() {
      if (searchQuery.isEmpty) {
        matches = allMatches;
      } else {
        matches = allMatches.where((tournament) {
          return tournament.homeName.toLowerCase().contains(searchQuery);
        }).toList();
      }
    });
  }

  void _sortListAscendingByName() {
    setState(() {
      matches.sort((a, b) => a.homeName.compareTo(b.homeName));
    });
  }

  void _sortListDescendingByName() {
    setState(() {
      matches.sort((a, b) => b.homeName.compareTo(a.homeName));
    });
  }

  void _sortListAscendingByDate() {
    setState(() {
      matches.sort((a, b) => a.date.compareTo(b.date));
    });
  }

  void _sortListDescendingByDate() {
    setState(() {
      matches.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void _changeTeam(int newTeamId) {
    setState(() {
      teamId = newTeamId;
      fetchMatches(); // Ponowne wczytanie meczów z nowym teamId
    });
  }

 void _sortProductsAlphabetically() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sortuj', style: AppTypography.titleStyle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Po nazwie od A do Z',
                    style: AppTypography.basicStyle),
                onTap: () {
                  _sortListAscendingByName();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Po nazwie od Z do A',
                    style: AppTypography.basicStyle),
                onTap: () {
                  _sortListDescendingByName();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Po dacie zapisów od najnowszych',
                    style: AppTypography.basicStyle),
                onTap: () {
                  _sortListDescendingByDate();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Po dacie zapisów od najstarszych',
                    style: AppTypography.basicStyle),
                onTap: () {
                  _sortListAscendingByDate();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Zmień drużynę na Tottenham', style: AppTypography.basicStyle),
                onTap: () {
                  _changeTeam(47); // Zmiana teamId na 47
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Zmień drużynę na Brentford', style: AppTypography.basicStyle),
                onTap: () {
                  _changeTeam(55); // Zmiana teamId na 55
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
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
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
          const SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Align items to the start and end of the row
                  children: [
                    const Text(
                      'Dostępne mecze',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF080A38),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          _sortProductsAlphabetically();
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.sort,
                              color: Color(0xFF3C58F9),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Sortuj',
                              style: TextStyle(
                                color: Color(0xFF3C58F9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 55.0,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    hintStyle: const TextStyle(fontSize: 14),
                    hintText: 'Wyszukaj mecz',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (text) {
                    _updateFilteredMatches();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: matches.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      final tournament = matches[index];
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 24.0,
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    top: 5.0,
                                  ),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        tournament.homeName,
                                        style: AppTypography.titleStyle,
                                      ),
                                      Text(
                                        tournament.awayName,
                                        style: AppTypography.titleStyle,
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('dd.MM.yyyy').format(
                                            DateTime.parse(tournament.date)),
                                        style: GoogleFonts.karla(
                                          color: Colors.grey,
                                          height: 1.5,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                      InfoRowWidget(
                                        label: "Miasto",
                                        value: tournament.city,
                                      ),
                                      const SizedBox(height: 14),
                                      InfoRowWidget(
                                        label: "Stadion",
                                        value: tournament.stadium,
                                      ),
                                      const SizedBox(height: 14),
                                      InfoRowWidget(
                                        label: "Sędzia",
                                        value: tournament.referee,
                                      ),
                                      const SizedBox(height: 14),
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsPage(
                                                        tournament: tournament),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF3C58F9),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 15.0, bottom: 15.0),
                                          ),
                                          child: Text(
                                            'Statystyki',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.karla(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
