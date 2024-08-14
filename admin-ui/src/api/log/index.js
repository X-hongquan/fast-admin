import request from '@/utils/request.js'


export function getLogListAPI(params) {
  return request({
    url: '/log/list',
    method: 'get',
    params
  })
}
