#!/bin/bash

# 定义 TTF 和 OTF 字体的目标目录
TTF_DIR="$HOME/.local/share/fonts/TTF"
OTF_DIR="$HOME/.local/share/fonts/OTF"

# 检查 TTF 和 OTF 字体目录是否存在，如果不存在则创建
if [ ! -d "$TTF_DIR" ]; then
    echo "TTF 字体目录不存在，正在创建..."
    mkdir -p "$TTF_DIR"
fi
if [ ! -d "$OTF_DIR" ]; then
    echo "OTF 字体目录不存在，正在创建..."
    mkdir -p "$OTF_DIR"
fi

# 遍历当前目录下的所有子目录
for dir in */; do
    # 检查目录是否存在
    if [ -d "$dir" ]; then
        echo "正在检查目录：$dir"
        # 查找并安装所有 .ttf 文件
        find "$dir" -iname "*.ttf" | while read font; do
            echo "正在安装 TTF 字体：$font"
            cp "$font" "$TTF_DIR"
        done
        # 查找并安装所有 .otf 文件
        find "$dir" -iname "*.otf" | while read font; do
            echo "正在安装 OTF 字体：$font"
            cp "$font" "$OTF_DIR"
        done
    else
        echo "警告：目录 $dir 不存在，跳过..."
    fi
done

# 更新字体缓存
echo "更新字体缓存..."
fc-cache -f

echo "所有字体已安装完成。"
