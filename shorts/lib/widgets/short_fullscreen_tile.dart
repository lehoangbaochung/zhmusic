import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '/app/app_colors.dart';
import '/app/app_pages.dart';

class ShortFullscreenTile extends StatefulWidget {
  const ShortFullscreenTile(
    this.short, {
    super.key,
    required this.extendBody,
  });

  final Short short;
  final bool extendBody;

  @override
  State<ShortFullscreenTile> createState() => _ShortFullscreenTileState();
}

class _ShortFullscreenTileState extends State<ShortFullscreenTile> with SingleTickerProviderStateMixin {
  late final short = widget.short;
  late final extendBody = widget.extendBody;
  late final AnimationController audioDiscController;

  @override
  void initState() {
    super.initState();
    audioDiscController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    audioDiscController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: !extendBody
          ? null
          : AppBar(
              foregroundColor: context.primaryColor,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    await showSearch(
                      context: context,
                      delegate: SearchPage(),
                    );
                  },
                ),
              ],
            ),
      body: Stack(
        children: [
          FutureBuilder(
            future: short.getStreamUrl(audioOnly: false),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final videoPlayerController = VideoPlayerController.network(
                  snapshot.requireData,
                )
                  ..initialize()
                  ..setLooping(true);
                return VisibilityDetector(
                  key: UniqueKey(),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction == 1) {
                      audioDiscController.repeat();
                      videoPlayerController.play();
                    } else {
                      audioDiscController.stop();
                      videoPlayerController.pause();
                    }
                  },
                  child: ColoredBox(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Center(
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: VideoPlayer(
                              videoPlayerController,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: VideoProgressIndicator(
                              videoPlayerController,
                              allowScrubbing: true,
                              padding: const EdgeInsets.only(),
                              colors: VideoProgressColors(
                                playedColor: context.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: videoPlayerController.play(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  final videoPlayerValue = videoPlayerController.value;
                                  return InkWell(
                                    child: Visibility(
                                      replacement: Container(),
                                      visible: !videoPlayerValue.isPlaying,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            audioDiscController.repeat();
                                            videoPlayerController.play();
                                          },
                                          icon: const CircleAvatar(
                                            radius: 120,
                                            child: Icon(Icons.play_arrow),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (videoPlayerValue.isPlaying) {
                                          audioDiscController.stop();
                                          videoPlayerController.pause();
                                        } else {
                                          audioDiscController.repeat();
                                          videoPlayerController.play();
                                        }
                                      });
                                    },
                                  );
                                },
                              );
                            }
                            return emptyPlaceholder;
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const ColoredBox(
                color: Colors.black,
                child: centeredLoadingIndicator,
              );
            },
          ),
          FutureBuilder(
            future: Future.wait([
              short.getAudios(),
              short.getArtists(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final music = snapshot.requireData;
                final audios = music.elementAt(0) as Iterable<Audio>;
                final artists = music.elementAt(1) as Iterable<Artist>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // action buttons
                    SizedBox(
                      height: context.mediaHeight / 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // artist button
                          TextButton(
                            onPressed: () {
                              AppPages.push(context, AppPages.artist.path, artists.first);
                            },
                            child: CachedNetworkImage(
                              imageUrl: artists.first.getImageUrl(),
                              imageBuilder: (_, imageProvider) {
                                return CircleAvatar(
                                  backgroundImage: imageProvider,
                                );
                              },
                              placeholder: (_, __) {
                                return CircleAvatar(
                                  backgroundImage: MusicType.short.image.image,
                                );
                              },
                            ),
                          ),
                          // favorite button
                          FutureBuilder(
                            key: UniqueKey(),
                            future: widget.short.getMetadata(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return TextButton(
                                  onPressed: () {},
                                  child: Column(
                                    children: [
                                      const Icon(Icons.favorite),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${snapshot.requireData.likeCount}',
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return TextButton(
                                onPressed: () {},
                                child: Column(
                                  children: const [
                                    Icon(Icons.favorite),
                                    SizedBox(height: 8),
                                    Text('Thích'),
                                  ],
                                ),
                              );
                            },
                          ),
                          // comment button
                          TextButton(
                            onPressed: null,
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                AppColors.disabledColor,
                              ),
                            ),
                            child: Column(
                              children: const [
                                Icon(Icons.comment),
                                SizedBox(height: 8),
                                Text('Đã tắt'),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // if (account == null) {
                              //   showModalBottomSheet(
                              //     context: context,
                              //     builder: (_) => const LoginDialog(),
                              //   );
                              // } else {
                              //   account.shorts.add(widget.short);
                              //   context.showSnackBar(
                              //     'Đã thêm vào danh sách yêu thích',
                              //   );
                              // }
                            },
                            child: Column(
                              children: const [
                                Icon(Icons.star_border),
                                SizedBox(height: 8),
                                Text('Lưu'),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await Share.share(
                                short.getShareUrl(),
                              );
                            },
                            child: Column(
                              children: const [
                                Icon(Icons.share),
                                SizedBox(height: 8),
                                Text('Chia sẻ'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // short detail
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person),
                          label: Text(
                            artists.getName(MusicLanguage.vi),
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center,
                          ),
                        ),
                        // description
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.info),
                          label: const Text(
                            'Do Zither Harp Music tự động tạo',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                    // audio disc
                    Builder(
                      builder: (context) {
                        if (audios.isEmpty) {
                          return ListTile(
                            selected: true,
                            title: const Text(
                              'Nhạc nền',
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              artists.getName(MusicLanguage.vi),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: RotationTransition(
                              turns: CurvedAnimation(
                                parent: audioDiscController,
                                curve: Curves.linear,
                              ),
                              child: const CircleAvatar(
                                child: Icon(Icons.music_note),
                              ),
                            ),
                          );
                        } else {
                          final audio = audios.random;
                          return ListTile(
                            selected: true,
                            title: Text(
                              audio.getName(MusicLanguage.vi),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: FutureBuilder(
                              future: audio.getArtists(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final artists = snapshot.requireData;
                                  return Text(
                                    artists.getName(MusicLanguage.vi),
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }
                                return emptyPlaceholder;
                              },
                            ),
                            trailing: RotationTransition(
                              turns: CurvedAnimation(
                                parent: audioDiscController,
                                curve: Curves.linear,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: audio.getImageUrl(),
                                imageBuilder: (_, imageProvider) {
                                  return CircleAvatar(
                                    backgroundImage: imageProvider,
                                  );
                                },
                                placeholder: (_, __) {
                                  return CircleAvatar(
                                    backgroundImage: MusicType.short.image.image,
                                  );
                                },
                              ),
                            ),
                            onTap: () => AppPages.push(context, AppPages.audio.path, audio),
                          );
                        }
                      },
                    ),
                    // comment field
                    Visibility(
                      visible: extendBody,
                      child: ColoredBox(
                        color: AppColors.secondaryColor,
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(),
                            ),
                            hintText: 'Viết bình luận của bạn tại đây...',
                            prefixIcon: Icon(
                              Icons.comment,
                              color: context.primaryColor,
                            ),
                            suffixIcon: Icon(
                              Icons.send,
                              color: context.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return emptyPlaceholder;
            },
          ),
        ],
      ),
    );
  }
}
