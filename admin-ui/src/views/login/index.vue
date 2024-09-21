<script setup>
import {onMounted, reactive, ref} from "vue";
import {useUserStore} from "@/store/user.js";
import {ElNotification} from "element-plus";
import {useRoute, useRouter} from "vue-router";
import {getTimes} from '@/utils/time';
import {checkPassword, checkUserName} from "@/utils/validate.js";
import setting from '@/../setting'
import {getCaptChaAPI} from "@/api/captcha.js";

const userStore = useUserStore();
const router = useRouter();
const route = useRoute()
const loginForm = reactive({
  username: 'admin',
  password: '123456',
  key: '',
  captcha: ''
})
const loginComponent = ref(null)
const loading = ref(false)

const rules = reactive({
  username: [
    {validator: checkUserName, trigger: 'change'},
  ],
  password: [
    {validator: checkPassword, trigger: 'change'},
  ],
  captcha: [
    {required: true, message: '请输入验证码', trigger: 'change'},
  ]
})


async function login() {
  const box = loginComponent.value
  await box.validate()
  loading.value = true
  try {
    await userStore.login(loginForm)
    let redirect = route.query.redirect
    router.push({
      path: redirect || '/'
    })
    ElNotification({
      title: getTimes(),
      message: '登录成功',
      type: 'success'
    })
  } catch (e) {
    ElNotification({
      title: '登录失败',
      message: e.message,
      type: 'error'
    })
  } finally {
    loading.value = false
  }
}

const baseImg = ref('')

async function getCaptCha() {
  const res = await getCaptChaAPI()
  if (res.code === 200)
    loginForm.key = res.data.key
    baseImg.value = "data:image/png;base64," +res.data.img
}

onMounted(() => {
  getCaptCha()
})
</script>

<template>
  <div class="login-container">
    <el-row>
      <el-col :span="12" :xs="0"></el-col>
      <el-col :span="12" :xs="24">

        <el-form class="login-form" :model="loginForm" :rules="rules" ref="loginComponent" @keyup.enter="login">
          <h1>登录</h1>
          <h2>{{ setting.logoTitle }}</h2>
          <el-form-item prop="username">
            <el-input prefix-icon="user" class="input-height" type="text" placeholder="请输入用户名"
                      v-model="loginForm.username"></el-input>
          </el-form-item>
          <el-form-item prop="password">
            <el-input prefix-icon="lock" class="input-height" type="password" placeholder="请输入密码"
                      v-model="loginForm.password" show-password></el-input>
          </el-form-item>
          <el-row :gutter="50">

              <el-col :span="12">
                <el-form-item prop="captcha">
                <el-input class="input-width" prefix-icon="CircleCheck" placeholder="验证码" v-model="loginForm.captcha"></el-input>
                </el-form-item>
              </el-col>

              <el-col :span="12">
                <img :src="baseImg" @click="getCaptCha" style="cursor: pointer">
              </el-col>

          </el-row>
          <el-form-item>
            <el-button :loading="loading" class="login-btn input-box" type="primary" @click="login">登录
            </el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped lang="scss">

.login-container {
  width: 100%;
  height: 100vh;
  background: url("@/assets/images/background.jpg") no-repeat;
  background-size: cover;

  .login-form {
    position: relative;
    top: 30vh;
    width: 80%;
    background: url("@/assets/images/login_form.png") no-repeat;
    background-size: cover;
    padding: 40px;

    .login-btn {
      width: 100%;
    }
  }

  h1 {
    font-size: 40px;
    color: white;
  }

  h2 {
    font-size: 20px;
    color: white;
    margin: 20px 0;
  }
}

</style>
