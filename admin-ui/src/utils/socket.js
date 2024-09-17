import {getToken} from "@/utils/token.js";
import {getUserInfoAPI} from "@/api/user/index.js";

let socket

const baseUrl = import.meta.env.VITE_APP_BASE_WS_URL

export async function createSocket() {

    socket = new WebSocket(baseUrl + getToken())
    socket.onopen = function (event) {
        console.log('连接初始化')
    }
    socket.onclose = function (event) {
        console.log('连接关闭')
        if (socket !== undefined)
            setTimeout(createSocket, 5000)
    }
    socket.onerror = function (event) {
        console.log('连接错误')
    }
}

export function closeSocket() {
    if (socket !== undefined) {
        socket.close()
        socket = undefined
    }
}

export function getSocket() {
    return socket
}

export function sendMessage(data) {
    socket.send(data)
}
