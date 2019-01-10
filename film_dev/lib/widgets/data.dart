class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.imageUrl,
  });

  final String title;
  final String category;
  final String imageUrl;
}

final sampleItems = <IntroItem>[
  new IntroItem(title: '黑白负片', category: 'BLACK & WHITE', imageUrl: 'assets/splash.jpg',),
  new IntroItem(title: '彩色负片', category: 'COLOR NEGATIVE', imageUrl: 'assets/splash2.jpg',),
  new IntroItem(title: '彩色正片', category: 'COLOR POSITIVE', imageUrl: 'assets/splash2',),
  new IntroItem(title: '电影胶片', category: 'MOVIE FILM', imageUrl: 'assets/splash2',),
];