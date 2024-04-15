import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parkassist/models/park_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? t;
  @override
  void initState() {
    t = new Timer.periodic(const Duration(seconds: 5),
        (t) => Provider.of<ParkModel>(context, listen: false).getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Provider.of<ParkModel>(context, listen: false).getData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("Parking",style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ParkModel>(
            builder: (context, val, _) => val.parking_data.length == 0
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 50,
                        mainAxisSpacing: 20,
                        childAspectRatio: 3 / 1.6),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (val.parking_data[index]) {
                          val.bookPark(index);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [Colors.grey.shade300, Colors.white],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight),
                            border: val.index == index
                                ? Border.all(color: Colors.amber, width: 3)
                                : null),
                        child: val.parking_data[index]
                            ? Center(
                                child: Text((index + 1).toString()),
                              )
                            : Image.asset("assets/images/car.jpg"),
                      ),
                    ),
                    itemCount: val.parking_data.length,
                  ),
          ),
        ),
        floatingActionButton: Consumer<ParkModel>(
          builder: (context, val, _) => ElevatedButton(
            onPressed: val.isSelected
                ? () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 50.0,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Booking Confirmed',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
            child: Text(
              "Book",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    val.isSelected ? Colors.amber : Colors.grey),
                minimumSize: MaterialStateProperty.all(Size(width * .8, 50))),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
