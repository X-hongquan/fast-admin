import request from "@/utils/request.js";
export function listGeneratorAPI() {
    return request({
        url: '/generator/list',
        method: 'get',
    })
}

export function exportZipGeneratorAPI() {
    return request({
        url: '/generator/api/js',
        method: 'get',
        responseType: 'blob'
    })
}

export function exportTypeGeneratorAPI() {
    return request({
        url: '/generator/type/js',
        method: 'get',
        responseType: 'blob'
    })
}
