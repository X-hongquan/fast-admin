import {defineStore} from "pinia";
import {ref} from "vue";
import {getSettingAPI, updateSettingAPI} from "@/api/system/setting.js";

export const useSettingStore = defineStore('setting', () => {
    const fold = ref(false)
    const theme = ref(false)
    const refresh = ref(false)
    const setting = ref({
        permissionMode: 0
    })

    async function updateSetting() {
        const res = await updateSettingAPI(setting.value)
        if (res.code === 200) {
            return 'ok'
        } else {
            return Promise.reject(new Error('更新设置失败'))
        }
    }
    async function getSetting() {
        const res = await getSettingAPI()
        if (res.code === 200) {
            setting.value = res.data
            return 'ok'
        } else {
            return Promise.reject(new Error('获取设置失败'))
        }
    }

    return {
        fold, theme, refresh, getSetting, setting,updateSetting
    }
})
