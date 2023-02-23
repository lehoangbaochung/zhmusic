import 'package:flutter/material.dart';
import 'package:src/exports/widgets.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(
                      height: context.mediaHeight * .005,
                    ),
                    Text(
                      'Hello World',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge,
                    ),
                    const Text(
                      'Đang theo dõi 25',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.mediaHeight * .02,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(Icons.cloud_upload),
                          Text('Trực tuyến'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(Icons.favorite),
                          Text('Đã lưu'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(Icons.history),
                          Text('Gần đây'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(Icons.playlist_play),
                          Text('Danh sách phát'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.mediaHeight * .02,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.withOpacity(.6)),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                title: const Text('Bài hát yêu thích của tôi'),
                subtitle: const Text('256 bài hát'),
                leading: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Center(
                    child: Icon(Icons.favorite),
                  ),
                ),
              ),
              SizedBox(
                height: context.mediaHeight * .02,
              ),
              const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    text: 'Danh sách đã tạo',
                  ),
                  Tab(
                    text: 'Danh sách đã lưu',
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Danh sách đã lưu (14)'),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text('Playlist 1'),
                          subtitle: Text('10 bài'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Center(
                              child: Icon(Icons.favorite),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text('Playlist 1'),
                          subtitle: Text('10 bài'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Center(
                              child: Icon(Icons.favorite),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text('Playlist 1'),
                          subtitle: Text('10 bài'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Center(
                              child: Icon(Icons.favorite),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text('Playlist 1'),
                          subtitle: Text('10 bài'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Center(
                              child: Icon(Icons.favorite),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text('Playlist 1'),
                          subtitle: Text('10 bài'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Center(
                              child: Icon(Icons.favorite),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text('Playlist 1'),
                          subtitle: Text('10 bài'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Center(
                              child: Icon(Icons.favorite),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text('Playlist 1'),
                          subtitle: Text('10 bài'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Center(
                              child: Icon(Icons.favorite),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text('Playlist 1'),
                          subtitle: Text('10 bài'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Center(
                              child: Icon(Icons.favorite),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
