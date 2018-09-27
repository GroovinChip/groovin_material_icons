import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons_testapp/icon_map.dart';
import 'package:groovin_material_icons_testapp/search.dart';

import 'icon_display.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'GroovinMaterialIcons Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var scrollController = ScrollController();
  var fabIcon = Icons.search;
  Function refreshFab;
  var iconList;

  @override
  void initState() {
    iconList = iconMap
        .map((title, icon) => MapEntry(
        title,
        new IconCard(
          title: title,
          icon: icon,
        )))
        .values
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var crossAxisCount = (MediaQuery.of(context).size.width / 150).ceil();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: IconSearch());
              })
        ],
      ),
      body: DraggableScrollbar.rrect(
        backgroundColor: Theme.of(context).primaryColor,
        controller: scrollController,
        child: GridView.builder(
          physics: PageScrollPhysics(),
          controller: scrollController,
          padding: EdgeInsets.all(10.0),
          itemCount: iconMap.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, int index) {
            return iconList[index];
          },
        ),
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const IconCard({
    Key key,
    this.title,
    this.icon,
  }) : super(key: key);

  final double elevation = 0.0;
  final double iconSize = 35.0;

  final FontWeight fontWeight = FontWeight.w300;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(icon),
              iconSize: iconSize,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return IconDisplay(
                    title: title,
                    iconData: icon,
                    showAppBar: true,
                  );
                }));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: fontWeight),
              ),
            )
          ],
        ),
      ),
    );
  }
}
