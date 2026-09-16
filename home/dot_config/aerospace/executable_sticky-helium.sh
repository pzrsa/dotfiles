#!/bin/sh

set -eu

AEROSPACE=/opt/homebrew/bin/aerospace
APP_ID=net.imput.helium

ws="${1:-${AEROSPACE_FOCUSED_WORKSPACE:-}}"
if [ -z "$ws" ]; then
    ws="$("$AEROSPACE" list-workspaces --focused)"
fi

target_monitor="$("$AEROSPACE" list-workspaces --all --format '%{workspace}|%{monitor-id}' \
    | awk -F'|' -v ws="$ws" '$1 == ws { print $2; exit }')"

[ -n "$target_monitor" ] || exit 0

"$AEROSPACE" list-windows --all --format '%{window-id}|%{app-bundle-id}|%{window-title}|%{window-layout}|%{monitor-id}|%{workspace}' \
    | while IFS='|' read -r window_id app_id window_title window_layout window_monitor window_workspace; do
        [ "$app_id" = "$APP_ID" ] || continue
        [ "$window_layout" = "floating" ] || continue

        case "$window_title" in
            *"Picture in Picture"*|*"Picture-in-Picture"*|*"Picture-in-picture"*|Meet*)
                ;;
            *)
                continue
                ;;
        esac

        [ "$window_monitor" = "$target_monitor" ] || continue
        [ "$window_workspace" != "$ws" ] || continue

        "$AEROSPACE" move-node-to-workspace --window-id "$window_id" "$ws" >/dev/null 2>&1 || true
    done
