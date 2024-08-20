import request from '@/utils/request.js'


export function getPermissionListAPI(params) {
    return request({
        url: '/permission/list',
        method: 'get',
        params
    })
}

export function getPermissionAPI(id) {
    return request({
        url: `/permission/{id}`,
        method: 'get',
        params: id
    })
}

export function addPermissionAPI(data) {
    return request({
        url: '/permission',
        method: 'post',
        data
    })
}

export function updatePermissionAPI(data) {
    return request({
        url: '/permission',
        method: 'put',
        data
    })
}

export function deletePermissionAPI(ids) {
    return request({
        url: `/permission/{ids}`,
        method: 'delete',
        params: ids
    })
}
