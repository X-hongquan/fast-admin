import request from '@/utils/request.js'

export function getJobInfoAPI(id) {
    return request({
        url: '/jobInfo/{id}',
        method: 'get',
        params: id,
    })
}

export function addJobInfoAPI(jobInfo) {
    return request({
        url: '/jobInfo',
        method: 'post',
        data: jobInfo
    })
}

export function listJobInfoAPI(jobInfo) {
    return request({
        url: '/jobInfo/list',
        method: 'get',
        params: jobInfo,
    })
}

export function deleteJobInfoAPI(ids) {
    return request({
        url: '/jobInfo/{ids}',
        method: 'delete',
        params: ids,
    })
}

export function startJobInfoAPI(jobInfo) {
    return request({
        url: '/jobInfo/start',
        method: 'put',
        data: jobInfo
    })
}

export function stopJobInfoAPI(jobInfo) {
    return request({
        url: '/jobInfo/stop',
        method: 'put',
        data: jobInfo
    })
}

export function getLogJobInfoAPI(id) {
    return request({
        url: '/jobInfo/log/{id}',
        method: 'get',
        params: id,
    })
}

export function listLogJobInfoAPI(jobInfo) {
    return request({
        url: '/jobInfo/log/list',
        method: 'get',
        params: jobInfo,
    })
}

export function deleteLogJobInfoAPI(ids) {
    return request({
        url: '/jobInfo/log/{ids}',
        method: 'delete',
        params: ids,
    })
}

export function editJobInfoAPI(jobInfo) {
    return request({
        url: '/jobInfo',
        method: 'put',
        data: jobInfo
    })
}

