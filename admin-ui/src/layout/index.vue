<script setup>
import AppMenu from './AppMenu/index.vue'
import {useUserStore} from "@/store/user.js";
import {useSettingStore} from "@/store/setting.js";
import {useRouter} from "vue-router";
import Logo from './logo/index.vue'
import TabBar from './tabBar/index.vue'
import Main from './main/index.vue'

const router = useRouter()

function goMenu(item) {
  router.push(item.index)
}

const userStore = useUserStore()
const settingStore = useSettingStore()
</script>

<template>
  <div class="layout-container">
    <div class="layout-aside" :class="{fold: settingStore.fold}">
      <div class="layout-aside-logo">
        <Logo></Logo>
      </div>
      <el-scrollbar class="scrollbar">
        <el-menu background-color="#001529" text-color="#fff" :default-active="$route.path"
                 :collapse="settingStore.fold" :collapse-transition="false">
          <el-menu-item index="/home" @click="goMenu">
            <el-icon>
              <HomeFilled/>
            </el-icon>
            <template #title>
              <span>首页</span>
            </template>
          </el-menu-item>
          <AppMenu :menus="userStore.menus"/>
        </el-menu>
      </el-scrollbar>
    </div>

    <div class="layout-header" :class="{fold: settingStore.fold}">
      <TabBar></TabBar>
    </div>
    <div class="layout-main" :class="{fold: settingStore.fold}">
      <Main></Main>
    </div>
  </div>
</template>

<style scoped lang="scss">
.layout-container {
  width: 100vw;
  height: 100vh;


  .layout-aside-logo {
    height: $base-menu-logo-height;
    width: $base-menu-width;
  }

  .layout-aside {
    position: fixed;
    width: $base-menu-width;
    height: 100vh;
    background: $base-menu-background;
    transition: all .3s;

    &.fold {
      width: $base-menu-min-width;
    }
  }


  .layout-header {
    position: fixed;
    top: 0;
    left: calc($base-menu-width);
    width: calc(100vw - $base-menu-width);
    height: $base-tabBar-height;
    transition: all .3s;

    &.fold {
      left: $base-menu-min-width;
      width: calc(100vw - $base-menu-min-width);
    }
  }

  .layout-main {
    padding: 10px;
    position: absolute;
    top: $base-tabBar-height;
    left: $base-menu-width;
    width: calc(100vw - $base-menu-width);
    height: calc(100vh - $base-tabBar-height);
    transition: all .3s;
    overflow-x: hidden;

    &.fold {
      left: $base-menu-min-width;
      width: calc(100vw - $base-menu-min-width);
    }
  }
}

.scrollbar {
  height: calc(100vh - $base-tabBar-height);
  width: 100%;
}
</style>
