// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import 'my_textfield.dart';

final cityProvider = StateProvider<String>((ref) => '');

class CityField extends ConsumerStatefulWidget {
  final String imageurl;
  final String labelText;
  final String hintText;
  final StateProvider<String> cityProvider; 
  final TextEditingController controller;
  final VoidCallback? onClear;

  const CityField({
    super.key,
    required this.imageurl,
    required this.labelText,
    required this.hintText,
    required this.cityProvider, 
    required this.controller,
    this.onClear,
  });

  @override
  _CityFieldState createState() => _CityFieldState();
}

class _CityFieldState extends ConsumerState<CityField> {
  bool _showSuggestions = false;
  List<String> _citySuggestions = [];  
  late TextEditingController _controller; 

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchCitySuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _citySuggestions = []; 
        _showSuggestions = false;
      });
      return;
    }

    try {
      final results = await CityApiService.fetchCitySuggestions(query);
      setState(() {
        _citySuggestions = results; 
        _showSuggestions = true; 
      });
    } catch (e) {
      setState(() {
        _citySuggestions = []; 
        _showSuggestions = false;
      });
    }
  }

  void _onSuggestionSelected(String suggestion) {
    _controller.text = suggestion;
    _controller.selection = TextSelection.collapsed(offset: suggestion.length); 

    ref.read(widget.cityProvider.notifier).state = suggestion;

    setState(() {
      _showSuggestions = false; 
    });
  }

  void _clearInput() {
    _controller.clear(); 
    ref.read(widget.cityProvider.notifier).state = '';  
    setState(() {
      _showSuggestions = false;  
    });

    if (widget.onClear != null) {
      widget.onClear!(); 
    }
  }

  void _dismissSuggestions() {
    setState(() {
      _showSuggestions = false;
    });
  }

  Future<bool> _onWillPop() async {
    _dismissSuggestions();  
    return true;  
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,  
      child: GestureDetector(
        onTap: () {
          _dismissSuggestions();  
          FocusScope.of(context).unfocus(); 
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputField(
              prefixImage: AssetImage(widget.imageurl),
              labelText: widget.labelText,
              hintText: widget.hintText,
              controller: _controller,  
              onChanged: (text) {
                ref.read(widget.cityProvider.notifier).state = text;
                _fetchCitySuggestions(text); 
              },
              onClear: _clearInput,  
            ),
            if (_showSuggestions && _citySuggestions.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _citySuggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _citySuggestions[index];
                    return InkWell(
                      onTap: () => _onSuggestionSelected(suggestion),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        child: Text(
                          suggestion,
                          style: const TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
