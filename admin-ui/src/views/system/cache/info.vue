<script setup>
import CodeBox from "@/components/CodeBox/index.vue";
import {onUnmounted, reactive, watch} from "vue";
import {useRoute} from "vue-router";
import {infoCacheAPI} from "@/api/system/cache.js";

const route = useRoute()
let times
const cacheDto = reactive({
  value: undefined,
  key: undefined,
  expire: undefined
})

async function getCacheValue(key) {
  clearInterval(times)
  const res = await infoCacheAPI(key)
  if (res.code === 200) {
    let val = res.data.value
    try {
      cacheDto.value = JSON.stringify(JSON.parse(val), null, 2)
    } catch (e) {
      cacheDto.value = val
    }
    cacheDto.expire = res.data.expire
    cacheDto.key = key
    times = setInterval(() => {
      if (cacheDto.expire > 0)
        cacheDto.expire--
    }, 1000)

  }
}

watch(() => route.params.key, (newVal, oldVal) => {
  getCacheValue(newVal)
}, {immediate: true})

onUnmounted(()=>{
  clearInterval(times)
})
</script>


<template>
  <div style="display: flex;align-items: center;justify-content: space-between"><span>TTL: {{ cacheDto.expire }}</span>
  </div>
  <CodeBox :data="cacheDto.value" :header="cacheDto.key"></CodeBox>
</template>

<style scoped lang="scss">

</style>
