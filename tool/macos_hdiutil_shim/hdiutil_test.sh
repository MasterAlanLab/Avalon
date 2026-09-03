#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
shim="$script_dir/hdiutil"
temp_dir="$(mktemp -d)"
trap 'rm -rf "$temp_dir"' EXIT

export AVALON_HDIUTIL_RETRY_DELAY=0
calls="$temp_dir/calls"

# Stands in for /usr/bin/hdiutil: records its arguments and behaves according to
# the scenario in $FAKE_MODE.
fake="$temp_dir/fake_hdiutil"
cat > "$fake" <<'FAKE'
#!/usr/bin/env bash
printf '%s\n' "$*" >> "$CALLS"
case "$FAKE_MODE" in
  ok) exit 0 ;;
  busy) exit 1 ;;
  busy_then_gone)
    # First detach fails, but the volume goes away underneath it anyway.
    rm -rf "$MOUNT_POINT"
    exit 1
    ;;
  busy_until_force)
    case "$*" in
      *-force) exit 0 ;;
      *) exit 1 ;;
    esac
    ;;
esac
exit 1
FAKE
chmod +x "$fake"
export AVALON_REAL_HDIUTIL="$fake"
export CALLS="$calls"

reset_calls() {
  : > "$calls"
}

mount_point="$temp_dir/Volumes/Avalon"
export MOUNT_POINT="$mount_point"

mount_volume() {
  mkdir -p "$mount_point"
}

# Non-detach commands are passed straight through, untouched.
reset_calls
FAKE_MODE=ok "$shim" attach image.dmg -nobrowse
diff <(printf '%s\n' "attach image.dmg -nobrowse") "$calls"

# A detach that works is a single call.
reset_calls
mount_volume
FAKE_MODE=ok "$shim" detach "$mount_point"
diff <(printf '%s\n' "detach $mount_point") "$calls"

# An already-unmounted volume succeeds without calling hdiutil at all.
reset_calls
rm -rf "$mount_point"
FAKE_MODE=busy "$shim" detach "$mount_point"
[[ ! -s "$calls" ]]

# The failure seen on CI: detach reports an error, but the volume is gone by the
# time the shim retries, so there is nothing left to unmount.
reset_calls
mount_volume
FAKE_MODE=busy_then_gone "$shim" detach "$mount_point"
diff <(printf '%s\n' "detach $mount_point") "$calls"

# A volume that stays busy is forced out after the graceful attempts.
reset_calls
mount_volume
FAKE_MODE=busy_until_force "$shim" detach "$mount_point"
diff <(printf '%s\n' \
  "detach $mount_point" \
  "detach $mount_point" \
  "detach $mount_point -force") "$calls"

# A detach that never succeeds still fails, so real errors are not swallowed.
reset_calls
mount_volume
if FAKE_MODE=busy "$shim" detach "$mount_point"; then
  echo "expected the shim to fail when the volume never detaches" >&2
  exit 1
fi
[[ "$(wc -l < "$calls" | tr -d ' ')" -eq 5 ]]

echo "hdiutil shim tests passed"
