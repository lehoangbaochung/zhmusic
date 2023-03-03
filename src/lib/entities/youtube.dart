import 'package:flutter/foundation.dart';
import 'package:src/exports/entities.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// ignore: must_be_immutable
abstract class YoutubeMusic extends Music {
  YoutubeMusic(
    super.id, {
    required super.name,
    required super.description,
  });

  Video? _video;
  StreamManifest? _streamManifest;
  ClosedCaptionManifest? _subtitleManifest;

  @protected
  static final yt = YoutubeExplode();

  /// Return the artists of this [YoutubeMusic] object.
  Future<Iterable<Artist>> getArtists();

  String getShareUrl() => 'https://youtu.be/$id';

  /// Return an url to available [thumbnail] of [YoutubeMusic].
  String getImageUrl([YoutubeThumbnail? thumbnail]) {
    return 'https://img.youtube.com/vi/$id/${thumbnail?.name ?? 'default'}.jpg';
  }

  /// Returns an url of [YoutubeMusic] stream with [audioOnly] option.
  Future<String> getStreamUrl({required bool audioOnly}) async {
    final manifest = _streamManifest ??= await yt.videos.streams.getManifest(id);
    return !audioOnly ? manifest.muxed.withHighestBitrate().url.toString() : manifest.audioOnly.withHighestBitrate().url.toString();
  }

  /// Returns the metadata containing in [YoutubeMusic] object.
  Future<YoutubeMetadata> getMetadata() async {
    return YoutubeMetadata.fromVideo(
      _video ??= await yt.videos.get(id),
    );
  }

  /// Gets all [Subtitle] which is identified by the specified metadata.
  Future<Iterable<Subtitle>> getSubtitles(MusicLanguage language) async {
    final manifest = _subtitleManifest ??= await yt.videos.closedCaptions.getManifest(id);
    final trackInfos = manifest.getByLanguage(language.name);
    if (trackInfos.isEmpty) return [];
    final track = await yt.videos.closedCaptions.get(trackInfos.first);
    return track.captions.map((caption) => Subtitle.fromCaption(caption));
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
  final int viewCount;
  final int? likeCount;
  final Duration? duration;
  final DateTime? uploadDate;
  final DateTime? publishDate;

  const YoutubeMetadata._(
    this.title,
    this.description,
    this.viewCount,
    this.likeCount,
    this.duration,
    this.uploadDate,
    this.publishDate,
  );

  factory YoutubeMetadata.fromVideo(Video video) {
    final engagement = video.engagement;
    return YoutubeMetadata._(
      video.title,
      video.description,
      engagement.viewCount,
      engagement.likeCount,
      video.duration,
      video.uploadDate,
      video.publishDate,
    );
  }
}
