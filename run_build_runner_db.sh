#!/bin/bash

#flutter packages pub run build_runner build
flutter pub run build_runner build --delete-conflicting-outputs

# single-purpose alternative to...
# flutter pub run build_runner watch