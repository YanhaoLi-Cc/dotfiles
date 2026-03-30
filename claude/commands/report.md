---
allowed-tools: Bash
description: create a issue report
---

## Your task

Strictly follow the prompts step by step, do not parallel

1. IF $1 is not provide, THEN Ask the user to CHOOSE whether this is a good case or a bad case, options is just 'good', 'bad' and 'other'; and set to $1

2. IF $2 is not provide, THEN Ask the user to fill the reported remarks; and add to env.issue_remark; and set to $2

3. Execute above bash command

Bash(klaude-report $1 $2)
