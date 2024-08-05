/** confirm.js */
import {ElMessageBox} from "element-plus";


export function handleConfirm(fn, text = '确认执行此操作吗？', title = '警告', type = 'warning') {
    ElMessageBox.confirm(text, title, {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: type,
    }).then(() => {fn()}).catch(() => {})
}

export function handleConfirmDel(fn, text="确认删除吗", title='删除', type) {
    handleConfirm(fn, text, title, type)
}

export function handleConfirmAdd(fn, text="确认添加吗", title='添加', type) {
    handleConfirm(fn, text, title, type)
}
export function handleConfirmUpdate(fn, text="确认修改吗", title='修改', type) {
    handleConfirm(fn, text, title, type)
}
