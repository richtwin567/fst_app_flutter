import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/services.dart';

const _filesToWarmup = [
  'assets/rive_animated_icons/search_clear.flr'
];

Future<void> precacheRive() async {
  for (final filename in _filesToWarmup) {
    await cachedActor(AssetFlare(bundle: rootBundle, name: filename));
  }
}
