<script setup>
import {ref, reactive, onMounted} from "vue";
import {
  listDeptAPI,
  deleteDeptAPI,
  getDeptAPI,
  editDeptAPI,
  addDeptAPI
} from "@/api/dept.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification, updateNotification} from "@/utils/notification.js";
import {ElMessage} from "element-plus";

const tableData = ref([])
const req = reactive({
   pageNum: 1,
   pageSize: 10,
   id: undefined,
   name: undefined,
   status: undefined
})
function reset() {
  req.id = undefined
  req.name = undefined
  req.status = undefined
}

const total = ref(0)

const dept = reactive({
    id: undefined,
    name: undefined,
    status: undefined
})


const selections = ref([])
function handleSelectionChange(val) {
  selections.value = val
}

const formRef = ref(null)
const formRules = reactive({
   name: [
    {required: true, message: '部门名称不能为空', trigger: 'blur'},
   ],
    status: [
     {required: true, message: '状态不能为空', trigger: 'blur'}
   ]
})



function del(ids) {
  handleConfirmDel(async () => {
    const res = await deleteDeptAPI(ids)
    deleteNotification(res, () => {
      getDeptList()
    })
  })
}
function deleteOne(row) {
  del(row.id)
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
  getDeptList()
}
function handleCurrentChange(val) {
  getDeptList()
}





const title = ref('')
const dialog=ref(false)
function resetForm() {
  dept.id = undefined
  dept.name = undefined
  dept.status = undefined
}
function handleAdd() {
  resetForm()
  dialog.value = true
  title.value = '新增部门'
}
async function handleEdit(row) {
  resetForm()
  dialog.value = true
  title.value = '编辑部门'
  const res = await getDeptAPI(row.id)
  Object.assign(dept, res.data)

}

async function submit() {
  await formRef.value.validate()
  if (dept.id) {
    const res = await editDeptAPI(dept)
    updateNotification(res, () => {
      getDeptList()
      dialog.value = false
    })
  } else {
    const res = await addDeptAPI(dept)
    addNotification(res, () => {
      getDeptList()
      dialog.value = false
    })
  }
}

async function getDeptList() {
  const res = await listDeptAPI(req)
  if (res.code === 200) {
    tableData.value = res.data
    total.value = Number(res.total)
  }
}

onMounted(() => {
  getDeptList()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline>
        <el-form-item label="部门名称">
          <el-input v-model="req.name" placeholder="请输入name" clearable class="input-width"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-input v-model="req.status" placeholder="请输入status" clearable class="input-width"></el-input>
        </el-form-item>
      </el-form>
    </div>
    <div class="operation-box">
        <el-button icon="Search" @click="getDeptList">查询</el-button>
        <el-button type="primary" icon="Plus" @click="handleAdd">新增</el-button>
        <el-button type="info" icon="refresh" @click="reset">重置</el-button>
        <el-button type="danger" icon="Delete" @click="deleteBatch">删除</el-button>
    </div>
    <el-table :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column label="序号" type="index" width="80"></el-table-column>
      <el-table-column label="" prop="id"></el-table-column>
      <el-table-column label="部门名称" prop="name"></el-table-column>
      <el-table-column label="状态" prop="status"></el-table-column>
      <el-table-column label="操作" width="300">
        <template #default="{row}">
          <el-button type="primary" icon="Edit" @click="handleEdit(row)">编辑</el-button>
          <el-button type="danger" icon="Delete" @click="deleteOne(row)">删除</el-button>
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
    <el-dialog v-model="dialog" :title="title">
      <el-form :model="dept" :rules="formRules" label-width="80px" ref="formRef">
       <el-row :gutter="30">
        <el-col :span="12">
        <el-form-item label="部门名称" prop="name">
          <el-input v-model="dept.name" placeholder="请输入部门名称" clearable class="input-width"></el-input>
        </el-form-item>
        </el-col>
        <el-col :span="12">
        <el-form-item label="状态" prop="status">
          <el-input v-model="dept.status" placeholder="请输入状态" clearable class="input-width"></el-input>
        </el-form-item>
         </el-col>
         </el-row>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialog = false">取 消</el-button>
          <el-button type="primary" @click="submit">确 定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped lang="scss">

</style>
