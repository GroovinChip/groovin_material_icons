import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:groovin_material_icons_testapp/icon_map.dart';

import 'icon_display.dart';

class IconSearch extends SearchDelegate<String> {
  List<String> recentSearches = [];

  ///a [List] of Icons, usually, that will show up at the end of the search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(GroovinMaterialIcons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  ///a [List] of Icons, usually, that will show up at the beginning of the search bar.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
        child: IconDisplay(
      title: query,
      iconData: iconMap[query],
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList =
        iconMap.keys.where((iconName) => iconName.contains(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: iconMap.containsKey(suggestionList[index])
              ? Icon(iconMap[suggestionList[index]])
              : Icon(GroovinMaterialIcons.border_none),
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
