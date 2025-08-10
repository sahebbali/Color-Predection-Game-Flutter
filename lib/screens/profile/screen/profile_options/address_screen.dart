import 'package:color_predection_game/screens/profile/screen/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  var history = <Address>[].obs;

  void addAddress(Address address) {
    history.insert(0, address);
    Get.snackbar(
      "Success",
      "Address added successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  final AddressController controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Addresses"),
        backgroundColor: Colors.purple.shade600,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(() => AddressFormScreen());
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: Obx(() {
        if (controller.history.isEmpty) {
          return const Center(child: Text("No addresses saved"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.history.length,
          itemBuilder: (context, index) {
            final address = controller.history[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${address.fullName}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Mobile: ${address.mobileNumber}"),
                    Text("City: ${address.city}"),
                    Text("State: ${address.state}"),
                    Text("Pincode: ${address.pincode}"),
                    Text("Address: ${address.detailAddress}"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class AddressFormScreen extends StatelessWidget {
  AddressFormScreen({super.key});

  final AddressController controller = Get.find();

  final fullNameController = TextEditingController();
  final mobileController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final detailAddressController = TextEditingController();

  void saveAddress() {
    if (fullNameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        pincodeController.text.isEmpty ||
        detailAddressController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    controller.addAddress(
      Address(
        fullName: fullNameController.text,
        mobileNumber: mobileController.text,
        city: cityController.text,
        state: stateController.text,
        pincode: pincodeController.text,
        detailAddress: detailAddressController.text,
      ),
    );

    Get.to(() => AddressScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Address"),
        backgroundColor: Colors.purple.shade600,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField("Full Name", Icons.person, fullNameController),
            const SizedBox(height: 12),
            _buildTextField(
              "Mobile Number",
              Icons.phone,
              mobileController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _buildTextField("Town/City", Icons.location_city, cityController),
            const SizedBox(height: 12),
            _buildTextField("State", Icons.map, stateController),
            const SizedBox(height: 12),
            _buildTextField(
              "Pincode",
              Icons.pin,
              pincodeController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              "Detailed Address",
              Icons.home,
              detailAddressController,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: saveAddress,
                child: const Text(
                  "Save Address",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
