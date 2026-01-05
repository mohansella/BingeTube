enum Assets {
  logoPng('assets/images/logo.png'),
  bingePanda('assets/lottie/binge_panda.json'),
  emptyBox('assets/lottie/empty_box.json');

  final String path;
  const Assets(this.path);
}
