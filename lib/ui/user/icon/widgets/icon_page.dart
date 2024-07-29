import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class IconPage extends GetView {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height ,
      width: width,
      child: _IconTilesWidget(),
    );
  }

  Widget _IconTilesWidget() {
    final List<String> items = ["Notification 1", "Notification 2", "Notification 3"];
    return ListView.builder(itemCount: items.length,itemBuilder: (context , index){
      return ListTile(
        title: Text(items[index]),
        onTap: () {
          // Handle tap
        },
      );
    });
  }
}
