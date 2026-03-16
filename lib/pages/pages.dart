enum Pages {
  splash('/splash', 'Splash'),

  discover('/discover', 'Discover'),
  library('/library', 'Library'),
  profile('/profile', 'Profile'),

  keyConfig('/keyconfig', 'Key Config'),
  search('/search', 'Search'),
  channel('/channel', 'Channel'),

  binge('/binge', 'Binge'),
  editBinge('/edit_binge', 'Edit Binge');

  final String path;
  final String text;
  const Pages(this.path, this.text);
}
