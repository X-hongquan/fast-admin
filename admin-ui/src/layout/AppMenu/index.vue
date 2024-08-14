<script setup>
import {useRouter} from "vue-router";

defineProps({
  menus: {
    type: Array,
    default: () => []
  }
})
const router = useRouter()

let documentElement
function goMenu(item) {
  if (item.link===0)
  router.push(item.index)
  else {
    if (!documentElement) {
      documentElement = document.createElement('a')
      documentElement.href = item.url
      documentElement.target = '_blank'
    }
    documentElement.click()
  }
}
</script>

<script>
export default {
  name: 'AppMenu'
}
</script>

<template>
  <template v-for="item in menus">
    <template v-if="!item.children">
      <el-menu-item v-if="item.type===2?false:true" :index="item.url" @click="goMenu(item)">
        <el-icon>
          <component :is="item.icon"></component>
        </el-icon>
        <template #title>
          <span>{{ item.title }}</span>
        </template>
      </el-menu-item>
    </template>

    <el-sub-menu v-else :index="item.url">
      <template #title>
        <el-icon>
          <component :is="item.icon"></component>
        </el-icon>
        <span>{{ item.title }}</span>
      </template>
      <AppMenu :menus="item.children"/>
    </el-sub-menu>

  </template>
</template>


<style scoped lang="scss">

</style>
