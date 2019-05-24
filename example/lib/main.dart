import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:groovin_material_icons_testapp/icon_map.dart';
import 'package:groovin_material_icons_testapp/search.dart';
import 'package:url_launcher/url_launcher.dart';

import 'icon_display.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/foundation.dart';

void main() {
  _setTargetPlatformForDesktop();
  runApp(MyApp());
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GMI Companion',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'GMI Companion'),
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
      IconCard(
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
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: (){
            showModalBottomSheet(
              context: context,
              builder: (builder){
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 5.0,
                                width: 25.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(10.0),
                                      topRight: const Radius.circular(10.0),
                                      bottomLeft: const Radius.circular(10.0),
                                      bottomRight: const Radius.circular(10.0),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: Icon(GroovinMaterialIcons.information_variant, color: Colors.black,),
                          title: Text("Package Version: 1.1.4"),
                        ),
                        Material(
                          child: ListTile(
                            leading: Icon(GroovinMaterialIcons.dart_logo, color: Colors.blue,),
                            title: Text("View on Pub"),
                            onTap: (){
                              launch("https://pub.dartlang.org/packages/groovin_material_icons");
                            },
                          ),
                        ),
                        ListTile(
                          leading: Icon(GroovinMaterialIcons.creation, color: Colors.black,),
                          title: Text("Special Thanks to:"),
                          subtitle: Text("Miyoyo, Matthew Evans, and ThinkDigital"),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 0.0,
                        ),
                        ListTile(
                          leading: Icon(GroovinMaterialIcons.flutter, color: Colors.blue),
                          title: Text("Get Started with Flutter"),
                          onTap: (){
                            launch("https:flutter.io");
                          },
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 0.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(GroovinMaterialIcons.twitter, color: Colors.blue),
                              onPressed: (){
                                launch("https:twitter.com/GroovinChipDev");
                              },
                            ),
                            IconButton(
                              icon: Icon(GroovinMaterialIcons.github_circle),
                              onPressed: (){
                                launch("https:github.com/GroovinChip");
                              },
                            ),
                            IconButton(
                              icon: Icon(GroovinMaterialIcons.gmail),
                              color: Colors.red,
                              onPressed: (){
                                launch("mailto:groovinchip@gmail.com");
                              },
                            ),
                            IconButton(
                              icon: Icon(GroovinMaterialIcons.discord, color: Colors.deepPurpleAccent),
                              onPressed: (){
                                launch("https://discord.gg/CFnBRue");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: IconSearch());
            },
          ),
        ],
      ),
      body: DraggableScrollbar.rrect(
        backgroundColor: Colors.indigo,
        controller: scrollController,
        child: GridView.builder(
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
