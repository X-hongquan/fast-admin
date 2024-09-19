export function checkUserName(rule, value, callback) {
    if (value.length < 5) {
        callback(new Error('用户名长度不能小于4'))
    } else {
        callback()
    }
}

export function checkPassword(rule, value, callback) {
    if (value.length < 6 || value.length > 20) {
        callback(new Error('密码长度不能小于6或大于20'))
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
    if (!value)
        callback(new Error("选项不能为空"))
    if (value.length === 0) {
        callback(new Error("选项不能为空"))
    }
    callback()
}

export function checkPhone(rule, value, callback) {
    const regex = /^1[3456789]\d{9}$/;
    if (regex.test(value)) {
        callback()
    } else {
        callback(new Error('手机号格式不正确'))
    }

}
