import {ElMessage} from "element-plus";

export function getNotification(res, title = '操作', success, error) {
    if (res.code === 200) {
        if (success instanceof Function)
            success()
        ElMessage({
            type: 'success',
            message: `${title}成功`,
            duration: 1000
        })
    } else {
        if (error instanceof Function)
            error()
        ElMessage({
            type: 'error',
            message: `${res.msg}`,
            duration: 1500
        })
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

