#!/usr/bin/env bash
set -euo pipefail

GROUP="devteam"
USERS=("alice" "bob" "carol")
SUDO_USER_NAME="alice"
SHARED_DIR="/shared/project"

echo "== Create group and users =="
groupadd -f "$GROUP"

for u in "${USERS[@]}"; do
    if ! id "$u" &>/dev/null; then
        useradd -m -G "$GROUP" "$u"
        echo "Created user: $u"
    fi
    echo "$u:ChangeMe123!" | chpasswd
done

echo "== Password aging policy =="
for u in "${USERS[@]}"; do
    chage -M 60 -W 7 -d 0 "$u"
done

echo "== Superuser access via /etc/sudoers.d =="
SUDOERS_FILE="/etc/sudoers.d/${SUDO_USER_NAME}"
echo "${SUDO_USER_NAME} ALL=(ALL) ALL" > "$SUDOERS_FILE"
chmod 440 "$SUDOERS_FILE"

echo "== Create the shared directory =="
mkdir -p "$SHARED_DIR"

echo "== Ownership + special permissions =="
chown root:"$GROUP" "$SHARED_DIR"
chmod 2775 "$SHARED_DIR"
chmod o+t "$SHARED_DIR"
echo "Permissions now: $(stat -c '%A' "$SHARED_DIR")"

echo "== Provisioning complete =="

