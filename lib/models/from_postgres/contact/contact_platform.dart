enum ContactPlatform { textCall, whatsapp }

extension PlatformShortString on ContactPlatform {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
