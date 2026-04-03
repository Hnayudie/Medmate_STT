#!/usr/bin/env bash
# Chạy: bash scripts/gen.sh
# Tự động sinh:
#   1. lib/generated/app_images.dart  (image asset constants)
#   2. lib/generated/app_icons.dart   (icon asset constants)
#   3. .dart_tool/flutter_gen/gen_l10n/app_localizations*.dart  (intl)

set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  [1/2] Generating asset constants..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
dart run scripts/gen_assets.dart

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  [2/2] Generating intl (l10n)..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
flutter gen-l10n

echo ""
echo "✅ All done!"
