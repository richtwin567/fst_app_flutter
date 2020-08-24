enum Platform { TEXT_CALL, WHATSAPP }

extension PlatformShortString on Platform {
  String asString() {
    return this.toString().split('.').last;
  }
}
