import request from '@/utils/request.js'

export function getUserAPI(id) {
    return request({
        url: '/user/{id}',
        method: 'get',
        params: id,
    })
}

export function addUserAPI(user) {
    return request({
        url: '/user',
        method: 'post',
        data: user
    })
}

export function listUserAPI(user) {
    return request({
        url: '/user/list',
        method: 'get',
        params: user,
    })
}

export function infoUserAPI() {
    return request({
        url: '/user/info',
        method: 'get',
    })
}

export function deleteUserAPI(ids) {
    return request({
        url: '/user/{ids}',
        method: 'delete',
        params: ids,
    })
}

export function exportUserAPI() {
    return request({
        url: '/user/export',
        method: 'get',
        responseType: 'blob'
    })
}

export function sendEmailCodeUserAPI(email) {
    return request({
        url: '/user/info/code/{email}',
        method: 'get',
        params: email,
    })
}

export function changePasswordUserAPI(passwordForm) {
    return request({
        url: '/user/info/password',
        method: 'put',
        data: passwordForm
    })
}

export function resetPasswordUserAPI(passwordForm) {
    return request({
        url: '/user/info/password/reset',
        method: 'put',
        data: passwordForm
    })
}

export function sendPasswordCodeUserAPI() {
    return request({
        url: '/user/info/code/password',
        method: 'get',
    })
}

export function changeAvatarUserAPI(file) {
    return request({
        url: '/user/info/avatar',
        method: 'put',
        data: file
    })
}

export function editUserAPI(user) {
    return request({
        url: '/user',
        method: 'put',
        data: user
    })
}

export function loginUserAPI(loginForm) {
    return request({
        url: '/user/login',
        method: 'post',
        data: loginForm
    })
}

export function resetEmailUserAPI(form) {
    return request({
        url: '/user/info/email/reset',
        method: 'put',
        data: form
    })
}

export function logoutUserAPI() {
    return request({
        url: '/user/logout',
        method: 'get',
    })
}

export function uploadUserAPI(file) {
    return request({
        url: '/user/import',
        method: 'post',
        data: file
    })
}


