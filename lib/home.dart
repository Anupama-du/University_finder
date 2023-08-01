import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  static String country = "";

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 255),
        centerTitle: true,
        title: const Text(
          "University Finder",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(
              height: 130,
            ),
            Image.network(
              'https://cdn.pixabay.com/photo/2017/06/22/02/16/computer-icon-2429310_1280.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: countryController,
              onChanged: (data) {
                MyHome.country = data;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Enter Country Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 0, 200),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 0, 200),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 0, 200),
                  ),
                ),
                onPressed: () {
                  if (countryController.text.isNotEmpty) {
                    Navigator.pushNamed(context, 'result');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color.fromARGB(255, 0, 0, 200),
                        content: Text(
                          'Please Enter any Country name',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Search',
                    style: TextStyle(color: Color.fromARGB(255, 243, 238, 238)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}