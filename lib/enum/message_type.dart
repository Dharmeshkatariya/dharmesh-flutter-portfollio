enum MessageType {
  text(1),
  image(2),
  documents(3);

  final int type;

  const MessageType(this.type);
}
