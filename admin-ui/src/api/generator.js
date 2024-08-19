import request from '../utils/request'


export function generateAPIGeneratorAPI(mode) {
    return request({
        url: `/generate/api/${mode}`,
        method: 'get',
        responseType: 'blob'
    })
}

export function generateTypeJSGeneratorAPI(mode) {
    return request({
        url: `/generate/type/${mode}`,
        method: 'get',
        responseType: 'blob'
    })
}
export function listGenerateAPI() {
    return request({
        url: `/generate/list`,
        method: 'get',
    })
}

