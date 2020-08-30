enum Platform { textCall, whatsapp }

extension PlatformShortString on Platform {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
