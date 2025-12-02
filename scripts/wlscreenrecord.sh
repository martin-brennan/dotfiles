#!/bin/bash
set -euo pipefail

OUTPUT_DIR="$HOME/ScreenRecordings"
PIDFILE="/tmp/wl-screenrec.pid"

if [[ ! -d "$OUTPUT_DIR" ]]; then
  notify-send "Screen recording directory does not exist: $OUTPUT_DIR" -u critical -t 3000
  exit 1
fi

SCOPE=""
AUDIO="false"
WEBCAM="false"

for arg in "$@"; do
  case "$arg" in
    --with-audio) AUDIO="true" ;;
    --with-webcam) WEBCAM="true" ;;
    output|region) SCOPE="$arg" ;;
  esac
done

# -------------------- Webcam overlay helpers --------------------
cleanup_webcam() {
  pkill -f "WebcamOverlay" 2>/dev/null || true
}

start_webcam_overlay() {
  cleanup_webcam

  # Get monitor scale for target overlay size
  local scale
  scale=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .scale')

  local target_width
  target_width=$(awk "BEGIN {printf \"%.0f\", 360 * $scale}")

  local preferred_resolutions=("640x360" "1280x720" "1920x1080")
  local video_size_arg=""
  local available_formats
  available_formats=$(v4l2-ctl --list-formats-ext -d /dev/video0 2>/dev/null || true)

  for resolution in "${preferred_resolutions[@]}"; do
    if echo "$available_formats" | grep -q "$resolution"; then
      video_size_arg="-video_size $resolution"
      break
    fi
  done

  ffplay -f v4l2 $video_size_arg -framerate 30 /dev/video0 \
    -vf "scale=${target_width}:-1" \
    -window_title "WebcamOverlay" \
    -noborder \
    -fflags nobuffer -flags low_delay \
    -probesize 32 -analyzeduration 0 \
    -loglevel quiet &
  sleep 1
}

# -------------------- Audio mix (PipeWire/Pulse) --------------------
# We create a temporary null-sink (record_mix) and loop back:
#   - default *output* monitor  -> record_mix
#   - default *input* (mic)     -> record_mix
# Then we record record_mix.monitor with wl-screenrec --audio-device
AUDIO_STATE_FILE="$(mktemp -u /tmp/wlsr-audio-XXXXXX)"
NULL_SINK_NAME="record_mix"

create_audio_mix() {
  # Defaults
  local def_sink def_source
  def_sink=$(pactl get-default-sink)
  def_source=$(pactl get-default-source)

  # Create null sink
  local mod_null
  mod_null=$(pactl load-module module-null-sink sink_name="$NULL_SINK_NAME" sink_properties=device.description="$NULL_SINK_NAME")
  # Loopback monitor of default sink (desktop audio) -> null sink
  local mod_loop_out
  mod_loop_out=$(pactl load-module module-loopback source="${def_sink}.monitor" sink="$NULL_SINK_NAME" latency_msec=10)
  # Loopback mic -> null sink
  local mod_loop_mic
  mod_loop_mic=$(pactl load-module module-loopback source="$def_source" sink="$NULL_SINK_NAME" latency_msec=10)

  printf "%s %s %s\n" "$mod_null" "$mod_loop_out" "$mod_loop_mic" > "$AUDIO_STATE_FILE"
}

cleanup_audio_mix() {
  if [[ -f "$AUDIO_STATE_FILE" ]]; then
    read -r mod_null mod_loop_out mod_loop_mic < "$AUDIO_STATE_FILE" || true
    for m in "$mod_loop_mic" "$mod_loop_out" "$mod_null"; do
      [[ -n "${m:-}" ]] && pactl unload-module "$m" >/dev/null 2>&1 || true
    done
    rm -f "$AUDIO_STATE_FILE"
  fi
}

# -------------------- wl-screenrec control --------------------
toggle_screenrecording_indicator() {
  pkill -RTMIN+8 waybar 2>/dev/null || true
}

