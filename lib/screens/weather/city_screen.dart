import 'package:flutter/material.dart';


// city name input page for geting weather
class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.place,
                  color: Colors.black45,
                ),
                hintText: 'City Name',
                hintStyle: TextStyle(
                  color: Colors.black45,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                cityName = value;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                Future.delayed(const Duration(milliseconds: 300))
                    .whenComplete(() {
                  Navigator.pop(context, cityName);
                });
              },
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        highlightColor: Colors.transparent,
        splashRadius: 27.5,
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
