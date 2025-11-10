enum Pages {
  home('/home', 'Home'),
  myshows('/myshows', 'My Shows'),
  settings('/settings', 'Settings'),

  keyconfig('/keyconfig', 'Key Config'),
  search('/search', 'Search');
  

  final String path;
  final String text;
  const Pages(this.path, this.text);
}
