import {createRouter, createWebHistory} from "vue-router"

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/',
            name: 'layout',
            component: () => import('@/layout/index.vue'),
            meta: {hide: true},
            redirect: '/home',
            children: [
                {
                    path: '/home',
                    name: 'home',
                    component: () => import('@/views/home/index.vue'),
                    meta: {title: '首页'}
                },
                {
                    path: '/person',
                    name: 'person',
                    component: () => import('@/views/person/index.vue'),
                    meta: {title: '个人中心', icon: 'User'}
                }
            ]
        },
        {
            path: '/login',
            name: 'login',
            component: () => import('@/views/login/index.vue'),
            meta: {title: '登录页面'}
        },
        {
            path: '/404',
            name: '404',
            component: () => import('@/views/404/index.vue'),
        }


    ]
})

export default router
