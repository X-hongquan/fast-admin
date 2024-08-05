export function checkUserName(rule, value, callback) {
    if (value.length < 4) {
        callback(new Error('用户名长度不能小于4'))
    } else {
        callback()
    }
}

export function checkPassword(rule, value, callback) {
    if (value.length < 6) {
        callback(new Error('密码长度不能小于6'))
    } else {
        callback()
    }
}

export function checkEmail(rule, value, callback) {
    const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    if (regex.test(value)) {
        callback()
    } else {
        callback(new Error('邮箱格式不正确'))
    }
}

export function checkArray(rule, value, callback) {
    if (value.length === 0) {
        callback(new Error("选项不能为空"))
    }
    callback()
}
