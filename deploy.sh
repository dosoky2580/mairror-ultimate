#!/bin/bash

# 1. إضافة كل التغييرات (المجلدات والملفات الجديدة)
git add .

# 2. رسالة الالتزام (Commit) توضح إننا بنحل تعارض الـ V1 Embedding
git commit -m "Mirror Ultimate v21: Structural Fix & Dependency Resolution"

# 3. الدفع للسحاب
git push origin main

echo "--------------------------------------------------"
echo "✅ تم الرفع يا تامر! روح دلوقتي على GitHub Actions"
echo "السيرفر هيعمل Clean و Upgrade لوحده بناءً على ملف الـ Workflow"
echo "--------------------------------------------------"
