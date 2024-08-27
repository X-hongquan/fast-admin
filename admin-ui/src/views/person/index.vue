<script setup>
import {useUserStore} from "@/store/user.js";
import {ref, reactive} from "vue";
import {
  changeAvatarAPI,
  changePasswordAPI,
  resetEmailAPI, resetPasswordAPI,
  sendEmailCodeAPI,
  sendPwdCodeAPI
} from "@/api/user/index.js";
import {ElMessage, ElNotification} from "element-plus";
import {checkEmail} from "@/utils/validate.js";
import {useRouter} from "vue-router";

const store = useUserStore()
const changePwdRef = ref(null)
const resetPwdRef = ref(null)
const resetEmailRef = ref(null)
const uploadAvatarBox = ref(false)

//表单对象
const box = reactive({
  show: false,
  title: '',
  email: false,
  pwdChange: false,
  pwdReset: false
})
const changePwdForm = reactive({
  oldPassword: '',
  newPassword: '',
  confirmPassword: '',
})
const resetPwdForm = reactive({
  newPassword: '',
  confirmPassword: '',
  code: '',
})

const resetEmailForm = reactive({
  newEmail: '',
  code: ''
})

//处理函数
function changePwdHandler() {

  box.title = '修改密码'
  box.show = true
  box.pwdChange = true
  box.email = false
  box.pwdReset = false
}

function resetPwdHandler() {
  box.title = '重置密码'
  box.show = true
  box.pwdReset = true
  box.pwdChange = false
  box.email = false
}

function resetEmailHandler() {
  box.title = '重置邮箱'
  box.show = true
  box.email = true
  box.pwdChange = false
  box.pwdReset = false
}

function changeAvatarHandler() {
  uploadAvatarBox.value = true
}

function checkPwd(rule, value, callback) {
  if (value.length < 6 || value.length > 30) {
    callback(new Error('密码长度不能小于6或者大于30'))
  } else {
    callback()
  }
}

function checkRestPwd(rule, value, callback) {
  if (value.length < 6 || value.length > 30) {
    callback(new Error('密码长度不能小于6或者大于30'))
  }
  if (value !== resetPwdForm.newPassword) {
    callback(new Error('两次密码不一致'))
  } else {
    callback()
  }
}

function confirmPwd(rule, value, callback) {
  if (changePwdForm.newPassword !== changePwdForm.confirmPassword) {
    callback(new Error('两次密码不一致'))
  } else {
    callback()
  }
}

function confirmResetPassword(rule, value, callback) {
  if (resetPwdForm.newPassword !== resetPwdForm.confirmPassword) {
    callback(new Error('两次密码不一致'))
  } else {
    callback()
  }
}


//
const changePwdRule = reactive({
  oldPassword: [
    {trigger: 'blur', validator: checkPwd},
  ],
  newPassword: [
    {validator: checkPwd, trigger: 'blur'}
  ],
  confirmPassword: [
    {validator: confirmPwd, trigger: 'blur'}
  ]
})

const resetPwdRule = reactive({
  newPassword: [
    {validator: checkRestPwd, trigger: 'blur'}
  ],
  confirmPassword: [
    {validator: confirmResetPassword, trigger: 'blur'}
  ],
  code: [
    {required: true, message: '验证码不能为空', trigger: 'blur'}
  ]
})

const resetEmailRule = reactive({
  newEmail: [
    {validator: checkEmail, trigger: 'blur'}
  ],
  code: [
    {required: true, message: '验证码不能为空', trigger: 'blur'}
  ]
})

//请求函数
async function changePassword() {
  const c = changePwdRef.value;
  await c.validate()
  const res = await changePasswordAPI(changePwdForm)
  if (res.code === 200) {
    ElNotification({
      title: '修改成功',
      message: '密码修改成功',
      type: 'success'
    })
    Object.keys(changePwdForm).forEach((key) => {
      changePwdForm[key] = ''
    })
    box.show = false
  } else {
    ElNotification({
      title: '修改失败',
      message: res.msg,
    })
  }
}

async function resetPassword() {
  const c = resetPwdRef.value;
  await c.validate()
  const res = await resetPasswordAPI(resetPwdForm);
  if (res.code === 200) {
    ElNotification({
      title: '重置成功',
      message: '密码重置成功',
      type: 'success'
    })
    Object.keys(resetPwdForm).forEach((key) => {
      resetPwdForm[key] = ''
    })
    box.show = false
  } else {
    ElNotification({
      title: '重置失败',
      message: res.msg,
      type: 'error'
    })
  }
}

async function resetEmail() {
  const c = resetEmailRef.value;
  await c.validate()
  const res = await resetEmailAPI(resetEmailForm);
  if (res.code === 200) {
    ElNotification({
      title: '重置成功',
      message: '邮箱重置成功',
      type: 'success'
    })
    Object.keys(resetEmailForm).forEach((key) => {
      resetEmailForm[key] = ''
    })
    await store.getUserInfo()
    box.show = false
  } else {
    ElNotification({
      title: '重置失败',
      message: res.msg,
      type: 'error'
    })
  }
}

async function getPwdCode() {
  const res = await sendPwdCodeAPI()
  if (res.code === 200) {
    ElNotification({
      title: '发送成功',
      message: '验证码已发送至邮箱',
      type: 'success'
    })
  } else {
    ElNotification({
      title: '发送失败',
      message: res.msg,
      type: 'error'
    })
  }
}

