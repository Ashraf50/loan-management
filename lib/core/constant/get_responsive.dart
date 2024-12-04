  double getResponsiveHeight(double screenHeight) {
    if (screenHeight >= 900) {
      return screenHeight * 0.23;
    } else if (screenHeight >= 800) {
      return screenHeight * 0.24;
    } else if (screenHeight >= 700) {
      return screenHeight * 0.28;
    } else if (screenHeight >= 600) {
      return screenHeight * 0.3;
    } else if (screenHeight >= 500) {
      return screenHeight * 0.34;
    } else {
      return screenHeight * 0.4;
    }
  }