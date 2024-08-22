import request from '@/utils/request.js'

export function getLogJobInfoAPI(id) {
    return request({
        url: '/job/log/{id}',
        method: 'get',
        params: id
    })
}

export function getJobInfoAPI(id) {
    return request({
        url: '/job/{id}',
        method: 'get',
        params: id
    })
}

export function addJobInfoAPI(jobInfo) {
    return request({
        url: '/job',
        method: 'post',
        data: jobInfo
    })
}

export function listJobInfoAPI(jobInfo) {
    return request({
        url: '/job/list',
        method: 'get',
        params: jobInfo
    })
}

export function deleteJobInfoAPI(ids) {
    return request({
        url: '/job/{ids}',
        method: 'delete',
        params: ids
    })
}

export function startJobInfoAPI(jobInfo) {
    return request({
        url: '/job/start',
        method: 'put',
        data: jobInfo
    })
}

export function stopJobInfoAPI(jobInfo) {
    return request({
        url: '/job/stop',
        method: 'put',
        data: jobInfo
    })
}

export function editJobInfoAPI(jobInfo) {
    return request({
        url: '/job',
        method: 'put',
        data: jobInfo
    })
}

export function listLogJobInfoAPI(jobInfo) {
    return request({
        url: '/job/log/list',
        method: 'get',
        params: jobInfo
    })
}

export function deleteLogJobInfoAPI(ids) {
    return request({
        url: '/job/log/{ids}',
        method: 'delete',
        params: ids
    })
}

