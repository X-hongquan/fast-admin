import request from "@/utils/request.js";


export function initMenuAPI() {
    return request({
        url: "/menu/init",
        method: "get",
    })
}
export function getMenuListAPI(params) {
    return request({
        url: "/menu/list",
        method: "get",
        params
    })
}

export function getMenuAPI(id) {
    return request({
        url: `/menu/{id}`,
        method: "get",
        params: id
    })
}

export function addMenuAPI(data) {
    return request({
        url: "/menu",
        method: "post",
        data,
    })
}

export function updateMenuAPI(data) {
    return request({
        url: "/menu",
        method: "put",
        data,
    })
}

export function deleteMenuAPI(ids) {
    return request({
        url: "/menu/{ids}",
        method: "delete",
        params: ids
    })
}
