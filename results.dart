import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:anu/home.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'home.dart';

class MyResult extends StatefulWidget {
  const MyResult({super.key});

  @override
  State<MyResult> createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  var session = [];
  var filteredSession = [];
  var country = '';
  var listC = 0;
  bool _isLoading = true;

  @override
  void initState() {
    country = MyHome.country;
    getData();
    super.initState();
  }

  getData() async {
    var url =
    Uri.parse('http://universities.hipolabs.com/search?country=$country');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      setState(() {
        session = decodedData;
        filteredSession = session;
        _isLoading = false;
      });

      setState(() {
        listC = session.length;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to filter universities based on the search query
  void filterUniversities(String query) {
    setState(() {
      filteredSession = session.where((university) {
        final name = university['name']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 109, 50),
        centerTitle: true,
        title: const Text(
          "Fetched Data",
          style: TextStyle(color: Color.fromARGB(255, 243, 238, 238)),
        ),
        // Add the search bar to the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: UniversitySearch(session));
            },
          ),
        ],
      ),
      body: _isLoading
          ? _buildShimmerEffect() // Check if data is still loading
          : StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          "Total Universities: ${filteredSession.length}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredSession
                              .length, // Use the filtered list here
                          itemBuilder: (BuildContext context, int index) {
                            final university = filteredSession[
                            index]; // Use the filtered list here
                            return cardWidget(university, index);
                          },
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }

  cardWidget(var university, int index) {
    return Container(
      height: 170,
      margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 118, 208, 144),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 170,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0)),
              color: Color.fromARGB(255, 3, 96, 25),
            ),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    university['name'] ?? '',
                    style: const TextStyle(fontSize: 17, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(
                    indent: 50,
                    endIndent: 50,
                    color: Color.fromARGB(255, 3, 96, 25),
                    thickness: 2,
                  ),
                  if (university['state-province'] != null)
                    RichText(
                      text: TextSpan(
                        style:
                        const TextStyle(fontSize: 15, color: Colors.black),
                        text: "State: ",
                        children: <TextSpan>[
                          TextSpan(
                            text: university['state-province'] ?? '',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  if (university['country'] != null)
                    Text(university['country'] ?? ''),
                  if (university['alpha_two_code'] != null)
                    Text(university['alpha_two_code'] ?? ''),
                  if (university['web_pages'] != null)
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(university['web_pages']
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '')));
                      },
                      child: Text(
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 8, 31, 180),
                            decoration: TextDecoration.underline),
                        university['web_pages']
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', ''),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the shimmer effect
  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (ctx, i) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 30,
            ),
            title: Container(
              height: 12,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            subtitle: Container(
              height: 10,
              width: 200,
              color: Colors.grey[300],
            ),
          ),
        );
      },
    );
  }
}

// Search delegate for the University search
class UniversitySearch extends SearchDelegate {
  final List<dynamic> universities;

  UniversitySearch(this.universities);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: universities.length,
      itemBuilder: (BuildContext context, int index) {
        final university = universities[index];
        return ListTile(
          title: Text(university['name'] ?? ''),
          subtitle: Text(university['country'] ?? ''),
          onTap: () {
            close(context, university);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> suggestionList = query.isEmpty
        ? universities
        : universities.where((university) {
      final name = university['name']?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        final university = suggestionList[index];
        return ListTile(
          title: Text(university['name'] ?? ''),
          subtitle: Text(university['country'] ?? ''),
          onTap: () {
            close(context, university);
          },
        );
      },
    );
  }
}