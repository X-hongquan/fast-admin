import request from "@/utils/request.js";
export function listGeneratorAPI() {
    return request({
        url: '/generate/list',
        method: 'get',
    })
}

export function exportZipGeneratorAPI() {
    return request({
        url: '/generate/api/js',
        method: 'get',
        responseType: 'blob'
    })
}

export function exportTypeGeneratorAPI() {
    return request({
        url: '/generate/type/js',
        method: 'get',
        responseType: 'blob'
    })
}
