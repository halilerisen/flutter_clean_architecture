// cSpell:ignore roboto
import 'dart:async';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform/platform.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUpAll(() async {
    final robotoFont = _loadMaterialFont(fontName: 'Roboto-Regular.ttf');
    final materialIconFont = _loadMaterialFont(fontName: 'MaterialIcons-Regular.otf');

    final fontLoader = FontLoader('Roboto')..addFont(robotoFont);
    final materialFontLoader = FontLoader('Roboto')..addFont(materialIconFont);

    await materialFontLoader.load();
    await fontLoader.load();
  });
  await testMain();
}

Future<ByteData> _loadMaterialFont({required String fontName}) {
  const FileSystem fs = LocalFileSystem();
  const Platform platform = LocalPlatform();

  final Directory flutterRoot = fs.directory(platform.environment['FLUTTER_ROOT']);

  final File font = flutterRoot.childFile(fs.path.join(
    'bin',
    'cache',
    'artifacts',
    'material_fonts',
    fontName,
  ));

  final Future<ByteData> bytes = Future<ByteData>.value(
    font.readAsBytesSync().buffer.asByteData(),
  );

  return bytes;
}
