enum ImagePath { instagramSvg, defaultPfp }

extension ImagePathExtension on ImagePath {
  String imagePath() {
    switch (this) {
      case ImagePath.instagramSvg:
        return 'assets/ic_instagram.svg';
      case ImagePath.defaultPfp:
        return 'assets/ic_default_pfp.jpg';
    }
  }
}
