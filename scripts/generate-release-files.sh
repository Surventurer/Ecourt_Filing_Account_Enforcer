#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  echo "Usage: $0 --pem <path/to/key.pem> --base-url <https://host/path> [--crx-file <name.crx>] [--firefox-id <id>] [--firefox-xpi-url <url>]"
  echo "Example: $0 --pem Ecourt_Filing_Account_Enforcer.pem --base-url https://example.github.io/repo"
}

PEM_PATH=""
BASE_URL=""
CRX_FILE="Ecourt_Filing_Account_Enforcer.crx"
FIREFOX_ID="ecourt-filing-account-enforcer@surventurer.github.io"
FIREFOX_XPI_URL="https://YOUR_HOST_OR_AMO_URL/Ecourt_Filing_Account_Enforcer.xpi"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --pem)
      PEM_PATH="$2"
      shift 2
      ;;
    --base-url)
      BASE_URL="$2"
      shift 2
      ;;
    --crx-file)
      CRX_FILE="$2"
      shift 2
      ;;
    --firefox-id)
      FIREFOX_ID="$2"
      shift 2
      ;;
    --firefox-xpi-url)
      FIREFOX_XPI_URL="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$PEM_PATH" || -z "$BASE_URL" ]]; then
  echo "Error: --pem and --base-url are required."
  usage
  exit 1
fi

if [[ ! -f "$PEM_PATH" ]]; then
  echo "Error: PEM file not found at $PEM_PATH"
  exit 1
fi

BASE_URL="${BASE_URL%/}"
UPDATE_URL="$BASE_URL/update.xml"
CODEBASE_URL="$BASE_URL/$CRX_FILE"

VERSION="$(node -p "require('$ROOT_DIR/manifest.json').version")"
APP_ID="$(openssl rsa -in "$PEM_PATH" -pubout -outform DER 2>/dev/null | openssl dgst -sha256 -binary | head -c 16 | xxd -p -c 32 | tr '0-9a-f' 'a-p')"

if [[ -z "$APP_ID" ]]; then
  echo "Error: failed to derive extension ID from PEM file."
  exit 1
fi

mkdir -p "$ROOT_DIR/policies"

cat > "$ROOT_DIR/update.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="update.xsl"?>
<gupdate xmlns="http://www.google.com/update2/response" protocol="2.0">
  <app appid="$APP_ID">
    <updatecheck
      codebase="$CODEBASE_URL"
      version="$VERSION" />
  </app>
</gupdate>
EOF

cat > "$ROOT_DIR/policies/windows-intune-oma-uri.txt" <<EOF
Name: Chrome - ADMX - Force-install extension
OMA-URI: ./Device/Vendor/MSFT/Policy/Config/Chrome~Policy~googlechrome~Extensions/ExtensionInstallForcelist
Data type: String

Value:
<enabled/>
<data id="ExtensionInstallForcelistDesc" value="1&#xF000;$APP_ID;$UPDATE_URL"/>
EOF

cat > "$ROOT_DIR/policies/windows-intune-oma-uri-edge.txt" <<EOF
Name: Edge - ADMX - Force-install extension
OMA-URI: ./Device/Vendor/MSFT/Policy/Config/Edge~Policy~microsoft_edge~Extensions/ExtensionInstallForcelist
Data type: String

Value:
<enabled/>
<data id="ExtensionInstallForcelistDesc" value="1&#xF000;$APP_ID;$UPDATE_URL"/>
EOF

cat > "$ROOT_DIR/policies/linux-managed-policy.json" <<EOF
{
  "ExtensionInstallForcelist": [
    "$APP_ID;$UPDATE_URL"
  ]
}
EOF

cat > "$ROOT_DIR/policies/linux-edge-managed-policy.json" <<EOF
{
  "ExtensionInstallForcelist": [
    "$APP_ID;$UPDATE_URL"
  ]
}
EOF

cat > "$ROOT_DIR/policies/macos-com.google.Chrome.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>ExtensionInstallForcelist</key>
  <array>
    <string>$APP_ID;$UPDATE_URL</string>
  </array>
</dict>
</plist>
EOF

cat > "$ROOT_DIR/policies/macos-com.microsoft.Edge.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>ExtensionInstallForcelist</key>
  <array>
    <string>$APP_ID;$UPDATE_URL</string>
  </array>
</dict>
</plist>
EOF

cat > "$ROOT_DIR/policies/firefox-enterprise-policies.json" <<EOF
{
  "policies": {
    "ExtensionSettings": {
      "$FIREFOX_ID": {
        "installation_mode": "force_installed",
        "install_url": "$FIREFOX_XPI_URL"
      }
    }
  }
}
EOF

echo "Generated update and policy files successfully."
echo "Derived Chromium extension ID: $APP_ID"
echo "Update URL: $UPDATE_URL"