screenrecording_active() {
  pgrep -f "wl-screenrec" >/dev/null || pgrep -x slurp >/dev/null || pgrep -f "WebcamOverlay" >/dev/null
}

start_screenrecording() {
  local filename="$OUTPUT_DIR/screenrecording-$(date +'%Y-%m-%d_%H-%M-%S').mp4"
  local args=()

  args+=(-m 60 -f "$filename")

  if [[ "$AUDIO" == "true" ]]; then
    create_audio_mix
    args+=(--audio --audio-device "${NULL_SINK_NAME}.monitor")
  fi

  if [[ "${1:-}" == "region" ]]; then
    shift
    args+=(-g "$1")   # geometry like "x,y WxH" (slurp output)
  else
    args+=(-o "$1")   # output name like eDP-1, DP-1
  fi

  wl-screenrec "${args[@]}" &
  echo $! > "$PIDFILE"
  disown
  toggle_screenrecording_indicator
}

stop_screenrecording() {
  # read the tracked PID if present; fall back to name if missing
  local pid=""
  if [[ -f "$PIDFILE" ]]; then
    pid="$(cat "$PIDFILE" 2>/dev/null || true)"
  fi

  if [[ -n "$pid" ]] && ps -p "$pid" >/dev/null 2>&1; then
    # try a gentle stop, then escalate
    kill -INT "$pid" 2>/dev/null || true
  else
    # fallback if PID file missing/stale
    pid="$(pgrep -f '^wl-screenrec( |$)')"
    [[ -n "$pid" ]] && kill -INT "$pid" 2>/dev/null || true
  fi

  # wait up to 5s
  local count=0
  while [[ -n "$pid" ]] && ps -p "$pid" >/dev/null 2>&1 && [ $count -lt 50 ]; do
    sleep 0.1
    count=$((count + 1))
  done

  # escalate if still running
  if [[ -n "$pid" ]] && ps -p "$pid" >/devnull 2>&1; then
    kill -TERM "$pid" 2>/dev/null || true
    sleep 0.5
  fi
  if [[ -n "$pid" ]] && ps -p "$pid" >/dev/null 2>&1; then
    kill -KILL "$pid" 2>/dev/null || true
  fi

  # cleanup + notify
  cleanup_webcam
  cleanup_audio_mix
  rm -f "$PIDFILE"

  if pgrep -f '^wl-screenrec( |$)' >/dev/null; then
    notify-send "Screen recording error" "Recorder had to be force-killed. Video may be corrupted." -u critical -t 5000
  else
    notify-send "Screen recording saved to $OUTPUT_DIR" -t 2000
  fi

  toggle_screenrecording_indicator
}

# -------------------- Main flow --------------------
if screenrecording_active; then
  if pgrep -x slurp >/dev/null; then
    pkill -x slurp 2>/dev/null || true
  elif pgrep -f "WebcamOverlay" >/dev/null && ! pgrep -f "wl-screenrec" >/dev/null; then
    cleanup_webcam
  else
    stop_screenrecording
  fi
elif [[ "$SCOPE" == "output" ]]; then
  [[ "$WEBCAM" == "true" ]] && start_webcam_overlay

  # Choose an output interactively (name only)
  if ! output=$(slurp -o -f "%o"); then
    [[ "$WEBCAM" == "true" ]] && cleanup_webcam
    exit 1
  fi

  if [[ -z "$output" ]]; then
    notify-send "Error" "Could not detect monitor" -u critical
    [[ "$WEBCAM" == "true" ]] && cleanup_webcam
    exit 1
  fi

  start_screenrecording "$output"
else
  [[ "$WEBCAM" == "true" ]] && start_webcam_overlay

  # Region geometry in "x,y WxH" (no scale conversion needed for wl-screenrec)
  if ! region=$(slurp); then
    [[ "$WEBCAM" == "true" ]] && cleanup_webcam
    exit 1
  fi

  start_screenrecording region "$region"
fi
