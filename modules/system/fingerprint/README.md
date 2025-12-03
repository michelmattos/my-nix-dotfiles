# Fingerprint Authentication

Enables fingerprint authentication using fprintd for sudo, login, and greetd.

## Enrolling Fingerprints

After rebuilding, enroll your fingerprint:

```bash
sudo fprintd-enroll "$(whoami)"
```

This runs as root but enrolls the fingerprint for your user account. You'll be prompted to touch the sensor several times.

## Verifying

Test that enrollment worked:

```bash
fprintd-verify
```

## Usage

- **sudo**: Touch the sensor when prompted, or press Enter to type password
- **login/greetd**: Same behavior - fingerprint or fallback to password

## Managing Fingerprints

```bash
# List enrolled fingerprints
fprintd-list $USER

# Delete all enrolled fingerprints
fprintd-delete $USER

# Re-enroll
sudo fprintd-enroll "$(whoami)"
```

## Troubleshooting

If the sensor isn't detected, check it's recognized:

```bash
nix-shell -p usbutils

lsusb | grep -i finger
# or
lsusb | grep -i goodix
```

Fingerprint data is stored in `/var/lib/fprint/`.
