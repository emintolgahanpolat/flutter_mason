import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  context.logger.info('✅ [HOOK] console komutları çalıştırılıyor...');

  final commands = [
    [
      'flutter',
      ['create', '.', '--platforms=android,ios']
    ],
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

  context.logger.info('🔧 build.gradle.kts düzenleniyor...');
  final gradleFile = File('android/app/build.gradle.kts');

  if (!gradleFile.existsSync()) {
    context.logger.err('❌ build.gradle.kts bulunamadı!');
    return;
  }

  String content = gradleFile.readAsStringSync();

  final name = context.vars['name'] as String? ?? 'appname';
  final nameLower = name.toLowerCase();

  final importsBlock = '''
import java.util.Properties
import java.io.FileInputStream

val keystoreProperties = Properties().apply {
    val keystoreFile = rootProject.file("key.properties")
    if (keystoreFile.exists()) {
        load(FileInputStream(keystoreFile))
    }
}
''';

  final signingConfigsBlock = '''
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }
''';

  final flavorsBlock = '''
    flavorDimensions += "default"

    productFlavors {
        create("production") {
            dimension = "default"
            applicationIdSuffix = ""
            manifestPlaceholders["appName"] = "$nameLower"
        }

        create("development") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            manifestPlaceholders["appName"] = "[DEV] $nameLower"
        }
    }
''';

  // Zaten varsa işlem yapma
  if (content.contains('productFlavors')) {
    context.logger.info('✅ Zaten productFlavors var, işlem yapılmadı.');
    return;
  }

  // En başa imports bloğunu ekle
  content = importsBlock + '\n\n' + content;

  // --- android bloğunu bul ---
  final androidStart = content.indexOf('android {');
  if (androidStart == -1) {
    context.logger.err('❌ android bloğu bulunamadı!');
    return;
  }

  int openBrackets = 0;
  int closeIndex = -1;

  for (int i = androidStart; i < content.length; i++) {
    if (content[i] == '{') {
      openBrackets++;
    } else if (content[i] == '}') {
      openBrackets--;
      if (openBrackets == 0) {
        closeIndex = i;
        break;
      }
    }
  }

  if (closeIndex == -1) {
    context.logger.err('❌ android bloğu kapanışı bulunamadı!');
    return;
  }

  // android bloğu kapanışından önce ekle
  content = content.substring(0, closeIndex) +
      '\n' +
      signingConfigsBlock +
      '\n' +
      flavorsBlock +
      '\n' +
      content.substring(closeIndex);

  gradleFile.writeAsStringSync(content);

  context.logger
      .info('✅ signingConfigs ve flavors android bloğu SONUNA eklendi!');
}
