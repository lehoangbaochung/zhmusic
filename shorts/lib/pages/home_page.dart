part of 'main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 60,
          centerTitle: true,
          backgroundColor: const Color(0x44000000),
          title: TabBar(
            labelColor: context.primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: 'Theo dõi'),
              Tab(text: 'Đề xuất'),
            ],
          ),
          leading: IconButton(
            icon: Icon(
              Icons.settings,
              color: context.primaryColor,
            ),
            onPressed: () => AppPages.push(context, AppPages.settings.path),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: context.primaryColor,
              ),
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: SearchPage(),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text(
                'Trống',
                style: context.textTheme.titleMedium,
              ),
            ),
            FutureBuilder(
              future: musicStorage.getShorts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final shorts = snapshot.requireData.shuffled;
                  return RefreshIndicator(
                    onRefresh: () async {},
                    child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: shorts.length,
                      itemBuilder: (context, index) {
                        return ShortFullscreenTile(
                          shorts.elementAt(index),
                          extendBody: false,
                        );
                      },
                    ),
                  );
                }
                return centeredLoadingIndicator;
              },
            ),
          ],
        ),
      ),
    );
  }
}
