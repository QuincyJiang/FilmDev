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
  new IntroItem(title: '黑白负片', category: 'BLACK & WHITE FILM', imageUrl: 'assets/pic1.jpg',),
  new IntroItem(title: '彩色负片', category: 'COLOR NEGATIVE FILM', imageUrl: 'assets/pic2.jpg',),
  new IntroItem(title: '彩色正片', category: 'COLOR POSITIVE FILM', imageUrl: 'assets/pic3.jpg',),
  new IntroItem(title: '电影负片', category: 'MOVIE NEGATIVE FILM', imageUrl: 'assets/pic4.jpg',),
];