import request from "@/utils/request.js";

export function getSettingAPI() {
    return request({
        url: '/setting',
        method: 'get',
        params: {
            id: 1
        }
    })
}

export function updateSettingAPI(data) {
    return request({
        url: '/setting',
        method: 'put',
        data
    })
}
