class TextureCompressionEngine {
  static String useCompressedTextures(String originalGlbUrl) {
    return originalGlbUrl.replaceAll(".glb", "_mobile_optimized.glb");
  }
}