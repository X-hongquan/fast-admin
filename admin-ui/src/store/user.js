import {defineStore} from "pinia";
import {ref} from "vue";
import { infoUserAPI, loginUserAPI, logoutUserAPI} from "@/api/user.js";
import {getToken, removeToken, setToken} from "@/utils/token.js";
import {initMenuAPI} from "@/api/menu.js";
import {preHandleMenu} from "@/utils/init.js";
import {closeSocket} from "@/utils/socket.js";


export const useUserStore = defineStore('user', () => {
        const userInfo = ref()
        const token = ref(getToken())
        const menus = ref()


        async function login(data) {
            const res = await loginUserAPI(data)
            if (res.code === 200) {
                setToken(res.data)
                if (!token.value)
                    token.value = getToken()
                return 'ok'
            } else {
                return Promise.reject(new Error(res.msg))
            }
        }

        async function changeAvatar() {
            if (!token.value)
                token.value = getToken()
        }

        async function changePassword() {
            if (!token.value)
                token.value = getToken()
        }

        async function changeUserInfo() {
            if (!token.value)
                token.value = getToken()
        }

        async function getUserInfo() {
            const res = await infoUserAPI()
            if (res.code === 200) {
                userInfo.value = res.data
                return 'ok'
            }
            return Promise.reject(new Error(res.msg))
        }

        async function logout() {
            const res = await logoutUserAPI()
            if (res.code === 200) {
                removeToken()
                token.value = undefined
                userInfo.value = undefined
                menus.value = undefined
                closeSocket()
                return 'ok'
            }
            return Promise.reject(new Error(res.msg))
        }

        async function getMenuList() {
            const res = await initMenuAPI()
            if (res.code === 200) {
                const {arr} = preHandleMenu(res.data)
                menus.value = arr
                return 'ok'
            }
            return Promise.reject(new Error(res.msg))
        }



        return {userInfo, token, login, getUserInfo, getMenuList, logout, menus}
    },
)



