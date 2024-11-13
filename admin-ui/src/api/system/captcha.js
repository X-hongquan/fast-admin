import request from '@/utils/request.js'

export function getCaptChaAPI() {
    return request({
        url: '/captcha',
        method: 'get',
    })
}
