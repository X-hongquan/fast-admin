import request from "@/utils/request.js";


export function loginAPI(data) {
    return request({
        url: '/user/login',
        method: 'post',
        data
    })
}

export function logoutAPI() {
    return request({
        url: '/user/logout',
        method: 'get'
    })
}

export function getUserInfoAPI() {
    return request({
        url: '/user/info',
        method: 'get'
    })
}

export function sendEmailCodeAPI(val) {
    return request({
        url: `/user/info/code/{val}`,
        method: 'get',
        params: val
    })
}

export function sendPwdCodeAPI() {
    return request({
        url: `/user/info/code/password`,
        method: 'get'
    })
}

export function changeAvatarAPI(formData) {
    return request({
        url: '/user/info/avatar',
        method: 'put',
        data: formData
    })
}

export function changePasswordAPI(data) {
    return request({
        url: '/user/info/password',
        method: 'put',
        data
    })
}

export function resetPasswordAPI(data) {
    return request({
        url: '/user/info/password/reset',
        method: 'put',
        data
    })
}

export function resetEmailAPI(data) {
    return request({
        url: '/user/info/email/reset',
        method: 'put',
        data
    })
}

export function getUserListAPI(params) {
    return request({
        url: '/user/list',
        method: 'get',
        params
    })
}
export function getUserAPI(id) {
    return request({
        url: `/user/${id}`,
        method: 'get'
    })
}
export function addUserAPI(data) {
    return request({
        url: '/user',
        method: 'post',
        data
    })
}
export function updateUserAPI(data) {
    return request({
        url: '/user',
        method: 'put',
        data
    })
}
export function deleteUserAPI(ids) {
    return request({
        url: '/user/{ids}',
        method: 'delete',
        params: ids
    })
}

