import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_climate/features/weather/presentation/providers/weather_provider.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override 
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<String> _searchHistory = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _textController.removeListener(_handleTextChange);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    setState(() {
      _showSuggestions = _textController.text.isNotEmpty;
    });
  }

  void _searchLocation(String location, BuildContext context) {
    if (location.trim().isEmpty) return;

    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    
    // Agregar al historial
    if (!_searchHistory.contains(location)) {
      setState(() {
        _searchHistory.insert(0, location);
        if (_searchHistory.length > 5) {
          _searchHistory.removeLast();
        }
      });
    }

    // Limpiar y cerrar sugerencias
    _textController.clear();
    _focusNode.unfocus();
    setState(() {
      _showSuggestions = false;
    });

    // Buscar el clima
    weatherProvider.changeLocation(location);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Buscar ubicación...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _textController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _textController.clear();
                        _focusNode.unfocus();
                        setState(() {
                          _showSuggestions = false;
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onSubmitted: (value) {
              _searchLocation(value, context);
            },
            onTap: () {
              if (_textController.text.isNotEmpty) {
                setState(() {
                  _showSuggestions = true;
                });
              }
            },
          ),
          if (_showSuggestions)
            _buildSuggestionsList(context),
        ],
      ),
    );
  }

  Widget _buildSuggestionsList(BuildContext context) {
    final suggestions = _textController.text.isEmpty
        ? _searchHistory
        : [
            _textController.text,
            if (_textController.text.toLowerCase().contains('bog')) 'Bogotá',
            if (_textController.text.toLowerCase().contains('med')) 'Medellín',
            if (_textController.text.toLowerCase().contains('lon')) 'London',
          ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 4.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final location = suggestions[index];
          return ListTile(
            leading: _textController.text.isEmpty
                ? const Icon(Icons.history)
                : const Icon(Icons.location_on),
            title: Text(location),
            onTap: () {
              _searchLocation(location, context);
            },
          );
        },
      ),
    );
  }
}
