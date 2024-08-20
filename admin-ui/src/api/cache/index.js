import request from '@/utils/request.js'


export function addCacheAPI(dto) {
    return request({
        url: '/cache',
        method: 'post',
        data: dto
    })
}

export function listCacheAPI() {
    return request({
        url: '/cache/list',
        method: 'get'
    })
}

export function delCacheAPI(node) {
    return request({
        url: '/cache',
        method: 'delete',
        data: node
    })
}

export function infoCacheAPI(key) {
    return request({
        url: '/cache/info/{key}',
        method: 'get',
        params: key
    })
}