async function getEmailCode() {
  const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
  if (!regex.test(resetEmailForm.newEmail)) {
    ElNotification({
      title: '邮箱格式不正确',
      message: '请输入正确的邮箱格式',
      type: 'error'
    })
    return
  }
  const res = await sendEmailCodeAPI(resetEmailForm.newEmail)
  if (res.code === 200) {
    ElNotification({
      title: '发送成功',
      message: '验证码已发送至邮箱',
      type: 'success'
    })
  } else {
    ElNotification({
      title: '发送失败',
      message: res.msg,
      type: 'error'
    })
  }
}

async function changeAvatar(file) {
  const formData = new FormData();
  formData.append('file', file.file);
  console.log(file)
  const res = await changeAvatarAPI(formData);
  if (res.code === 200) {
    ElMessage({
      message: '头像修改成功',
      type: 'success'
    })
    await store.getUserInfo()
    uploadAvatarBox.value = false
  } else {
    ElMessage({
      message: '头像修改失败',
      type: 'error'
    })
  }

}

function beforeUpload(file) {

}

const router = useRouter()

async function handleLogout() {
  try {
    await store.logout()
    router.push('/login')
  } catch (e) {

  }
}
</script>

<template>
  <div class="dw">
    <el-card class="card">
      <template #header>
        <div class="card-header">
          <div>个人中心</div>
        </div>
      </template>
      <div>
        <el-form label-width="80px">
          <el-form-item label="用户名">
            <el-input v-model="store.userInfo.user.username" disabled/>
          </el-form-item>
          <el-row :gutter="20">
            <el-col :span="16">
              <el-form-item label="密码">
                <el-input disabled/>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-button type="text" @click="changePwdHandler">修改密码</el-button>
              <el-button type="text" @click="resetPwdHandler">忘记密码</el-button>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="16">
              <el-form-item label="邮箱">
                <el-input v-model="store.userInfo.user.email" disabled/>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-button type="text" @click="resetEmailHandler">修改邮箱</el-button>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="16">
              <el-form-item label="头像">
                <el-image :src="store.userInfo.user.avatar" :preview-src-list="[store.userInfo.user.avatar]"
                          class="avatar"></el-image>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-button type="text" @click="changeAvatarHandler">修改头像</el-button>
            </el-col>
          </el-row>
          <el-form-item label="角色">
            <el-tag v-for="(item,index) in store.userInfo.roles" :key="index">{{ item.name }}</el-tag>
          </el-form-item>
          <el-form-item label="权限">
            <el-tag v-for="(item,index) in store.userInfo.permissions" :key="index">{{ item }}</el-tag>
          </el-form-item>

          <el-form-item>
            <el-button type="primary" @click="handleLogout">退出</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-card>

    <el-card class="two-card" :class="{two:!box.show}">
      <template #header>
        <div class="card-header">
          <span>{{ box.title }}</span>
          <el-icon size="30" color="red" style="cursor: pointer" @click="box.show=false">
            <Close/>
          </el-icon>
        </div>
      </template>
      <el-form label-width="80px" :model="changePwdForm" :rules="changePwdRule" v-show="box.pwdChange"
               ref="changePwdRef">
        <el-form-item label="旧密码" prop="oldPassword">
          <el-input type="password" v-model="changePwdForm.oldPassword" show-password/>
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input type="password" v-model="changePwdForm.newPassword" show-password/>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input type="password" v-model="changePwdForm.confirmPassword" show-password/>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="changePassword">确认修改</el-button>
        </el-form-item>
      </el-form>

      <el-form label-width="80px" v-show="box.pwdReset" :model="resetPwdForm" :rules="resetPwdRule" ref="resetPwdRef">
        <el-form-item label="新密码" prop="newPassword">
          <el-input type="password" v-model="resetPwdForm.newPassword" show-password/>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input type="password" v-model="resetPwdForm.confirmPassword" show-password/>
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="16">
            <el-form-item label="验证码" prop="code">
              <el-input type="text" v-model="resetPwdForm.code" placeholder="请输入验证码"/>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-button type="text" @click="getPwdCode">获取验证码</el-button>
          </el-col>
        </el-row>
        <el-form-item>
          <el-button type="primary" @click="resetPassword">确认重置</el-button>
        </el-form-item>
      </el-form>

      <el-form label-width="80px" :model="resetEmailForm" :rules="resetEmailRule" v-show="box.email"
               ref="resetEmailRef">
        <el-form-item label="新邮箱" prop="newEmail">
          <el-input type="text" v-model="resetEmailForm.newEmail" placeholder="请输入新邮箱"/>
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="16">
            <el-form-item label="验证码" prop="code">
              <el-input type="text" v-model="resetEmailForm.code" placeholder="请输入验证码"/>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-button type="text" @click="getEmailCode">获取验证码</el-button>
          </el-col>
        </el-row>
        <el-form-item>
          <el-button type="primary" @click="resetEmail">确认重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <el-dialog v-model="uploadAvatarBox" title="上传头像" width="500">
      <el-upload
          class="upload-demo"
          drag
          :http-request="changeAvatar"
          action="#"
          :before-upload="beforeUpload"
      >
        <el-icon class="el-icon--upload">
          <upload-filled/>
        </el-icon>
        <div class="el-upload__text">
          Drop file here or <em>click to upload</em>
        </div>
        <template #tip>
          <div class="el-upload__tip">
            jpg/png files with a size less than 500kb
          </div>
        </template>
      </el-upload>
    </el-dialog>
  </div>


</template>

<style scoped lang="scss">


.dw {
  display: flex;
  width: 100%;
  gap: 50px;
  height: 100%;
  justify-content: center;

  .card {
    width: 500px;

    .avatar {
      cursor: pointer;
      width: 60px;
      height: 60px;
      border-radius: 50%;
    }
  }

  .two-card {
    width: 400px;
    transition: all .3s linear;

    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;


    }

    &.two {
      width: 0;
      border: 0;
    }
  }
}
</style>
