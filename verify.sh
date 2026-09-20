#!/usr/bin/env bash
# Verification — uses only commands shown in Ch10/Ch11 material
USERS=("alice" "bob" "carol")
SHARED_DIR="/shared/project"

echo "--- id ---"
for u in "${USERS[@]}"; do id "$u"; done

echo "--- chage -l ---"
for u in "${USERS[@]}"; do
    echo "-- $u --"
    chage -l "$u"
done

echo "--- sudo -l ---"
for u in "${USERS[@]}"; do
    echo "-- $u --"
    sudo -l -U "$u" 2>&1
done

echo "--- shared folder permissions ---"
ls -ld "$SHARED_DIR"
