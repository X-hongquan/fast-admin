import request from '@/utils/request.js'

export function getPermissionAPI(id) {
    return request({
        url: '/permission/{id}',
        method: 'get',
        params: id,
    })
}

export function addPermissionAPI(permission) {
    return request({
        url: '/permission',
        method: 'post',
        data: permission
    })
}

export function listPermissionAPI(permission) {
    return request({
        url: '/permission/list',
        method: 'get',
        params: permission,
    })
}

export function deletePermissionAPI(ids) {
    return request({
        url: '/permission/{ids}',
        method: 'delete',
        params: ids,
    })
}

export function editPermissionAPI(permission) {
    return request({
        url: '/permission',
        method: 'put',
        data: permission
    })
}

export function listGroupPermissionAPI(permission) {
    return request({
        url: '/permission/groupByRoleId',
        method: 'get',
        params: permission,
    })
}
