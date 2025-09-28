import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:site_construct/routes/route.dart';
import 'package:site_construct/ui/user/employeeDetails/models/employee_model.dart';
import 'package:site_construct/ui/user/employeeDetails/widgets/employee_details.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  final List<EmployeeModel> model = [
    EmployeeModel(
      siteName: 'Site 1',
      employeeDetails: 'Details about Site 1',
    ),
    EmployeeModel(
      siteName: 'Site 2',
      employeeDetails: 'Location 2',
    ),
    EmployeeModel(
      siteName: 'Site 3',
      employeeDetails: 'Location 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ListView.builder(
            itemCount: model.length,
            itemBuilder: (context, index) {
              return EmployeeDetails(
                model: model[index],
                onTap: () {
                  Get.toNamed(siteEmployeeList);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
