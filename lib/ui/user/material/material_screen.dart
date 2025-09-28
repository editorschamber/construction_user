import 'package:flutter/material.dart';
import 'package:site_construct/apiServices/materialService.dart';
import 'package:site_construct/ui/user/material/widgets/material_details.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  final MaterialService _materialService = MaterialService();
  bool _isFetching = true; // For the initial fetch
  List<Map<String, String>> materials = []; // Start with an empty list

  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getMaterials();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  Future<void> _getMaterials() async {
    setState(() {
      _isFetching = true;
    });
    try {
      final response = await _materialService.getMaterials();
      final List<dynamic> fetchedMaterials = response['data'];
      setState(() {
        materials = fetchedMaterials.map((mat) {
          return {
            'stockName': mat['materialName'].toString(),
          };
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch materials: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isFetching = false;
        });
      }
    }
  }

  void _showAddMaterialDialog() {
    _nameController.clear();
    _quantityController.clear();
    _unitController.clear();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        bool isDialogLoading = false;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add New Material'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Material Name'),
                    readOnly: isDialogLoading,
                  ),
                  TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    readOnly: isDialogLoading,
                  ),
                  TextField(
                    controller: _unitController,
                    decoration: const InputDecoration(labelText: 'Unit'),
                    readOnly: isDialogLoading,
                  ),
                  if (isDialogLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: isDialogLoading
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                ),
                TextButton(
                  child: const Text('Add'),
                  onPressed: isDialogLoading
                      ? null
                      : () async {
                          final name = _nameController.text;
                          final quantity =
                              int.tryParse(_quantityController.text);
                          final unit = _unitController.text;

                          if (name.isEmpty ||
                              quantity == null ||
                              unit.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill all fields')),
                            );
                            return;
                          }

                          setDialogState(() {
                            isDialogLoading = true;
                          });

                          try {
                            await _materialService.createMaterial(
                              materialName: name,
                              approvedQuantity: quantity,
                              unit: unit,
                            );
                            Navigator.of(context).pop(); // Close dialog
                            await _getMaterials(); // Refresh list
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Failed to add material: $e')),
                            );
                            setDialogState(() {
                              isDialogLoading = false;
                            });
                          }
                        },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isFetching
            ? const Center(child: CircularProgressIndicator())
            : MaterialDetails(
                members: materials,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMaterialDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
