#!/bin/sh
# 保存为 git-time.sh && chmod +x git-time.sh
echo "file,create_time,modify_time"
git ls-files | while read f; do
    # 最早一次提交时间（近似创建）
    c_time=$(git log --diff-filter=A --format=%ct -1 -- "$f" 2>/dev/null || echo '')
    # 最近一次提交时间（变更）
    m_time=$(git log -1 --format=%ct -- "$f")
    # 转成可读格式（去掉下一行则保持 Unix 秒）
    [ -n "$c_time" ] && c_time=$(date -d @$c_time '+%F %T') || c_time='MISSING'
    m_time=$(date -d @$m_time '+%F %T')
    echo "\"$f\",\"$c_time\",\"$m_time\""
done
