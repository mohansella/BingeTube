enum Pages {
  home('/home', 'Home'),
  myshows('/myshows', 'MyShows'),
  settings('/settings', 'Settings');

  final String path;
  final String text;
  const Pages(this.path, this.text);
}
