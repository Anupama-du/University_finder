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
        backgroundColor: const Color.fromARGB(255, 5, 109, 50),
        centerTitle: true,
        title: const Text(
          "Campus Connect",
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
              'https://freesvg.org/img/1541106620.png',
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
                    color: Color.fromARGB(255, 5, 109, 50),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 5, 109, 50),
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
                    const Color.fromARGB(255, 5, 109, 50),
                  ),
                ),
                onPressed: () {
                  if (countryController.text.isNotEmpty) {
                    Navigator.pushNamed(context, 'result');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color.fromARGB(255, 5, 105, 49),
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