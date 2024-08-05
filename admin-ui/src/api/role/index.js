import request from '@/utils/request.js'


export function getRoleListAPI(params) {
    return request({
        url: '/role/list',
        method: 'get',
        params
    })
}

export function getRoleAPI(id) {
    return request({
        url: `/role/${id}`,
        method: 'get'
    })
}

export function addRoleAPI(data) {
    return request({
        url: '/role',
        method: 'post',
        data
    })
}

export function updateRoleAPI(data) {
    return request({
        url: '/role',
        method: 'put',
        data
    })
}

export function deleteRoleAPI(ids) {
    return request({
        url: `/role`,
        method: 'delete',
        params: ids
    })
}

export function assignRolePermissionsAPI(data) {
    return request({
        url: '/role/assign/permission',
        method: 'put',
        data
    })
}
export function assignRoleMenusAPI(data) {
    return request({
        url: '/role/assign/menu',
        method: 'put',
        data
    })
}
