// dart run scripts/gen_assets.dart
//
// Quét các file .png ở root của từng thư mục assets (images/, icons/)
// rồi sinh ra lib/generated/app_images.dart và app_icons.dart.
// Flutter tự động dùng 2.0x/ và 3.0x/ nếu cùng tên file tồn tại.

import 'dart:io';

void main() {
  _generate(
    sourceDir: 'assets/images',
    outputFile: 'lib/generated/app_images.dart',
    className: 'AppImages',
  );

  _generate(
    sourceDir: 'assets/icons',
    outputFile: 'lib/generated/app_icons.dart',
    className: 'AppIcons',
  );

  _updatePubspec();
}

// ---------------------------------------------------------------------------

void _generate({
  required String sourceDir,
  required String outputFile,
  required String className,
}) {
  final dir = Directory(sourceDir);
  if (!dir.existsSync()) {
    print('⚠  $sourceDir not found – skipped.');
    return;
  }

  // Chỉ lấy file .png ở root (bỏ qua 2.0x/ 3.0x/ subdirs)
  final files = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.png'))
      .toList()
    ..sort((a, b) => a.uri.pathSegments.last.compareTo(b.uri.pathSegments.last));

  if (files.isEmpty) {
    print('ℹ  No .png files in $sourceDir – $outputFile not generated.');
    return;
  }

  final buf = StringBuffer()
    ..writeln('// GENERATED CODE – DO NOT MODIFY BY HAND')
    ..writeln('// Run: dart run scripts/gen_assets.dart')
    ..writeln()
    ..writeln('// ignore_for_file: constant_identifier_names')
    ..writeln()
    ..writeln('class $className {')
    ..writeln('  $className._();')
    ..writeln();

  for (final file in files) {
    final fileName = file.uri.pathSegments.last;          // e.g. my_logo.png
    final key = fileName.replaceAll('.png', '');          // e.g. my_logo
    final camel = _toCamelCase(key);                      // e.g. myLogo
    final path = '$sourceDir/$fileName';
    buf.writeln("  static const String $camel = '$path';");
  }

  buf
    ..writeln()
    ..writeln('}');

  final out = File(outputFile);
  out.parent.createSync(recursive: true);
  out.writeAsStringSync(buf.toString());
  print('✅ Generated $outputFile (${files.length} asset(s))');
}

// ---------------------------------------------------------------------------
// Tự thêm assets vào pubspec.yaml nếu chưa có

void _updatePubspec() {
  const pubspecPath = 'pubspec.yaml';
  final file = File(pubspecPath);
  if (!file.existsSync()) return;

  var content = file.readAsStringSync();

  const assetBlock = '''  assets:
    - assets/images/
    - assets/images/2.0x/
    - assets/images/3.0x/
    - assets/icons/
    - assets/icons/2.0x/
    - assets/icons/3.0x/
''';

  if (content.contains('assets/images/')) {
    print('ℹ  pubspec.yaml already has asset declarations.');
    return;
  }

  // Chèn ngay sau dòng "uses-material-design: true"
  const anchor = '  uses-material-design: true';
  if (!content.contains(anchor)) {
    print('⚠  Could not find anchor in pubspec.yaml – add assets manually.');
    return;
  }

  content = content.replaceFirst(
    anchor,
    '$anchor\n\n$assetBlock',
  );

  file.writeAsStringSync(content);
  print('✅ Updated pubspec.yaml with asset declarations');
}

// ---------------------------------------------------------------------------

String _toCamelCase(String input) {
  final parts = input.split(RegExp(r'[_\-]'));
  if (parts.isEmpty) return input;
  return parts.first +
      parts
          .skip(1)
          .map((p) => p.isEmpty ? '' : p[0].toUpperCase() + p.substring(1))
          .join();
}
