import 'package:flutter/material.dart';

class IconDisplay extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool showAppBar;

  IconDisplay(
      {@required this.title, @required this.iconData, this.showAppBar = false});

  final List<Color> colorList = [
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
        ? AppBar(
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          toolbarOpacity: 1.0,
          title: Text(
            title,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        )
        : null,
      body: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: colorList.length,
              itemBuilder: (BuildContext context, int index) {
                double iconSize = (index + 1) * 35.toDouble();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    iconData,
                    color: colorList[index],
                    size: iconSize,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
