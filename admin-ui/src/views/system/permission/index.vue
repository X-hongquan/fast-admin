<script setup>
import {ref, reactive, onMounted} from "vue";
import {
  listPermissionAPI,
  deletePermissionAPI,
  getPermissionAPI,
  editPermissionAPI,
  addPermissionAPI
} from "@/api/permission.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification, updateNotification} from "@/utils/notification.js";
import {ElMessage} from "element-plus";

const tableData = ref([])
const req = reactive({
  pageNum: 1,
  pageSize: 10,
  code: undefined,
  roleId: undefined,
  status: undefined
})
const mode = ref(false)
const title = ref('')

const permission = reactive({
  id: undefined,
  code: undefined,
  description: undefined,
})

const total = ref(0)
const selections = ref([])

async function handleSelectionChange(val) {
  selections.value = val
}

const formRules = reactive({
  code: [
    {required: true, message: '请输入权限值', trigger: 'blur'},
  ],
  description: [
    {required: true, message: '请输入权限描述', trigger: 'blur'},
  ],
})

async function getPermissionList() {
  const res = await listPermissionAPI(req)
  if (res.code === 200) {
    tableData.value = res.data
    total.value = Number(res.total)
  }
}

function del(ids) {
  handleConfirmDel(async () => {
    const res = await deletePermissionAPI(ids)
    deleteNotification(res, () => {
      getPermissionList()
    })
  })
}


const formRef = ref(null)

function deleteOne(row) {
  del([row.id])
}

function deleteBatch() {
  if (selections.value.length > 0) {
    del(selections.value.map((item) => item.id))
  } else {
    ElMessage.error('请选择要删除的数据')
  }
}

function handleSizeChange(val) {
  req.pageNum = 1
  getPermissionList()
}

function handleCurrentChange(val) {
  getPermissionList()
}

function resetForm() {
  Object.keys(permission).forEach((key) => permission[key] = undefined)
}

function handleAdd() {
  resetForm()
  mode.value = true
  title.value = '新增权限'
}

async function handleUpdate(row) {
  resetForm()
  mode.value = true
  title.value = '编辑权限'
  const res = await getPermissionAPI(row.id)
  Object.assign(permission, res.data)

}

async function submit() {
  await formRef.value.validate()
  if (permission.id) {
    const res = await editPermissionAPI(permission)
    updateNotification(res, () => {
      getPermissionList()
      mode.value = false
    })
  } else {
    const res = await addPermissionAPI(permission)
    addNotification(res, () => {
      getPermissionList()
      mode.value = false
    })
  }
}

onMounted(() => {
  getPermissionList()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-input v-model="req.code" placeholder="权限名" class="input-width" clearable></el-input>
      <el-button type="primary" icon="Search" @click="getPermissionList">查询</el-button>
    </div>
    <div class="operation-box">
      <el-button type="primary" @click="handleAdd">新增</el-button>
      <el-button type="danger" icon="Delete" @click="deleteBatch">批量删除</el-button>
    </div>
    <el-table :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column label="序号" type="index" width="80"></el-table-column>
      <el-table-column label="权限值" prop="code"></el-table-column>
      <el-table-column label="描述" prop="description"></el-table-column>
      <el-table-column prop="createBy" label="创建人"></el-table-column>
      <el-table-column prop="createTime" label="创建时间"></el-table-column>
      <el-table-column label="操作" width="300">
        <template #default="{row}">
          <el-button type="text" icon="Edit" @click="handleUpdate(row)">编辑</el-button>
          <el-button type="text" icon="Delete" @click="deleteOne(row)">删除</el-button>
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
    <el-dialog v-model="mode" :title="title">
      <el-form :model="permission" :rules="formRules" label-width="80px" ref="formRef">
        <el-form-item label="权限值" required prop="code">
          <el-input v-model="permission.code"></el-input>
        </el-form-item>
        <el-form-item label="权限描述" required prop="description">
          <el-input v-model="permission.description"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="mode = false">取 消</el-button>
          <el-button type="primary" @click="submit">确 定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped lang="scss">

</style>
