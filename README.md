# Ecourt_Filing_Account_Enforcer

Browser extension to restrict misuse of filing access on the eCourts portal:
https://filing.ecourts.gov.in/pdedev/

## Background

At Rajpati and Associates firm, a typist named Deepak used to file other people's cases on my computer using my Wi-Fi and system access. To protect my law firm reputation and device/account usage, I created this extension.

## Browser support

- Chromium browsers: Chrome, Edge, Brave, Opera, Vivaldi
- Firefox: supported through enterprise policy with signed XPI deployment
- Safari: requires separate conversion/signing workflow with Xcode

## Hosted files (Chromium browsers)

Host these files publicly (for example, via GitHub Pages):

- Ecourt_Filing_Account_Enforcer.crx
- update.xml
- update.xsl (optional, only for human-readable XML display)

Update URL:

- https://surventurer.github.io/Ecourt_Filing_Account_Enforcer/update.xml

Extension IDs:

- Chromium ID: mkpefpjifpafgifmfphlaedpgaamlodk
- Firefox ID: ecourt-filing-account-enforcer@surventurer.github.io

## Policy templates in this repository

- Chrome Windows Intune OMA-URI: policies/windows-intune-oma-uri.txt
- Chrome Linux managed policy: policies/linux-managed-policy.json
- Chrome macOS managed preferences: policies/macos-com.google.Chrome.plist
- Edge Windows Intune OMA-URI: policies/windows-intune-oma-uri-edge.txt
- Edge Linux managed policy: policies/linux-edge-managed-policy.json
- Edge macOS managed preferences: policies/macos-com.microsoft.Edge.plist
- Firefox enterprise policy: policies/firefox-enterprise-policies.json

Note: In policies/firefox-enterprise-policies.json, replace install_url with your real signed XPI URL.

## Important install note

Do not install by opening the CRX URL directly in Chromium browsers. Direct CRX URL install is blocked in modern browsers and can show CRX_REQUIRED_PROOF_MISSING.

Use force-install policy for production deployment.

## Manual testing (local)

For local testing only:

1. Open extensions page:
	- Chrome/Brave/Opera/Vivaldi: chrome://extensions
	- Edge: edge://extensions
	- Firefox: about:debugging#/runtime/this-firefox
2. Enable Developer mode (Chromium browsers).
3. Load unpacked extension from this project folder.

## Validation after policy rollout

1. Open policy page:
	- Chromium browsers: chrome://policy or edge://policy
	- Firefox: about:policies
2. Reload policies.
3. Confirm force-install entry is present.
4. Restart browser and verify extension is installed and active.