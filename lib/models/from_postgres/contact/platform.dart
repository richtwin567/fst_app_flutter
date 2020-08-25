enum Platform { TEXT_CALL, WHATSAPP }

extension PlatformShortString on Platform {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
