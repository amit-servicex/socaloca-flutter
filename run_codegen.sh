#\!/bin/bash
# Run Freezed + Riverpod code generation
# Run this after modifying any @freezed or @riverpod annotated files

echo "🚀 Running code generation..."
dart run build_runner build --delete-conflicting-outputs
echo "✅ Done"
