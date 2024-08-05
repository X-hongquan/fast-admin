<script setup>
import {reactive, watch, ref, onMounted} from "vue";
import {useRouter, useRoute} from "vue-router";
import {addUserAPI, getUserAPI, updateUserAPI} from "@/api/user/index.js";
import {getRoleListAPI} from "@/api/role/index.js";
import {checkArray, checkPassword, checkUserName} from "@/utils/validate.js";
import {addNotification, updateNotification} from "@/utils/notification.js";

const route = useRoute()
const router = useRouter()
const mode = ref('');
const user = reactive({
  username: '',
  avatar: '',
  roles: [],
  email: '',
  password: '',
  status: 1,
  createTime: '',
  updateTime: '',
})
const roleList = ref([])
const userRef = ref(null)
const userRule = reactive({
  username: [
    {validator: checkUserName, trigger: 'change'}
  ],
  password: [
    {validator: checkPassword, trigger: 'change'}
  ],
  roles: [
    {validator: checkArray, trigger: 'change'}
  ]
})


function convertForm() {
  let obj = {
    id: user.id || undefined,
    username: user.username,
    roles: user.roles.map(item => {
      return {
        id: item
      }
    }),
    email: user.email || undefined,
    password: user.password || undefined,
    status: user.status || undefined
  }
  console.log(obj)
  return obj
}

async function getUser(id) {
  const res = await getUserAPI(id)
  if (res.code === 200) {
    Object.assign(user, res.data)
    let arr = []
    for (const o of user.roles) {
      arr.push(o.id)
    }
    user.roles = arr
  }
}

async function getRoleList() {
  const res = await getRoleListAPI()
  if (res.code === 200) {
    roleList.value = res.data
  }
}

async function submit() {
  if (mode.value === 'add') {
    await userRef.value.validate()
    const res = await addUserAPI(convertForm())
    addNotification(res, () => {
      router.push({name: 'user'})
    })
  } else if (mode.value === 'edit') {
    const res = await updateUserAPI(convertForm())
    updateNotification(res, () => {
      router.push({name: 'user'})
    })
  }
}

watch(() => route.name, () => {
  mode.value = route.name.split('-')[1]
  if (route.params.userId) {
    let id = route.params.userId
    getUser(id)
  }
}, {
  immediate: true
})
onMounted(() => {
  getRoleList()
})
</script>

<template>

  <el-row>
    <el-col :span="10">
      <el-form label-width="100" :model="user" :rules="userRule" ref="userRef">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="user.username" :disabled="mode==='detail'"></el-input>
        </el-form-item>
        <el-form-item label="头像">
          <el-avatar :src="user.avatar" :disabled="mode==='detail'"></el-avatar>
        </el-form-item>
        <el-form-item label="角色" prop="roles">
          <el-select v-model="user.roles" multiple placeholder="Select" style="width: 240px"
                     :disabled="mode==='detail'">
            <el-option
                v-for="item in roleList"
                :key="item.id"
                :label="item.name"
                :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="user.email" :disabled="mode==='detail'"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-switch :active-value="1" inactive-value="0" v-model="user.status"
                     :disabled="mode==='detail'"></el-switch>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="user.password" :disabled="mode==='detail'" show-password></el-input>
        </el-form-item>
        <el-form-item label="创建时间">
          <el-input v-model="user.createTime" disabled></el-input>
        </el-form-item>
        <el-form-item label="更新时间">
          <el-input v-model="user.updateTime" disabled></el-input>
        </el-form-item>
        <el-form-item v-if="mode==='add'||mode==='edit'">
          <el-button type="primary" @click="submit">提交</el-button>
        </el-form-item>
      </el-form>
    </el-col>
  </el-row>


</template>

<style scoped lang="scss">

</style>
