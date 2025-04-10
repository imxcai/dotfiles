#!/bin/bash

# 获取当前聚焦的窗口 app_id
focused_app_id=$(swaymsg -t get_tree | jq -r '
  recurse(.nodes[]?, .floating_nodes[]?) 
  | select(.focused == true) 
  | .app_id // .window_properties.class // ""
')

# 查找是否已有 Thunar 窗口
thunar_id=$(swaymsg -t get_tree | jq -r '
  recurse(.nodes[]?, .floating_nodes[]?) 
  | select(.app_id == "thunar" or .window_properties.class == "Thunar") 
  | .id' | head -n 1)

# 如果已经聚焦在 Thunar 上，就关闭它
if [[ "$focused_app_id" == "thunar" || "$focused_app_id" == "Thunar" ]]; then
    swaymsg '[app_id="thunar"] kill' || swaymsg '[class="Thunar"] kill'
    exit 0
fi

# 如果 Thunar 已经打开，但不在焦点上 → 聚焦它
if [[ -n "$thunar_id" ]]; then
    swaymsg "[con_id=$thunar_id]" focus
    exit 0
fi

# 否则：启动 Thunar
thunar &
