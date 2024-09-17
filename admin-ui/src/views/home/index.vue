<script setup>
import {getTimes} from '@/utils/time';
import {useUserStore} from '@/store/user';
import setting from '/setting.js'
import SvgIcon from '@/components/SvgIcon/index.vue'
import {onMounted, ref} from 'vue'

const userStore = useUserStore();
const wsUrl = ref(`ws://localhost:8080/api/ws?token=`)
const editMode = ref(false)

function createSocket() {
  const socket = new WebSocket(wsUrl.value + userStore.token)
  socket.onopen = function (event) {
    console.log('连接初始化')
  }
  socket.onmessage = function (event) {
    console.log(event.data)
  }
  socket.onclose = function (event) {
    console.log('连接关闭')
    if (socket.CLOSED)
      setTimeout(createSocket, 5000)
  }
  socket.onerror = function (event) {
    console.log('连接错误')
  }
}

onMounted(() => {
  createSocket()
})
</script>


<template>
  <el-card>
    <div class="box">
      <img :src="userStore.userInfo.user.avatar" alt="" class="avatar">
      <div class="bottom">
        <h3 class="title">{{ getTimes() }},{{ userStore.userInfo.user.username }}</h3>
        <p class="subtitle">{{ setting.logoTitle }}</p>
        <el-link type="primary" href="https://chqwz.top/" target="_blank" style="font-size: 20px">项目地址</el-link>
        <p style="height: 20px"></p>
        <el-link type="primary" href="http://114.132.249.233/" target="_blank" style="font-size: 20px">文档地址
        </el-link>
      </div>
    </div>
    <div class="socket-box">
      <h3>Socket连接配置</h3>
      <el-input type="text" style="width: 400px" placeholder="请输入连接地址" v-model="wsUrl"
                :disabled="!editMode"></el-input>
      <el-button type="primary" @click="editMode=!editMode">{{ editMode ? '取消编辑' : '编辑' }}</el-button>
    </div>
  </el-card>
  <div class="bottoms">
    <SvgIcon name="welcome" width="600px" height="300px"></SvgIcon>
  </div>

</template>


<style scoped lang="scss">
.box {
  display: flex;

  .avatar {
    width: 100px;
    height: 100px;
    border-radius: 50%;
  }

  .bottom {
    margin-left: 20px;

    .title {
      font-size: 30px;
      font-weight: 900;
      margin-bottom: 30px;
    }

    .subtitle {
      font-style: italic;
      color: skyblue;
    }
  }
}

.bottoms {
  margin-top: 10px;
  display: flex;
  justify-content: center;
}

.socket-box {
  margin-top: 50px;
}
</style>
