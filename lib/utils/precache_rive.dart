import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/services.dart';

// TODO: document @richtwin567
const _filesToWarmup = ['assets/rive/animated_icons/search_clear.flr'];

Future<void> precacheRive() async {
  for (final filename in _filesToWarmup) {
    await cachedActor(AssetFlare(bundle: rootBundle, name: filename));
  }
}
