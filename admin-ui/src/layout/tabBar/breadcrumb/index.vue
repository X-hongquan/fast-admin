<script setup>
import {useSettingStore} from "@/store/setting.js";

const settingStore = useSettingStore()
</script>

<template>
  <div class="left">
    <el-icon v-show="!settingStore.fold" class="icon" @click="settingStore.fold = !settingStore.fold">
      <Expand/>
    </el-icon>
    <el-icon v-show="settingStore.fold" class="icon" @click="settingStore.fold = !settingStore.fold">
      <Fold/>
    </el-icon>
    <el-breadcrumb separator-icon="ArrowRight">
      <el-breadcrumb-item v-for="(item,index) in $route.matched" :key="index" v-show="item.meta.title" :to="item.path">
        <el-icon class="mid-icon">
          <component :is="item.meta.icon"></component>
        </el-icon>
        <span class="mid-text">{{ item.meta.title }}</span>
      </el-breadcrumb-item>

    </el-breadcrumb>
  </div>
</template>

<style scoped lang="scss">
.left {
  display: flex;
  align-items: center;

  .icon {
    margin: 0 10px 0 20px;
    cursor: pointer;
  }

  .mid-icon {
    margin: 0 3px;
    vertical-align: top;
  }
}
</style>
