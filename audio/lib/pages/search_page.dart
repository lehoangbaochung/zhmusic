import 'package:flutter/material.dart';
import 'package:src/exports/widgets.dart';

class SearchPage extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return placeholder;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return placeholder;
  }
}
