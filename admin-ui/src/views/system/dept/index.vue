<script setup>
import {ref, reactive, onMounted} from "vue";
import {
  listDeptAPI,
  getDeptAPI,
  editDeptAPI,
  addDeptAPI,
  uploadDeptAPI,
  deleteDeptAPI
} from "@/api/system/dept.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification, updateNotification} from "@/utils/notification.js";
import {ElMessage} from "element-plus";
import {dept$statusMap} from '@/utils/dictMap.js'

const tableData = ref([])
const req = reactive({
   pageNum: 1,
   pageSize: 10,
   id: undefined,
   name: undefined,
   status: undefined,
   avatar: undefined,
   parentId: undefined,
   sort: undefined,
   createUser: undefined,
   createTime: undefined
})
function reset() {
  req.id = undefined
  req.name = undefined
  req.status = undefined
  req.avatar = undefined
  req.parentId = undefined
  req.sort = undefined
  req.createUser = undefined
  req.createTime = undefined
  getDeptList()

}

const total = ref(0)

const dept = reactive({
    id: undefined,
    name: undefined,
    status: undefined,
    avatar: undefined,
    parentId: undefined,
    sort: undefined,
    createUser: undefined,
    createTime: undefined
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
  dept.avatar = undefined
  dept.parentId = undefined
  dept.sort = undefined
  dept.createUser = undefined
  dept.createTime = undefined
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

/**
 * 上传图片
 */
function beforeUpload(file) {
    const isJPG = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/gif' || file.type === 'image/avif'
    const isLt2M = file.size / 1024 / 1024 < 2
    if (!isJPG) {
        ElMessage.error('上传头像图片只能是 JPG 格式!')
    }
    if (!isLt2M) {
        ElMessage.error('上传头像图片大小不能超过 2MB!')
    }
}
async function handleUpload(files) {
    const formData = new FormData()
    formData.append('file', files.file)
    const res = await uploadDeptAPI(formData)
    updateNotification(res, ()=>{
        dept.avatar = res.data
    })
}
onMounted(() => {
  getDeptList()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline @keyup.enter="getDeptList">
        <el-form-item label="部门名称">
          <el-input v-model="req.name" placeholder="请输入部门名称" clearable class="input-width"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="req.status" class="input-width" @change="getDeptList" clearable>
            <el-option v-for="(val,key) in dept$statusMap" :key="key" :label="val" :value="Number(key)"/>
          </el-select>
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
      <el-table-column label="状态" prop="status">
          <template #default="{row}">
            <el-tag type="primary">{{ dept$statusMap[row.status]}}</el-tag>
          </template>
      </el-table-column>
            <el-table-column label="部门头像" prop="avatar">
          <template #default="{row}">
              <el-image
                      style="width: 50px; height: 50px"
                      preview-teleported
                      :src="row.avatar"
                      :zoom-rate="1.2"
                      :max-scale="7"
                      :min-scale="0.2"
                      :preview-src-list="[row.avatar]"
                      :initial-index="0"
                      fit="cover"
              />
          </template>
      </el-table-column>
      <el-table-column label="父级部门id" prop="parentId"></el-table-column>
      <el-table-column label="排序" prop="sort"></el-table-column>
      <el-table-column label="创建人" prop="createUser"></el-table-column>
      <el-table-column label="创建时间" prop="createTime"></el-table-column>
      <el-table-column label="操作" width="300">
        <template #default="{row}">
          <el-button type="primary" icon="Edit" @click="handleEdit(row)" link>编辑</el-button>
          <el-button type="danger" icon="Delete" @click="deleteOne(row)" link>删除</el-button>
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
               <el-input v-model="dept.name" placeholder="请输入部门名称" clearable class="input-width" ></el-input>
           </el-form-item>
            </el-col>
        <el-col :span="12">
           <el-form-item label="状态" prop="status">
           <el-select v-model="dept.status" class="input-width">
            <el-option v-for="(val,key) in dept$statusMap" :key="key" :label="val" :value="Number(key)"/>
          </el-select>
          </el-form-item>
            </el-col>
            </el-row>
       <el-row :gutter="30">
        <el-col :span="12">
           <el-form-item label="部门头像" prop="avatar">
               <el-upload
                       class="avatar-uploader"
                       action="void"
                       :http-request="handleUpload"
                       accept="image/*"
                       :show-file-list="false"
                       :before-upload="beforeUpload"
               >
                   <img v-if="dept.avatar" :src="dept.avatar" class="avatar"/>
                   <el-icon v-else class="avatar-uploader-icon">
                       <Plus/>
                   </el-icon>
               </el-upload>
           </el-form-item>
            </el-col>
        <el-col :span="12">
           <el-form-item label="父级部门id" prop="parentId">
               <el-input v-model="dept.parentId" placeholder="请输入父级部门id" clearable class="input-width" ></el-input>
          </el-form-item>
            </el-col>
            </el-row>
       <el-row :gutter="30">
        <el-col :span="12">
           <el-form-item label="排序" prop="sort">
               <el-input v-model="dept.sort" placeholder="请输入排序" clearable class="input-width" ></el-input>
           </el-form-item>
            </el-col>
        <el-col :span="12">
           <el-form-item label="创建人" prop="createUser">
               <el-input v-model="dept.createUser" placeholder="请输入创建人" clearable class="input-width" ></el-input>
          </el-form-item>
            </el-col>
            </el-row>
       <el-row :gutter="30">
        <el-col :span="12">
           <el-form-item label="创建时间" prop="createTime">
               <el-input v-model="dept.createTime" placeholder="请输入创建时间" clearable class="input-width" disabled></el-input>
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
.avatar-uploader {
    border: 1px dashed var(--el-border-color);
    width: 178px;
    height: 178px;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    transition: var(--el-transition-duration-fast);
}

.avatar-uploader:hover {
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
