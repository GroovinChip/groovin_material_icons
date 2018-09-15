import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:groovin_material_icons_testapp/icon_map.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  var fabIcon = GroovinMaterialIcons.flutter;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(fabIcon),
      ),
    );
  }
}

class IconCard extends StatefulWidget {
  final String title;
  final IconData icon;

  const IconCard({
    Key key,
    this.title,
    this.icon,
  }) : super(key: key);

  @override
  IconCardState createState() {
    return new IconCardState();
  }
}

class IconCardState extends State<IconCard> {
  double elevation = 0.0;
  double iconSize = 35.0;

  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          //elevation = (elevation == 0.0) ? 5.0 : 0.0;
          iconSize += 1;
        });
        await Future.delayed(Duration(milliseconds: 200));
        setState(() {
          // elevation = (elevation == 0.0) ? 5.0 : 0.0;
          iconSize -= 1;
        });
      },
      child: Card(
        elevation: elevation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.icon,
                size: iconSize,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: fontWeight),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
