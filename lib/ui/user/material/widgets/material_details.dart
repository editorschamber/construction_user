import 'package:flutter/material.dart';

class MaterialDetails extends StatefulWidget {
  final List<Map<String, String>> members;

  const MaterialDetails({super.key, required this.members});

  @override
  State<MaterialDetails> createState() => _MaterialDetailsState();
}

class _MaterialDetailsState extends State<MaterialDetails> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: widget.members.length, // Number of items in the grid
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(Icons.image, size: 50),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${widget.members[index]['stockName']}',
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        );
      },
    );
  }
}
