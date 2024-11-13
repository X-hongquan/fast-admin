import request from '@/utils/request.js'

export function getBannedListBannedAPI() {
    return request({
        url: '/banned',
        method: 'get',
    })
}

export function offlineBannedAPI(token) {
    return request({
        url: '/banned/offline',
        method: 'post',
        data: token
    })
}

export function bannedBannedAPI(token) {
    return request({
        url: '/banned',
        method: 'post',
        data: token
    })
}

