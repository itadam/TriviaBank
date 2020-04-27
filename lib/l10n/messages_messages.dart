// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  static m0(numberOfQuestions) => "You have ${numberOfQuestions} questions below";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Add more" : MessageLookupByLibrary.simpleMessage("Add more"),
    "Back" : MessageLookupByLibrary.simpleMessage("Back"),
    "Cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "Email Address" : MessageLookupByLibrary.simpleMessage("Email Address"),
    "Error occured retrieving balance." : MessageLookupByLibrary.simpleMessage("Error occured retrieving balance."),
    "Login" : MessageLookupByLibrary.simpleMessage("Login"),
    "Logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "Next" : MessageLookupByLibrary.simpleMessage("Next"),
    "OK" : MessageLookupByLibrary.simpleMessage("OK"),
    "Password" : MessageLookupByLibrary.simpleMessage("Password"),
    "Trivia Bank" : MessageLookupByLibrary.simpleMessage("Trivia Bank"),
    "Trivia Time" : MessageLookupByLibrary.simpleMessage("Trivia Time"),
    "Try to earn More" : MessageLookupByLibrary.simpleMessage("Try to earn More"),
    "Want to add more to your balance? Answer questions correctly to earn more." : MessageLookupByLibrary.simpleMessage("Want to add more to your balance? Answer questions correctly to earn more."),
    "Welcome" : MessageLookupByLibrary.simpleMessage("Welcome"),
    "Yes!" : MessageLookupByLibrary.simpleMessage("Yes!"),
    "you@example.com" : MessageLookupByLibrary.simpleMessage("you@example.com"),
    "youHaveNumberOfQuestions" : m0
  };
}
