import request from '@/utils/request.js'


export function listDeptAPI(dept) {
    return request({
        url: '/dept/list',
        method: 'get',
        params: dept
    })
}

export function getDeptAPI(id) {
    return request({
        url: '/dept/{id}',
        method: 'get',
        params: id
    })
}

export function addDeptAPI(dept) {
    return request({
        url: '/dept',
        method: 'post',
        data: dept
    })
}

export function editDeptAPI(dept) {
    return request({
        url: '/dept',
        method: 'put',
        data: dept
    })
}

export function deleteDeptAPI(ids) {
    return request({
        url: '/dept/{ids}',
        method: 'delete',
        params: ids
    })
}



