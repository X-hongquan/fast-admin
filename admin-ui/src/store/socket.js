import {defineStore} from "pinia";
import {ref} from "vue";

export const useSocketStore = defineStore('socket', () => {

    const onlineCount = ref(0)
    return {onlineCount}
})
