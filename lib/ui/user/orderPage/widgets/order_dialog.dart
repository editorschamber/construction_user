import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/orderPage/controller/order_controller.dart';

class OrderDialog extends StatelessWidget {
  const OrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();

    return AlertDialog(
      title: const Text('Add Order'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: orderController.materialNameController,
              decoration: const InputDecoration(labelText: 'Material Name'),
            ),
            TextField(
              controller: orderController.quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            Obx(() {
              return DropdownButton<String>(
                hint: const Text('Select Supplier'),
                value: orderController.selectedSupplier.value.isNotEmpty
                    ? orderController.selectedSupplier.value
                    : null,
                onChanged: (newValue) {
                  orderController.selectedSupplier.value = newValue!;
                },
                items: orderController.orders
                    .map((order) => DropdownMenuItem<String>(
                  value: order.supplierName,
                  child: Text(order.supplierName),
                ))
                    .toList(),
              );
            }),
            ElevatedButton(
              onPressed: () async {
                await orderController.pickImage();
              },
              child: const Text('Pick Image'),
            ),
            if (orderController.pickedImage != null)
              Column(
                children: [
                  Text(
                    orderController.pickedImage!.path.split('/').last,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Image.file(
                    orderController.pickedImage!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            orderController.addOrder();
            Get.back();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}