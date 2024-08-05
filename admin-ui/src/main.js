import {createApp} from 'vue'
import App from './App.vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import '@/styles/index.scss'
import {createPinia} from "pinia";
import router from "@/router"
import '@/utils/permission.js'
import GlobalComponents from './components'
import 'virtual:svg-icons-register'
import 'element-plus/theme-chalk/dark/css-vars.css'
import zhCn from 'element-plus/dist/locale/zh-cn.mjs'
const app = createApp(App)
export const icons=[]
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
    icons.push(key)
}

const pinia = createPinia()
app.use(pinia)
app.use(GlobalComponents)
app.use(ElementPlus,{
    locale: zhCn,
})
app.use(router)

app.mount('#app')
