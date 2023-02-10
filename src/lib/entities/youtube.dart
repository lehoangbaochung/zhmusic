import 'package:flutter/foundation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'artist.dart';
import 'music.dart';

abstract class YoutubeMusic extends Music {
  YoutubeMusic(
    super.id, {
    required super.name,
    required super.description,
  });

  Video? _video;
  StreamManifest? _manifest;

  @protected
  static final yt = YoutubeExplode();

  /// Return the artists of this [YoutubeMusic] object.
  Future<Iterable<Artist>> getArtists();

  String getShareUrl() => 'https://youtu.be/$id';

  /// Return an url to available [thumbnail] of [YoutubeMusic].
  String getImageUrl([YoutubeThumbnail? thumbnail]) {
    return 'https://img.youtube.com/vi/$id/${thumbnail?.name ?? 'default'}.jpg';
  }

  /// Returns the metadata containing in [YoutubeMusic] object.
  Future<YoutubeMetadata> getMetadata() async {
    return YoutubeMetadata.fromVideo(
      _video ??= await yt.videos.get(id),
    );
  }

  /// Returns an url of [YoutubeMusic] stream with [audioOnly] option.
  Future<String> getStreamUrl({required bool audioOnly}) async {
    final manifest = _manifest ??= await yt.videos.streams.getManifest(id);
    return !audioOnly ? manifest.muxed.withHighestBitrate().url.toString() : manifest.audioOnly.withHighestBitrate().url.toString();
  }
}

enum YoutubeThumbnail {
  mqdefault(320, 180),
  hqdefault(480, 360),
  sddefault(640, 480),
  maxresdefault(1280, 720);

  const YoutubeThumbnail(
    this.width,
    this.height,
  );

  final double width;
  final double height;
}

class YoutubeMetadata {
  final String title;
  final String description;
  final Duration? duration;
  final int viewCount;
  final int? likeCount;
  final DateTime? uploadDate;
  final DateTime? publishDate;

  const YoutubeMetadata._(
    this.title,
    this.description,
    this.duration,
    this.viewCount,
    this.likeCount,
    this.uploadDate,
    this.publishDate,
  );

  factory YoutubeMetadata.fromVideo(Video video) {
    final engagement = video.engagement;
    return YoutubeMetadata._(
      video.title,
      video.description,
      video.duration,
      engagement.viewCount,
      engagement.likeCount,
      video.uploadDate,
      video.publishDate,
    );
  }
}
