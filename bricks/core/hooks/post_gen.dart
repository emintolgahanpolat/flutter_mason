import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  context.logger.info('✅ [HOOK] Başladı.');
  final gradleFile = File('android/app/build.gradle.kts');

  if (!gradleFile.existsSync()) {
    context.logger.err('❌ build.gradle.kts bulunamadı!');
    return;
  }

  String content = gradleFile.readAsStringSync();

  final name = context.vars['name'] as String? ?? 'appname';
  final nameLower = name.toLowerCase();

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

  // --- FLAVORS BLOĞU VAR MI KONTROL ---
  if (content.contains('productFlavors')) {
    context.logger.info('✅ Zaten productFlavors var, işlem yapılmadı.');
    return;
  }

  // --- defaultConfig BLOĞUNU BUL ---
  final defaultConfigStart = content.indexOf('defaultConfig');
  if (defaultConfigStart == -1) {
    context.logger.err('❌ defaultConfig bloğu bulunamadı!');
    return;
  }

  int openBrackets = 0;
  int closeIndex = -1;

  for (int i = defaultConfigStart; i < content.length; i++) {
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
    context.logger.err('❌ defaultConfig bloğu kapanışı bulunamadı!');
    return;
  }

  // --- KAPANIŞTAN SONRA signingConfigs + flavors BLOĞUNU EKLE ---
  content = content.substring(0, closeIndex + 1) +
      '\n' +
      signingConfigsBlock +
      '\n' +
      flavorsBlock +
      content.substring(closeIndex + 1);

  gradleFile.writeAsStringSync(content);

  context.logger
      .info('✅ signingConfigs ve flavors defaultConfig sonrasına eklendi!');
}
