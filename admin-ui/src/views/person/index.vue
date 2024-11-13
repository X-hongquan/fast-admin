<script setup>

import {onMounted, reactive, ref} from "vue";
import {useUserStore} from "@/store/user.js";
import {Calendar, Message, Phone, User, UserFilled} from "@element-plus/icons-vue";
import {user$genderMap} from "@/utils/dictMap.js";
import {
  changeAvatarUserAPI,
  changePasswordUserAPI,
  editUserAPI,
  resetPasswordUserAPI,
  sendPasswordCodeUserAPI
} from "@/api/system/user.js";
import {useRouter} from "vue-router";
import {ElMessage} from "element-plus";
import {updateNotification} from "@/utils/notification.js";
import {checkPassword} from "@/utils/validate.js";


const userStore = useUserStore()

const router = useRouter()
const userDetail = reactive({
  nickName: undefined,
  phone: undefined,
  email: undefined,
  gender: undefined,
})
const passwordForm = reactive({
  oldPassword: undefined,
  newPassword: undefined,
  confirmPassword: undefined,
  code: undefined
})

function copy() {
  userDetail.id = userStore.userInfo.user.id
  userDetail.email = userStore.userInfo.user.email
  userDetail.phone = userStore.userInfo.user.phone
  userDetail.gender = userStore.userInfo.user.gender
  userDetail.nickName = userStore.userInfo.user.nickName
}

async function submit() {
  ElMessage.warning("修改信息联系管理员")
}

const PwdFormRef = ref(null)
const pwdFormRules = reactive({
  oldPassword: [
    {validator: checkPassword, trigger: 'change'},
  ],
  newPassword: [
    {validator: checkPassword, trigger: 'change'},
  ],
  confirmPassword: [
    {validator: checkPassword, trigger: 'change'},
  ]
})

async function changePassword() {
  await PwdFormRef.value.validate()
  const res = await changePasswordUserAPI(passwordForm)
  updateNotification(
      res,
      async () => {
        await userStore.logout()
        router.replace("/login")
        ElMessage.success("修改成功,请重新登录")
      }
  )
}

async function sendCode() {
  const res = await sendPasswordCodeUserAPI()
  if (res.code === 200) {
    ElMessage.success("验证码发送成功,请查看邮箱")
  } else {
    ElMessage.error(res.msg)
  }
}

async function resetPassword() {
  await PwdFormRef.value.validate()
  const res = await resetPasswordUserAPI(passwordForm)
  updateNotification(
      res,
      async () => {
        ElMessage.success("重置成功,请重新登录")
        await userStore.logout()
        router.replace("/login")
      }
  )
}


function closeSetting() {
  router.push('/')
}

const avatarDialog = ref(false)
const activeName = ref('first')



function beforeAvatarUpload(file) {
  console.log(file.type)
  const isJPG = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/gif' || file.type === 'image/avif'
  const isLt2M = file.size / 1024 / 1024 < 2
  if (!isJPG) {
    ElMessage.error('上传头像图片只能是 JPG 格式!')
  }
  if (!isLt2M) {
    ElMessage.error('上传头像图片大小不能超过 2MB!')
  }
}

const imageUrl = ref('')

async function handleUploadAvatar(files) {
  const formData = new FormData();
  formData.append('file', files.file)
  const res=await changeAvatarUserAPI(formData)
  if (res.code===200) {
    ElMessage.success("修改成功")
    await userStore.getUserInfo()
    imageUrl.value=userStore.userInfo.user.avatar
  } else {
    ElMessage.error(res.msg)
  }
}

onMounted(() => {
  copy()
})
</script>

