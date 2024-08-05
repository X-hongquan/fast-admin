<script setup >
import {ref, watch, nextTick} from "vue";
import {useSettingStore} from "@/store/setting.js";

const settingStore = useSettingStore();
const flag = ref(true)
watch(() => settingStore.refresh, () => {
  flag.value = false
  nextTick(() => {
    flag.value = true
  })
})
</script>

<template>
  <router-view v-slot="{ Component }">
    <transition name="fade">
      <!-- 渲染layout一级路由组件的子路由 -->
      <component :is="Component" v-if="flag"/>
    </transition>
  </router-view>

</template>

<style scoped>
.fade-enter-from {
  opacity: 0;
}

.fade-enter-active {
  transition: all .3s;
}

.fade-enter-to {
  opacity: 1;
}
</style>
