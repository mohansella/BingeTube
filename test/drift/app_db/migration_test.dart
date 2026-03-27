// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:bingetube/core/db/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = Database(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('migration from v1 to v2 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // TODO: Fill these lists
    final oldChannelsData = <v1.ChannelsData>[];
    final expectedNewChannelsData = <v2.ChannelsData>[];

    final oldChannelSnippetsData = <v1.ChannelSnippetsData>[];
    final expectedNewChannelSnippetsData = <v2.ChannelSnippetsData>[];

    final oldChannelThumbnailsData = <v1.ChannelThumbnailsData>[];
    final expectedNewChannelThumbnailsData = <v2.ChannelThumbnailsData>[];

    final oldChannelContentDetailsData = <v1.ChannelContentDetailsData>[];
    final expectedNewChannelContentDetailsData =
        <v2.ChannelContentDetailsData>[];

    final oldChannelStatisticsData = <v1.ChannelStatisticsData>[];
    final expectedNewChannelStatisticsData = <v2.ChannelStatisticsData>[];

    final oldChannelStatusesData = <v1.ChannelStatusesData>[];
    final expectedNewChannelStatusesData = <v2.ChannelStatusesData>[];

    final oldVideosData = <v1.VideosData>[];
    final expectedNewVideosData = <v2.VideosData>[];

    final oldVideoSnippetsData = <v1.VideoSnippetsData>[];
    final expectedNewVideoSnippetsData = <v2.VideoSnippetsData>[];

    final oldVideoThumbnailsData = <v1.VideoThumbnailsData>[];
    final expectedNewVideoThumbnailsData = <v2.VideoThumbnailsData>[];

    final oldVideoContentDetailsData = <v1.VideoContentDetailsData>[];
    final expectedNewVideoContentDetailsData = <v2.VideoContentDetailsData>[];

    final oldVideoStatusesData = <v1.VideoStatusesData>[];
    final expectedNewVideoStatusesData = <v2.VideoStatusesData>[];

    final oldVideoStatisticsData = <v1.VideoStatisticsData>[];
    final expectedNewVideoStatisticsData = <v2.VideoStatisticsData>[];

    final oldVideoProgressData = <v1.VideoProgressData>[];
    final expectedNewVideoProgressData = <v2.VideoProgressData>[];

    final oldPlaylistsData = <v1.PlaylistsData>[];
    final expectedNewPlaylistsData = <v2.PlaylistsData>[];

    final oldPlaylistSnippetsData = <v1.PlaylistSnippetsData>[];
    final expectedNewPlaylistSnippetsData = <v2.PlaylistSnippetsData>[];

    final oldPlaylistThumbnailsData = <v1.PlaylistThumbnailsData>[];
    final expectedNewPlaylistThumbnailsData = <v2.PlaylistThumbnailsData>[];

    final oldPlaylistContentDetailsData = <v1.PlaylistContentDetailsData>[];
    final expectedNewPlaylistContentDetailsData =
        <v2.PlaylistContentDetailsData>[];

    final oldPlaylistVsVideosData = <v1.PlaylistVsVideosData>[];
    final expectedNewPlaylistVsVideosData = <v2.PlaylistVsVideosData>[];

    final oldChannelSearchesData = <v1.ChannelSearchesData>[];
    final expectedNewChannelSearchesData = <v2.ChannelSearchesData>[];

    final oldChannelSearchVsChannelsData = <v1.ChannelSearchVsChannelsData>[];
    final expectedNewChannelSearchVsChannelsData =
        <v2.ChannelSearchVsChannelsData>[];

    final oldVideoSearchesData = <v1.VideoSearchesData>[];
    final expectedNewVideoSearchesData = <v2.VideoSearchesData>[];

    final oldVideoSearchVsVideosData = <v1.VideoSearchVsVideosData>[];
    final expectedNewVideoSearchVsVideosData = <v2.VideoSearchVsVideosData>[];

    final oldCollectionsData = <v1.CollectionsData>[];
    final expectedNewCollectionsData = <v2.CollectionsData>[];

    final oldSeriesData = <v1.SeriesData>[];
    final expectedNewSeriesData = <v2.SeriesData>[];

    final oldSeriesVsVideosData = <v1.SeriesVsVideosData>[];
    final expectedNewSeriesVsVideosData = <v2.SeriesVsVideosData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: Database.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.channels, oldChannelsData);
        batch.insertAll(oldDb.channelSnippets, oldChannelSnippetsData);
        batch.insertAll(oldDb.channelThumbnails, oldChannelThumbnailsData);
        batch.insertAll(
          oldDb.channelContentDetails,
          oldChannelContentDetailsData,
        );
        batch.insertAll(oldDb.channelStatistics, oldChannelStatisticsData);
        batch.insertAll(oldDb.channelStatuses, oldChannelStatusesData);
        batch.insertAll(oldDb.videos, oldVideosData);
        batch.insertAll(oldDb.videoSnippets, oldVideoSnippetsData);
        batch.insertAll(oldDb.videoThumbnails, oldVideoThumbnailsData);
        batch.insertAll(oldDb.videoContentDetails, oldVideoContentDetailsData);
        batch.insertAll(oldDb.videoStatuses, oldVideoStatusesData);
        batch.insertAll(oldDb.videoStatistics, oldVideoStatisticsData);
        batch.insertAll(oldDb.videoProgress, oldVideoProgressData);
        batch.insertAll(oldDb.playlists, oldPlaylistsData);
        batch.insertAll(oldDb.playlistSnippets, oldPlaylistSnippetsData);
        batch.insertAll(oldDb.playlistThumbnails, oldPlaylistThumbnailsData);
        batch.insertAll(
          oldDb.playlistContentDetails,
          oldPlaylistContentDetailsData,
        );
        batch.insertAll(oldDb.playlistVsVideos, oldPlaylistVsVideosData);
        batch.insertAll(oldDb.channelSearches, oldChannelSearchesData);
        batch.insertAll(
          oldDb.channelSearchVsChannels,
          oldChannelSearchVsChannelsData,
        );
        batch.insertAll(oldDb.videoSearches, oldVideoSearchesData);
        batch.insertAll(oldDb.videoSearchVsVideos, oldVideoSearchVsVideosData);
        batch.insertAll(oldDb.collections, oldCollectionsData);
        batch.insertAll(oldDb.series, oldSeriesData);
        batch.insertAll(oldDb.seriesVsVideos, oldSeriesVsVideosData);
      },
      validateItems: (newDb) async {
        expect(
          expectedNewChannelsData,
          await newDb.select(newDb.channels).get(),
        );
        expect(
          expectedNewChannelSnippetsData,
          await newDb.select(newDb.channelSnippets).get(),
        );
        expect(
          expectedNewChannelThumbnailsData,
          await newDb.select(newDb.channelThumbnails).get(),
        );
        expect(
          expectedNewChannelContentDetailsData,
          await newDb.select(newDb.channelContentDetails).get(),
        );
        expect(
          expectedNewChannelStatisticsData,
          await newDb.select(newDb.channelStatistics).get(),
        );
        expect(
          expectedNewChannelStatusesData,
          await newDb.select(newDb.channelStatuses).get(),
        );
        expect(expectedNewVideosData, await newDb.select(newDb.videos).get());
        expect(
          expectedNewVideoSnippetsData,
          await newDb.select(newDb.videoSnippets).get(),
        );
        expect(
          expectedNewVideoThumbnailsData,
          await newDb.select(newDb.videoThumbnails).get(),
        );
        expect(
          expectedNewVideoContentDetailsData,
          await newDb.select(newDb.videoContentDetails).get(),
        );
        expect(
          expectedNewVideoStatusesData,
          await newDb.select(newDb.videoStatuses).get(),
        );
        expect(
          expectedNewVideoStatisticsData,
          await newDb.select(newDb.videoStatistics).get(),
        );
        expect(
          expectedNewVideoProgressData,
          await newDb.select(newDb.videoProgress).get(),
        );
        expect(
          expectedNewPlaylistsData,
          await newDb.select(newDb.playlists).get(),
        );
        expect(
          expectedNewPlaylistSnippetsData,
          await newDb.select(newDb.playlistSnippets).get(),
        );
        expect(
          expectedNewPlaylistThumbnailsData,
          await newDb.select(newDb.playlistThumbnails).get(),
        );
        expect(
          expectedNewPlaylistContentDetailsData,
          await newDb.select(newDb.playlistContentDetails).get(),
        );
        expect(
          expectedNewPlaylistVsVideosData,
          await newDb.select(newDb.playlistVsVideos).get(),
        );
        expect(
          expectedNewChannelSearchesData,
          await newDb.select(newDb.channelSearches).get(),
        );
        expect(
          expectedNewChannelSearchVsChannelsData,
          await newDb.select(newDb.channelSearchVsChannels).get(),
        );
        expect(
          expectedNewVideoSearchesData,
          await newDb.select(newDb.videoSearches).get(),
        );
        expect(
          expectedNewVideoSearchVsVideosData,
          await newDb.select(newDb.videoSearchVsVideos).get(),
        );
        expect(
          expectedNewCollectionsData,
          await newDb.select(newDb.collections).get(),
        );
        expect(expectedNewSeriesData, await newDb.select(newDb.series).get());
        expect(
          expectedNewSeriesVsVideosData,
          await newDb.select(newDb.seriesVsVideos).get(),
        );
      },
    );
  });
}
