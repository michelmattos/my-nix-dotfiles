# Helium Browser

Local package definition for [Helium](https://github.com/imputnet/helium-chromium), a private, fast, and honest web browser based on Chromium.

This module installs the AppImage version to avoid complex compilation steps.

## Files

- `package.nix` - Package definition using `appimageTools.wrapType2`
- `helium.nix` - Home-manager module that installs the package

## Updating to a new version

1. Check for new releases at https://github.com/imputnet/helium-linux/releases

2. Update the `version` in `package.nix`

3. Get the new hash using one of these methods:

   **Method A: Empty hash trick**
   - Set `sha256 = "";` in `package.nix`
   - Run `nixrebuild`
   - Copy the hash from the error message (`got: sha256-...`)
   - Update `sha256` with the correct value

   **Method B: nix-prefetch-url**
   ```bash
   nix-prefetch-url --type sha256 https://github.com/imputnet/helium-linux/releases/download/VERSION/helium-VERSION-x86_64.AppImage
   nix hash to-sri --type sha256 HASH_FROM_ABOVE
   ```

4. Run `nixrebuild` to apply the update
