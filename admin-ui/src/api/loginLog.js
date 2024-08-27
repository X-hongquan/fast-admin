import request from '@/utils/request.js'

export function listLoginLogAPI(loginLog) {
    return request({
        url: '/loginLog/list',
        method: 'get',
        params: loginLog,
    })
}

export function deleteLoginLogAPI(ids) {
    return request({
        url: '/loginLog/{ids}',
        method: 'delete',
        params: ids,
    })
}
