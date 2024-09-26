enum ImagePath { instagramSvg }

extension ImagePathExtension on ImagePath {
  String imagePath() {
    switch (this) {
      case ImagePath.instagramSvg:
        return 'assets/ic_instagram.svg';
    }
  }
}
