import 'package:flutter_riverpod/flutter_riverpod.dart';

final pixelFontProvider = StateNotifierProvider<PixelFontNotifier, bool>((ref) {
  return PixelFontNotifier();
});

class PixelFontNotifier extends StateNotifier<bool> {
  PixelFontNotifier() : super(false);

  void setPixelFont(bool value) {
    state = value;
  }
}
