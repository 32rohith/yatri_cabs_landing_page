
import 'package:flutter/material.dart';

class FormBody extends StatelessWidget {
  final List<Widget> fields;

  const FormBody({super.key, required this.fields});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8.0)],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ...fields,
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            ),
            child: const Text("Explore Cabs",
             style: TextStyle(fontSize: 18.0,color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
