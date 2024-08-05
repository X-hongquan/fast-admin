import {ElMessage} from "element-plus";

export function getNotification(res, title = '操作', success, error) {
    if (res.code === 200) {
        if (success instanceof Function)
            success()
        ElMessage.success(`${title}成功`)
    } else {
        if (error instanceof Function)
            error()
        ElMessage.error(`${title}失败,${res.msg}`)
    }
}

export function addNotification(res, success, error) {
    getNotification(res, '添加', success, error)
}

export function updateNotification(res, success, error) {
    getNotification(res, '修改', success, error)
}

export function deleteNotification(res, success, error) {
    getNotification(res, '删除', success, error)
}

