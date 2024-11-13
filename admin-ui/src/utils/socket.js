import {getToken} from "@/utils/token.js";
import {useSocketStore} from "@/store/socket.js";
import {useUserStore} from "@/store/user.js";
import {ElMessage, ElMessageBox, ElNotification} from "element-plus";
const baseUrl = import.meta.env.VITE_APP_BASE_WS_URL

let socket





export async function createSocket() {
    const store = useSocketStore()
    const userStore = useUserStore()
    socket = new WebSocket(baseUrl + getToken())
    socket.onopen = function (event) {
        console.log('连接初始化')
    }
    socket.onclose = function (event) {
        console.log('连接关闭')
        if (socket !== undefined )
            setTimeout(createSocket, 5000)
    }
    socket.onerror = function (event) {
        console.log('连接错误')
    }

    socket.onmessage = function (e) {
        let p = JSON.parse(e.data)
        if (p.type === 1) {
            store.onlineCount = p.data
        } else if (p.type === 2) {
            ElNotification.success({
                title: '系统通知',
                message: p.data,
                duration: 3000
            })
            closeSocket()
        }
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


