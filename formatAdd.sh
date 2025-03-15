#!/bin/sh

dart run import_sorter:main
dart run pubspec_dependency_sorter
dart format .
dart fix --apply
flutter analyze
ANALYZE=$?
if [ $ANALYZE -ne 0 ]; then
	echo "Kindly analyze the flutter project."
	exit 1;
else
	echo "Analyze is clear. Proceeding with staging the files."
fi
git add .
