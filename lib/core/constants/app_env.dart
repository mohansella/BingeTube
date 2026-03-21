enum AppEnv {
  production('https://bingetube.pages.dev'),
  preview('https://preview.bingetube.pages.dev'),
  development('http://localhost:4321');

  final String baseUrl;

  const AppEnv(this.baseUrl);

  static AppEnv get instance {
    switch (_appEnvVal) {
      case 'production':
        return production;
      case 'preview':
        return preview;
      default:
        return development;
    }
  }

  static const _appEnvVal = String.fromEnvironment('APP_ENV');
}
