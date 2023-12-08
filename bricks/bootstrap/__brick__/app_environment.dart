class AppEnvironment {
  /// name of the environment
  final String name;

  /// default constructor
  const AppEnvironment(this.name);

  /// preset of common env name 'dev'
  static const dev = 'dev';

  /// preset of common env name 'prod'
  static const prod = 'prod';

  /// preset of common env name 'stg'
  static const stg = 'stg';

  /// preset of common env name 'mock'
  static const mock = 'mock';

  /// preset of common env name 'test'
  static const test = 'test';
}
