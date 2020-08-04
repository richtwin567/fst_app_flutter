import 'package:flutter/material.dart';

/// A single [StatefulWidget] to prevent code duplication for various screen layouts.
/// [state] is the state for the different screen layouts.
class ContactViewStateful extends StatefulWidget {

  /// The [State] that this contact page should use.
  final State<ContactViewStateful> state;

  const ContactViewStateful({Key key, @required this.state}) : super(key: key);

  @override
  State<ContactViewStateful> createState() => state;
} // ContactViewStateful definition
