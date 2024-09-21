<script setup>
import {useSettingStore} from "@/store/setting.js";
import {useUserStore} from "@/store/user.js";
import {ElNotification} from "element-plus";
import {useRoute, useRouter} from "vue-router";
import {onMounted, ref} from "vue";

const userStore = useUserStore()
const settingStore = useSettingStore()
const router = useRouter()
const route = useRoute()

async function logout() {
  await userStore.logout()
  router.push({path: '/login', query: {redirect: route.path}})
  ElNotification({
    type: 'success',
    title: '提示',
    message: '退出成功',
  })
}

function goPerson() {
  router.push({path: '/person'})
}

function fullScreen() {
  let full = document.fullscreenElement;
  if (!full) {
    document.documentElement.requestFullscreen()
  } else {
    document.exitFullscreen()
  }
}

function changeMode() {
  document.documentElement.className = settingStore.theme ? 'dark' : ''
}

function changeColor() {
  document.documentElement.style.setProperty('--el-color-primary', color.value)
}

const color = ref()

async function getSetting() {
  try {
    await settingStore.getSetting()
  } catch (e) {
    ElNotification({
      type: 'error',
      title: '提示',
      message: '获取设置失败',
    })
  }
}
async function updateSetting() {
  try {
  await settingStore.updateSetting()
  } catch (e) {
    ElNotification({
      type: 'error',
      title: '提示',
      message: '更新设置失败',
    })
  }
}

onMounted(() => {
  getSetting()
})
</script>

<template>
  <div class="top-right">
    <a href="http://114.132.249.233/" target="_blank" title="文档" class="github"><SvgIcon name="document" height="25px" width="25px"></SvgIcon></a>
    <a href="https://github.com/X-hongquan/fast-admin" target="_blank" title="Github" class="github"><SvgIcon name="github" height="25px" width="25px"></SvgIcon></a>
    <el-button icon="Refresh" circle @click="settingStore.refresh=!settingStore.refresh"/>
    <el-button icon="FullScreen" circle @click="fullScreen"/>
    <el-popover
        placement="bottom"
        title="设置"
        :width="300"
        trigger="hover"
    >
      <template #default>
        <el-form label-width="80px">
          <el-form-item label="主题色">
            <el-color-picker v-model="color" @change="changeColor" show-alpha :teleported="false"/>
          </el-form-item>
          <el-form-item label="暗黑模式">
            <el-switch v-model="settingStore.theme" active-icon="Moon" inactive-icon="Sunny" @change="changeMode"/>
          </el-form-item>
          <el-form-item label="权限模式">
            <el-switch v-model="settingStore.setting.permissionMode" :active-value="1" :inactive-value="0"
                       active-text="资本主义"  inactive-text="社会主义"  style="--el-switch-on-color: #13ce66; --el-switch-off-color: #ff4949"
                       @change="updateSetting"
            >
            </el-switch>
          </el-form-item>

        </el-form>
      </template>
      <template #reference>
        <el-button icon="Setting" circle/>
      </template>
    </el-popover>


    <img :src="userStore.userInfo.user.avatar" alt="头像">
    <el-dropdown>
    <span>
      {{ userStore.userInfo.user.username }}
      <el-icon>
        <arrow-down/>
      </el-icon>
    </span>
      <template #dropdown>
        <el-dropdown-menu>
          <el-dropdown-item @click="goPerson">个人中心</el-dropdown-item>
          <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>
  </div>
</template>

<style scoped lang="scss">
.top-right {
  height: 100%;
  display: flex;
  align-items: center;
 .github {
   margin-right: 15px;
 }

  img {
    margin-left: 10px;
    margin-right: 10px;
    height: 40px;
    width: 40px;
    border-radius: 50%;
  }
}
</style>
