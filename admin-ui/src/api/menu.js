import request from '@/utils/request.js'

export function getMenuAPI(id) {
    return request({
        url: '/menu/{id}',
        method: 'get',
        params: id,
    })
}

export function addMenuAPI(menu) {
    return request({
        url: '/menu',
        method: 'post',
        data: menu
    })
}

export function listMenuAPI(menu) {
    return request({
        url: '/menu/list',
        method: 'get',
        params: menu,
    })
}

export function initMenuAPI(menu) {
    return request({
        url: '/menu/init',
        method: 'get',
        params: menu,
    })
}

export function deleteMenuAPI(ids) {
    return request({
        url: '/menu/{ids}',
        method: 'delete',
        params: ids,
    })
}

export function editMenuAPI(menu) {
    return request({
        url: '/menu',
        method: 'put',
        data: menu
    })
}

