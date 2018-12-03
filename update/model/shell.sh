#!/bin/bash
if [[ -f ${SHELL_ZIP} ]];then
    info "更新shell-sh"
    #1 bak
    mkdir -p ${SHELL_BAK}
    mv ${SHELL_DIR} ${SHELL_BAK}/shell-sh_bak_${DATE}
    #2 update
    unzip -q ${SHELL_ZIP} -d /data
    ok "shell-sh 更新成功"
else
    info "shell-sh 不更新"
fi

