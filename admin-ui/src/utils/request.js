import axios from "axios";
import {ElMessage} from "element-plus";
import {useUserStore} from "../store/user.js";
import {idsToPathVariable, objToQueryString} from "./convert.js";


//创建axios实例
let request = axios.create({
    baseURL: import.meta.env.VITE_APP_BASE_API,
    timeout: 20000
})
//请求拦截器
request.interceptors.request.use(config => {
    const userStore = useUserStore()
    config.headers['Authorization'] = userStore.token
    if (config.method === 'get' && config.params) {
        let s = objToQueryString(config.params);
        if (s) {
            config.url = config.url + '?' + s;
        }
        config.params = undefined
    }
    if (config.method === 'delete') {
        let s = idsToPathVariable(config.params);
        config.url = config.url + '/' + s;
        config.params = undefined
    }
    return config;
});
//响应拦截器
request.interceptors.response.use((response) => {
    return response.data;
}, (error) => {
    //处理网络错误
    let msg = '';
    let status = error.response.status;
    switch (status) {
        case 401:
            msg = "token过期,请重新登录";
            break;
        case 403:
            msg = '无权访问';
            break;
        case 404:
            msg = "请求地址错误";
            break;
        case 500:
            msg = "服务器出现问题";
            break;
        default:
            msg = "无网络";

    }
    ElMessage({
        type: 'error',
        message: msg
    })
    return Promise.reject(error);
});
export default request;
