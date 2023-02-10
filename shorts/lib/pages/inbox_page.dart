part of 'main_page.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: const Text('Thông báo'),
      ),
      body: Center(
        child: Text(
          'Trống',
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }
}
