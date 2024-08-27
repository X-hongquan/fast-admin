import request from '@/utils/request.js'


export function list${className}API(${paramsName}) {
    return request({
        url: '/${paramsName}/list',
        method: 'get',
        params: ${paramsName}
    })
}

export function get${className}API(id) {
    return request({
        url: '/${paramsName}/{id}',
        method: 'get',
        params: id
    })
}

export function add${className}API(${paramsName}) {
    return request({
        url: '/${paramsName}',
        method: 'post',
        data: ${paramsName}
    })
}

export function edit${className}API(${paramsName}) {
    return request({
        url: '/${paramsName}',
        method: 'put',
        data: ${paramsName}
    })
}

export function delete${className}API(ids) {
    return request({
        url: '/${paramsName}/{ids}',
        method: 'delete',
        params: ids
    })
}



