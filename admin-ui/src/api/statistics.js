import request from '@/utils/request.js'

export function getLoginCountByYearStatisticsAPI() {
    return request({
        url: '/statistics/login/year',
        method: 'get',
    })
}

export function getLoginCountByMonthStatisticsAPI() {
    return request({
        url: '/statistics/login/month',
        method: 'get',
    })
}

export function getLoginCountByTodayStatisticsAPI() {
    return request({
        url: '/statistics/login/today',
        method: 'get',
    })
}