<template>
  <el-dialog title="修改头像" v-model="avatarDialog" width="30%">
    <el-upload
        class="avatar-uploader"
        action="void"
        :http-request="handleUploadAvatar"
        accept="image/*"
        :show-file-list="false"
        :before-upload="beforeAvatarUpload"
    >
      <img v-if="imageUrl" :src="imageUrl" class="avatar"/>
      <el-icon v-else class="avatar-uploader-icon">
        <Plus/>
      </el-icon>
    </el-upload>
    <template footer>
      <span slot="footer" class="dialog-footer">
        <el-button @click="avatarDialog=false">取 消</el-button>
        <el-button type="primary" @click="avatarDialog=false">确 定</el-button>
      </span>
    </template>
  </el-dialog>
  <el-row :gutter="20">
    <el-col :span="7">
      <el-card class="private-box">
        <template #header>
          <div class="card-header">
            <span>个人信息</span>
          </div>
        </template>
        <ul>
          <div class="avatar-box">
            <el-avatar :src="userStore.userInfo.user.avatar" :size="110" style="cursor: pointer"
                       @click="avatarDialog=true"/>
          </div>
          <el-divider class="split-box"/>
          <li>
               <span class="title">
                 <el-icon>
                   <UserFilled/>
                 </el-icon>
                 用户名
               </span>
            <span class="content">{{ userStore.userInfo.user.username }}</span>
          </li>
          <el-divider class="split-box"/>
          <li>
               <span class="title">
                 <el-icon>
                   <Phone/>
                 </el-icon>
                 手机号码
               </span>
            <span class="content">{{ userStore.userInfo.user.phone }}</span>
          </li>
          <el-divider class="split-box"/>
          <li>
               <span class="title">
                 <el-icon>
                   <Message/>
                 </el-icon>
                 邮箱
               </span>
            <span class="content">{{ userStore.userInfo.user.email }}</span>
          </li>
          <el-divider class="split-box"/>
          <li>
               <span class="title">
                 <el-icon>
                   <User/>
                 </el-icon>
                 所属角色
               </span>
            <span>
                 <span v-for="item in userStore.userInfo.roles">{{ item.name }}</span>
               </span>
          </li>
          <el-divider class="split-box"/>
          <li>
              <span class="title">
                 <el-icon>
                   <Calendar/>
                 </el-icon>
                 创建日期
               </span>
            <span>
                 {{ userStore.userInfo.user.createTime }}
               </span>
          </li>
        </ul>

      </el-card>
    </el-col>
    <el-col :span="17">
      <el-card>
        <template #header>
          <div class="card-header">
            <span>基本资料</span>
          </div>
        </template>
        <el-tabs v-model="activeName" class="demo-tabs">
          <el-tab-pane label="基本资料" name="first">
            <el-form label-width="80" :model="userDetail">
              <el-form-item label="用户姓名" prop="nickName" required>
                <el-input v-model="userDetail.nickName" placeholder="请输入用户名"/>
              </el-form-item>
              <el-form-item label="手机号码" prop="phone" required>
                <el-input v-model="userDetail.phone" placeholder/>
              </el-form-item>
              <el-form-item label="邮箱" prop="email" required>
                <el-input v-model="userDetail.email" placeholder/>
              </el-form-item>
              <el-form-item label="性别" prop="gender" required>
                <el-radio-group v-model="userDetail.gender">
                  <el-radio v-for="(value,key) in user$genderMap" :key="key" :value="Number(key)" :label="value"/>
                </el-radio-group>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="submit">保存</el-button>
                <el-button type="danger" @click="closeSetting">关闭</el-button>
              </el-form-item>
            </el-form>
          </el-tab-pane>
          <el-tab-pane label="修改密码" name="second">
            <el-form label-width="80" :model="passwordForm" ref="PwdFormRef" :rules="pwdFormRules">
              <el-form-item label="旧密码" prop="oldPassword" required>
                <el-input type="password" show-password v-model="passwordForm.oldPassword" placeholder="请输入旧密码"/>
              </el-form-item>
              <el-form-item label="新密码" prop="newPassword" required>
                <el-input type="password" show-password v-model="passwordForm.newPassword" placeholder="请输入新密码"/>
              </el-form-item>
              <el-form-item label="确认密码" prop="confirmPassword" required>
                <el-input type="password" show-password v-model="passwordForm.confirmPassword"
                          placeholder="请输入新密码"/>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="changePassword">保存</el-button>
                <el-button type="danger" @click="closeSetting">关闭</el-button>
              </el-form-item>
            </el-form>
          </el-tab-pane>

          <el-tab-pane label="重置密码" name="three">
            <el-form label-width="80" :model="passwordForm" ref="PwdFormRef" :rules="pwdFormRules">

              <el-form-item label="新密码" prop="newPassword" required>
                <el-input type="password" show-password v-model="passwordForm.newPassword" placeholder="请输入新密码"/>
              </el-form-item>
              <el-form-item label="确认密码" prop="confirmPassword" required>
                <el-input type="password" show-password v-model="passwordForm.confirmPassword"
                          placeholder="请输入新密码"/>
              </el-form-item>
              <el-form-item label="验证码" prop="code" required>
                <el-input type="text" show-password v-model="passwordForm.code" class="input-width"
                          placeholder="验证码"/>
                <el-button type="success" @click="sendCode">发送验证码</el-button>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="resetPassword">保存</el-button>
                <el-button type="danger" @click="closeSetting">关闭</el-button>
              </el-form-item>
            </el-form>
          </el-tab-pane>
        </el-tabs>
      </el-card>
    </el-col>
  </el-row>

</template>

<style scoped lang="scss">
.private-box {
  .avatar-box {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 130px;
  }

  li {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .split-box {
    margin: 12px 0;
  }
}

.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  text-align: center;
}

.avatar-uploader .avatar {
  width: 178px;
  height: 178px;
  display: block;
}

</style>
