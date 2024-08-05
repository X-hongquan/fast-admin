import {defineStore} from "pinia";
import {ref} from "vue";

export const useSettingStore = defineStore('setting', () => {
    const fold = ref(false)
    const theme=ref(false)
    const refresh=ref(false)
    return {
        fold,theme,refresh
    }
})
