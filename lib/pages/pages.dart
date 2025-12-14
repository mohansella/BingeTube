enum Pages {
  splash('/splash', 'Splash'),

  home('/home', 'Home'),
  myShows('/myshows', 'My Shows'),
  settings('/settings', 'Settings'),

  keyConfig('/keyconfig', 'Key Config'),
  search('/search', 'Search'),

  binge('/binge', 'Binge');

  final String path;
  final String text;
  const Pages(this.path, this.text);
}
