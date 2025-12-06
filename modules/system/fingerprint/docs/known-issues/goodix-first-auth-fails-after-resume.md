# Goodix Fingerprint First Authentication Fails After Resume

## Symptom

After waking from sleep/suspend, the first fingerprint authentication attempt always fails. The second attempt typically succeeds.

## Cause

The Goodix fingerprint reader (USB ID `27c6:658c`) undergoes multiple USB resets after the system resumes from sleep. When authentication is attempted immediately after wake, the USB device is still reinitializing, causing fprintd to fail the read.

Typical timeline from journal logs:
```
13:00:34 - System returns from sleep
13:00:44 - USB device reset (first)
13:00:44 - fprintd daemon starts
13:00:44 - USB device reset (second)
13:00:46 - First auth attempt fails
13:00:48 - Second auth attempt fails
13:00:50 - USB device reset (third)
13:00:50 - Auth succeeds
```

## Impact

Minor inconvenience - users must attempt fingerprint authentication twice after waking from sleep.

## Diagnosis

Check journal logs after resume:
```bash
journalctl -b | grep -E "usb 3-5.4|fprintd|authentication failure"
```

Look for USB reset messages interleaved with authentication failures.

## Possible Workarounds

1. **Post-resume fprintd restart with delay**: Create a systemd service that restarts fprintd a few seconds after resume to ensure it re-probes the device when ready.

2. **udev rule for device reprobe**: Add a udev rule that triggers a device reprobe after resume.

3. **Wait before authenticating**: Simply wait 2-3 seconds after opening the lid before attempting fingerprint authentication.

## Upstream Status

This is a general issue with USB fingerprint readers on Linux after suspend/resume, not specific to NixOS. The Goodix driver and fprintd do not currently have built-in retry logic for post-resume USB reinitialization.

## Related Links

- fprintd upstream: https://gitlab.freedesktop.org/libfprint/fprintd
- libfprint (Goodix driver): https://gitlab.freedesktop.org/libfprint/libfprint
