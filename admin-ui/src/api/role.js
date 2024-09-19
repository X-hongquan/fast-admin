import request from '@/utils/request.js'

export function getRoleAPI(id) {
    return request({
        url: '/role/{id}',
        method: 'get',
        params: id,
    })
}

export function addRoleAPI(role) {
    return request({
        url: '/role',
        method: 'post',
        data: role
    })
}

export function listRoleAPI(role) {
    return request({
        url: '/role/list',
        method: 'get',
        params: role,
    })
}

export function deleteRoleAPI(ids) {
    return request({
        url: '/role/{ids}',
        method: 'delete',
        params: ids,
    })
}

export function assignPermissionRoleAPI(dto) {
    return request({
        url: '/role/assign/permission',
        method: 'put',
        data: dto
    })
}

export function editRoleAPI(role) {
    return request({
        url: '/role',
        method: 'put',
        data: role
    })
}

export function assignMenuRoleAPI(dto) {
    return request({
        url: '/role/assign/menu',
        method: 'put',
        data: dto
    })
}

