<script setup>
import {onMounted, reactive, ref, watch} from "vue";
import {checkArray, checkEmail, checkPassword, checkPhone, checkUserName} from "@/utils/validate.js";
import {listRoleAPI} from "@/api/system/role.js";
import {updateNotification} from "@/utils/notification.js";
import {editUserAPI, getUserAPI,} from "@/api/system/user.js";
import {useRoute, useRouter} from "vue-router";
import {user$genderMap} from "@/utils/dictMap.js";


const router=useRouter()
const route=useRoute()
const user = reactive({
  id: undefined,
  username: undefined,
  password: undefined,
  avatar: "/minio/app/4823f861852d17ec03b15fa165416b36.avif",
  status: 1,
  email: undefined,
  roles: [],
  createBy: undefined,
  createTime: undefined,
  updateBy: undefined,
  phone: undefined,
  gender: undefined,
  nickName:undefined,
  updateTime: undefined
})

function resetForm() {
  Object.keys(user).forEach(key => {
    user[key] = undefined
    user.roles = []
  })
}

const userRef = ref(null)
const userRule = reactive({
  username: [
    {validator: checkUserName, trigger: 'change'}
  ],
  email: [
    {validator: checkEmail, trigger: 'change'}
  ],
  roles: [
    {validator: checkArray, trigger: 'change'}
  ],
  phone: [
    {validator: checkPhone, trigger: 'change'}
  ]
})

const roleList = ref([])

async function getRoleList() {
  const res = await listRoleAPI()
  if (res.code === 200) {
    roleList.value = res.data
  }

}

async function submit() {
  await userRef.value.validate()
  user.roles = user.roles.map(item => {
    return {
      id: item
    }
  })
  const res = await editUserAPI(user)
  updateNotification(res, () => {
    router.replace("/system/user")
  })
}


async function getUser(id) {
  const res = await getUserAPI(id)
  if (res.code === 200) {
    Object.assign(user, res.data)
    user.roles=res.data.roles.map(item => item.id)
  }
}

watch(() => route.params.userId, () => {
  if (route.params.userId) {
    getUser(route.params.userId)
  }
}, {
  immediate: true
})
onMounted(() => {
  getRoleList()
})
</script>

<template>
  <el-col :span="10">
    <el-form label-width="100" :model="user" :rules="userRule" ref="userRef" @keyup.enter="submit">
      <el-form-item label="用户名" prop="username" required>
        <el-input v-model="user.username" disabled></el-input>
      </el-form-item>
      <el-form-item label="头像">
        <el-avatar :src="user.avatar"></el-avatar>
      </el-form-item>
      <el-form-item label="角色" prop="roles" required>
        <el-select v-model="user.roles" multiple placeholder="Select" style="width: 240px"
        >
          <el-option
              v-for="item in roleList"
              :key="item.id"
              :label="item.name"
              :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="邮箱">
        <el-input v-model="user.email"></el-input>
      </el-form-item>
      <el-form-item label="状态" required>
        <el-switch :active-value="1" inactive-value="0" v-model="user.status"
        ></el-switch>
      </el-form-item>
      <el-form-item label="性别" prop="gender" required>
        <el-radio-group v-model="user.gender">
          <el-radio v-for="(value,key) in user$genderMap" :key="key" :value="Number(key)" >{{value}}</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="昵称" prop="nickName" required>
        <el-input v-model="user.nickName"></el-input>
      </el-form-item>
      <el-form-item label="手机号码" prop="phone" required>
        <el-input v-model="user.phone"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password" >
        <el-input type="password" v-model="user.password" show-password></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submit">提交</el-button>
      </el-form-item>
    </el-form>
  </el-col>
</template>

<style scoped lang="scss">

</style>
