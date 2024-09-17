import router from "@/router/index.js";
import nprogress from 'nprogress'
import 'nprogress/nprogress.css'
import setting from '../../setting.js'
import {useUserStore} from "@/store/user.js";
import {removeToken} from "@/utils/token.js";
import {closeSocket, createSocket} from "@/utils/socket.js";


//引入所有views下.vue文件
nprogress.configure({ showSpinner: false });
const modules = import.meta.glob("../views/**/**.vue")

export const routerPackage = function (routers, routeName) {
    if (routers) {
        routers.forEach((itemRouter) => {
            if (routeName) {
                if (itemRouter.link===0) {
                    router.addRoute(routeName, {
                        path: itemRouter.url,
                        name: itemRouter.name,
                        redirect: itemRouter.redirect || undefined,
                        meta: {
                            title: itemRouter.title,
                            icon: itemRouter.icon
                        },
                        component:
                        //本地能使用，上生产直接裂开~~
                        //()=>import(/* @vite-ignore */ `/@views/${itemRouter.component}`),
                        //使用modules
                            modules[`../views/${itemRouter.component}.vue`],
                    })
                }
            } else {
                if (itemRouter.link===0) {
                    router.addRoute({
                        path: itemRouter.url,
                        name: itemRouter.name,
                        redirect: itemRouter.redirect || undefined,
                        meta: {
                            title: itemRouter.title,
                            icon: itemRouter.icon
                        },
                        component:
                        //本地能使用，上生产直接裂开~~
                        //()=>import(/* @vite-ignore */ `/@views/${itemRouter.component}`),
                        //使用modules
                            modules[`../views/${itemRouter.component}.vue`],
                    })
                }
            }

            if (itemRouter.children && itemRouter.children.length) {
                routerPackage(itemRouter.children, itemRouter.name)
            }
        })
    }
}

router.beforeEach(async (to, from) => {
    nprogress.start()
    const userStore = useUserStore()
    if (userStore.token) {
        if (!userStore.userInfo) {
            try {
                await userStore.getUserInfo();
            } catch (e) {
                userStore.token = undefined
                removeToken()
                return '/login'
            }
            await createSocket()
            if (!userStore.menus)
                await userStore.getMenuList();
            if (!router.hasRoute(to.path)) {
                const menus = userStore.menus
                routerPackage(menus)
                return to.path
            }

        }
        if (to.path === '/login') {
            return '/'
        }
    } else {
        closeSocket()
        if (to.path !== '/login') {
            return '/login'
        }
    }
    return true
})

router.afterEach((to, from) => {
    document.title = setting.logoTitle + '-' + to.meta.title
    nprogress.done()
})








