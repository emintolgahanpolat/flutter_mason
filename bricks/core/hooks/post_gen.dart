import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  context.logger.info('✅ [HOOK] console komutları çalıştırılıyor...');

  final commands = [
    [
      'dart',
      ['fix', '--apply']
    ],
    [
      'flutter',
      ['pub', 'get']
    ],
    [
      'flutter',
      ['gen-l10n']
    ],
    [
      'flutter',
      ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs']
    ],
  ];

  for (final command in commands) {
    final executable = command[0] as String;
    final args = command[1] as List<String>;

    context.logger.info('🚀 Çalıştırılıyor: $executable ${args.join(' ')}');

    final result = await Process.start(
      executable,
      args,
      runInShell: true,
    );

    stdout.addStream(result.stdout);
    stderr.addStream(result.stderr);

    final exitCode = await result.exitCode;

    if (exitCode == 0) {
      context.logger.info('✅ Başarılı: $executable ${args.join(' ')}');
    } else {
      context.logger
          .err('❌ Hata: $executable ${args.join(' ')} exitCode: $exitCode');
      break;
    }
  }

  context.logger.info('✅ build.gradle.kts güncelleniyor...');

  final gradleFile = File('android/app/build.gradle.kts');

  if (!gradleFile.existsSync()) {
    context.logger.err('❌ build.gradle.kts dosyası bulunamadı!');
    return;
  }

  String content = gradleFile.readAsStringSync();

  const applyLine = '\napply { from("flavor.gradle.kts") }\n';

  if (content.contains('apply { from("flavor.gradle.kts") }')) {
    context.logger.info('ℹ️ flavor.gradle.kts zaten ekli, işlem yapılmadı.');
  } else {
    content = '$content$applyLine';
    gradleFile.writeAsStringSync(content);
    context.logger.info('✅ flavor.gradle.kts satırı eklendi!');
  }
}
