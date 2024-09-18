<script setup>
import {useRoute, useRouter} from "vue-router";
import {reactive, ref, watch} from "vue";
import {getUserAPI} from "@/api/user/index.js";

const route = useRoute()
const user = reactive({
  id: undefined,
  username: undefined,
  password: undefined,
  avatar: undefined,
  status: undefined,
  email: undefined,
  roles: undefined,
  createBy: undefined,
  createTime: undefined,
  updateBy: undefined,
  updateTime: undefined
})


async function getUser(id) {
  const res = await getUserAPI(id)
  if (res.code === 200) {
    Object.assign(user, res.data)
  }
}

watch(() => route.params.userId, () => {
  if (route.params.userId) {
    getUser(route.params.userId)
  }
}, {
  immediate: true
})
</script>

<template>

  <el-row>
    <el-col :span="10">
      <el-form label-width="100" :model="user" :rules="userRule" ref="userRef">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="user.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="头像">
          <el-avatar :src="user.avatar" disabled=""></el-avatar>
        </el-form-item>
        <el-form-item label="角色" prop="roles">
          <el-tag v-for="role in user.roles" :key="role.id">
            {{ role.name }}
          </el-tag>
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="user.email" disabled></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-switch :active-value="1" inactive-value="0" v-model="user.status"
                     disabled></el-switch>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="user.password" disabled></el-input>
        </el-form-item>
        <el-form-item label="创建时间">
          <el-input v-model="user.createTime" disabled></el-input>
        </el-form-item>
        <el-form-item label="更新时间">
          <el-input v-model="user.updateTime" disabled></el-input>
        </el-form-item>
      </el-form>
    </el-col>
  </el-row>


</template>

<style scoped lang="scss">

</style>
