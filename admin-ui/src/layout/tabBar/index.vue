<script setup>
import Setting from './setting/index.vue'
import BreadCrumb from './breadcrumb/index.vue'
</script>

<template>
<div class="tabBar">
  <BreadCrumb></BreadCrumb>
  <Setting></Setting>
</div>
</template>

<style scoped lang="scss">
.tabBar {
  display: flex;
  justify-content: space-between;
  height: 100%;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
