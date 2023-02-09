import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/widgets.dart';

class SearchPage extends SearchDelegate<String> {
  SearchPage()
      : super(
          searchFieldLabel: 'Tìm kiếm',
          searchFieldStyle: const TextStyle(),
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Visibility(
        visible: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = empty,
          icon: const Icon(Icons.clear),
        ),
      ),
      IconButton(
        onPressed: () => showResults(context),
        icon: const Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, query),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return emptyPlaceholder;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        'Tìm kiếm tại đây',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
