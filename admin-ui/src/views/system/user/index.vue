<script setup>

import {onMounted, ref, reactive} from "vue";
import {deleteUserAPI, exportUserAPI, listUserAPI} from "@/api/system/user.js";
import {listRoleAPI} from "@/api/system/role.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {deleteNotification} from "@/utils/notification.js";
import {ElMessage} from "element-plus";
import {user$genderMap, user$statusMap} from "@/utils/dictMap.js";


const tableData = ref([])
const req = reactive({
  pageNum: 1,
  pageSize: 10,
  roleId: undefined,
  status: undefined
})
const total = ref(0)
const roleList = ref([])
const selections = ref([])

function handleSelectionChange(val) {
  selections.value = val

}

function delBatch() {
  let ids = selections.value.map((item) => item.id)
  del(ids)
}

function del(ids) {
  if (ids instanceof Array) {
    handleConfirmDel(async () => {
      const res = await deleteUserAPI(ids)
      deleteNotification(res, () => {
        getUserList()
      })
    })
  } else {
    ElMessage.error('请选择要删除的数据')
  }
}

async function delUser(row) {
  let ids = [row.id]
  del(ids)
}


function resetReq() {
  req.roleId = undefined
  req.status = undefined
  getUserList()
}

async function getUserList() {
  const res = await listUserAPI(req)
  if (res.code === 200) {
    tableData.value = res.data
    total.value = Number(res.total)
  }
}

async function getRoleList() {
  const res = await listRoleAPI()
  if (res.code === 200) {
    roleList.value = res.data
  }
}

function handleSizeChange(val) {
  req.pageNum = 1
  getUserList()
}

function handleCurrentChange(val) {
  getUserList()
}

async function exportUser() {
  const data = await exportUserAPI()
  //下载文件
  const url = URL.createObjectURL(data)
  const a = document.createElement('a')
  a.href = url
  a.download = '用户列表.xlsx'
  a.click()
  URL.revokeObjectURL(url)
  ElMessage.success('导出成功')
}

onMounted(() => {
  getUserList()
  getRoleList()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline @keyup.enter="getUserList">
        <el-form-item label="角色" class="input-width">
          <el-select v-model="req.roleId" placeholder="请选择">
            <el-option v-for="(item) in roleList" :key="item.id" :label="item.name" :value="item.id"/>
          </el-select>
        </el-form-item>
        <el-form-item label="状态" class="input-width">
          <el-select v-model="req.status" placeholder="请选择" clearable>
            <el-option v-for="(value,key) in user$statusMap" :label="value" :key="key" :value="key"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
    </div>
    <div class="operation-box">
      <el-button icon="Search" @click="getUserList">查询</el-button>
      <el-button type="info" icon="Refresh" @click="resetReq">重置</el-button>
      <el-button type="primary" icon="Plus" @click="$router.push('/system/user/add')">新增用户</el-button>
      <el-button type="danger" icon="Delete" @click="delBatch">批量删除</el-button>
      <el-button type="info" @click="exportUser">导出</el-button>

    </div>

    <el-table :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column type="index" label="序号" width="80"></el-table-column>
      <el-table-column prop="username" label="用户名"></el-table-column>
      <el-table-column prop="nickName" label="昵称"></el-table-column>
      <el-table-column prop="roles" label="角色">
        <template #default="{row}">
          <el-tag :type="item.createBy===row.username?'primary':'danger'" v-for="(item) in row.roles" :key="item.id"
                  class="t-box">{{ item.name }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="gender" label="性别">
        <template #default="{row}">
          {{ user$genderMap[row.gender] }}
        </template>
      </el-table-column>

      <el-table-column prop="createTime" label="创建时间"></el-table-column>

      <el-table-column label="操作">
        <template #default="{row}">
          <el-button type="text" icon="User" @click="$router.push(`/system/user/detail/${row.id}`)">详细</el-button>
          <el-button type="text" icon="Edit" @click="$router.push(`/system/user/edit/${row.id}`)">编辑</el-button>
          <el-button type="text" icon="Delete" @click="delUser(row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="pagination-box">
      <el-pagination
          v-model:current-page="req.pageNum"
          v-model:page-size="req.pageSize"
          :page-sizes="[10,20,50,100]"
          layout="prev, pager, next,jumper,->, sizes,total"
          :total="total"
          background
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
    </div>
  </div>
</template>

<style scoped lang="scss">
.content-box {
  padding: 15px;

  .operation-box {
    margin: 15px 0;
  }

  .t-box {
    margin: 0 3px;
  }
}
</style>
