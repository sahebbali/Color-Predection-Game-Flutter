import 'package:flutter/material.dart';

// import 'package:your_app/utils/app_colors.dart';

// The function is now public (no underscore)
void showConfirmationDialog(BuildContext context, String selection) {
  // --- State variables for the dialog ---
  final List<int> contractMoneyOptions = [10, 100, 1000, 10000];
  int selectedContractMoney = contractMoneyOptions[0]; // Default to 10
  int quantity = 1;
  bool isAgreed = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Use StatefulBuilder to manage state within the dialog
      return StatefulBuilder(
        builder: (context, setState) {
          int totalContractMoney = selectedContractMoney * quantity;

          return AlertDialog(
            title: Text("Select $selection"), // Dynamic title
            contentPadding: const EdgeInsets.all(16.0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Contract Money Section ---
                  const Text(
                    "Contract Money",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    // Wrap with SizedBox to allow it to fill the width
                    width: double.infinity,
                    child: ToggleButtons(
                      // List of widgets to display for each button
                      isSelected: contractMoneyOptions
                          .map((amount) => selectedContractMoney == amount)
                          .toList(),

                      // The callback when a button is tapped
                      onPressed: (int index) {
                        // The index of the tapped button is provided.
                        // Update the state with the new selected amount.
                        setState(() {
                          selectedContractMoney = contractMoneyOptions[index];
                        });
                      },

                      // --- Styling to match your image ---
                      borderRadius: BorderRadius.circular(8.0),

                      // Colors for the SELECTED button
                      fillColor: Colors
                          .grey[700], // Background color of the selected button
                      selectedColor:
                          Colors.white, // Text color of the selected button
                      // Colors for the UNSELECTED buttons
                      color:
                          Colors.grey[600], // Text color of unselected buttons
                      // Border styling
                      borderColor: Colors.grey[400],
                      selectedBorderColor: Colors.grey[600],
                      borderWidth: 1.0,

                      // Ensures the buttons are reasonably sized
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 50.0, // Adjust this if needed
                      ),
                      // List of widgets to display for each button
                      children: contractMoneyOptions
                          .map((amount) => Text('$amount'))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Quantity Selector Section ---
                  const Text(
                    "Number",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Decrease Button
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) {
                              quantity--;
                            }
                          });
                        },
                        child: const Icon(Icons.remove),
                      ),
                      // Quantity Display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Increase Button
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- Total Money Display ---
                  Text("Total contract money is $totalContractMoney"),
                  const SizedBox(height: 10),

                  // --- Agreement Checkbox ---
                  Row(
                    children: [
                      Checkbox(
                        value: isAgreed,
                        onChanged: (bool? value) {
                          setState(() {
                            isAgreed = value ?? false;
                          });
                        },
                      ),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(text: 'I agree '),
                              TextSpan(
                                text: 'PRESALE RULE',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: isAgreed
                    ? () {
                        print(
                          "Confirmed! Selection: $selection, Money: $selectedContractMoney, Quantity: $quantity, Total: $totalContractMoney",
                        );
                        Navigator.of(context).pop();
                      }
                    : null,
                child: const Text("CONFIRM"),
              ),
            ],
          );
        },
      );
    },
  );
}
