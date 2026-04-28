class ArLightingByPersona {
  static String getLightingCss(String ahName) {
    if (ahName == "Nexus") return "environment-image='legacy' shadow-intensity='2' exposure='0.8'"; // Dark, moody, serious
    if (ahName == "Aria") return "environment-image='neutral' shadow-intensity='1' exposure='1.2'"; // Warm, bright, inviting
    return "environment-image='aircraft_workshop' shadow-intensity='1.5' exposure='1.0'"; // Spark: Tech, high contrast
  }
}