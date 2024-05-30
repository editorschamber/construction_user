import 'package:flutter/material.dart';

import '../models/site.dart';

class CardsPage extends StatelessWidget {
  final Site site;
  final VoidCallback onTap;

  const CardsPage({super.key, required this.site, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                site.imageUrl, // Replace with your image URL
                height: 150,
                width: width,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        site.siteName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        site.siteDetails,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Icon(Icons.location_searching),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(site.location),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
