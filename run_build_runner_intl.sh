#!/bin/bash

if [ ! -f lib/l10n/intl_messages.arb ]; then
  touch lib/l10n/intl_messages.arb
fi

#if [ ! -f lib/l10n/messages_all.dart ]; then
    flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n lib/util/am_localizations.dart lib/l10n/intl_*.arb
#fi

flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/util/am_localizations.dart lib/l10n/intl_*.arb
