import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onClear;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final AssetImage? prefixImage;
  final IconData? prefixIcon;
  final bool showClearButton;

  const CustomInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.onClear,
    this.onTap,
    this.readOnly = false,
    this.prefixImage,
    this.prefixIcon,
    this.showClearButton = true,
    this.onChanged,
  })  : assert(prefixImage != null || prefixIcon != null,
            "You must provide either a prefixImage or prefixIcon.");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD5F2C8), 
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            if (prefixImage != null) _buildPrefixImage(),
            if (prefixIcon != null) _buildPrefixIcon(),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelText,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.green, 
                    ),
                  ),
                  TextField(
                    controller: controller,
                    readOnly: readOnly,
                    onTap: onTap,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        color: Colors.grey, 
                        fontFamily: 'Poppins', 
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                      isDense: true, 
                    ),
                  ),
                ],
              ),
            ),
            if (onClear != null)
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.black),
                onPressed: onClear,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrefixImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image(
        image: prefixImage!,
        width: 32.0,
        height: 32.0, 
      ),
    );
  }

  Widget _buildPrefixIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        prefixIcon,
        size: 32.0, 
        color: Colors.green, 
      ),
    );
  }
}
