import 'package:flutter/material.dart';
import 'package:site_construct/ui/user/siteEmployee/widgets/site_employee_details.dart';

class SiteEmployeeList extends StatefulWidget {
  const SiteEmployeeList({super.key});

  @override
  State<SiteEmployeeList> createState() => _SiteEmployeeListState();
}

class _SiteEmployeeListState extends State<SiteEmployeeList> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: SiteEmployeeDetails()),
    );
  }
}
