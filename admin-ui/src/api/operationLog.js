import request from '@/utils/request.js'


export function listOperationLogAPI(operationLog) {
    return request({
        url: '/operationLog/list',
        method: 'get',
        params: operationLog
    })
}

export function getOperationLogAPI(id) {
    return request({
        url: '/operationLog/{id}',
        method: 'get',
        params: id
    })
}

export function addOperationLogAPI(operationLog) {
    return request({
        url: '/operationLog',
        method: 'post',
        data: operationLog
    })
}

export function editOperationLogAPI(operationLog) {
    return request({
        url: '/operationLog',
        method: 'put',
        data: operationLog
    })
}

export function deleteOperationLogAPI(ids) {
    return request({
        url: '/operationLog/{ids}',
        method: 'delete',
        params: ids
    })
}



