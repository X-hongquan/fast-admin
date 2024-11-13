<script setup>
import {ref, reactive, onMounted} from "vue";
import {
  list${className}API,
  get${className}API,
  edit${className}API,
  add${className}API,
  <#list columns as c>
    <#if c.img=='y'>
  upload${className}API,
    </#if>
  </#list>
  delete${className}API
} from "@/api/${module}${paramsName}.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification, updateNotification} from "@/utils/notification.js";
import {ElMessage} from "element-plus";
${tableInfo.dictLabel}

const tableData = ref([])
const req = reactive({
   pageNum: 1,
   pageSize: 10,
<#list columns as c>
<#if c_has_next>
   ${c.name}: undefined,
    <#else>
   ${c.name}: undefined
</#if>
</#list>
})
function reset() {
  <#list columns as c>
  req.${c.name} = undefined
  </#list>
  get${className}List()

}

const total = ref(0)

const ${paramsName} = reactive({
    <#list columns as c>
    <#if c_has_next>
    ${c.name}: undefined,
    <#else>
    ${c.name}: undefined
    </#if>
    </#list>
})


const selections = ref([])
function handleSelectionChange(val) {
  selections.value = val
}

const formRef = ref(null)
const formRules = reactive({
  <#list columns as c>
  <#if c.name!='id'>
  <#if c.nullable=='NO'>
   <#if c_has_next>
   ${c.name}: [
    {required: true, message: '${c.comment}不能为空', trigger: 'blur'},
   ],
   <#else>
    ${c.name}: [
     {required: true, message: '${c.comment}不能为空', trigger: 'blur'}
   ]
   </#if>
  </#if>
  </#if>
  </#list>
})



function del(ids) {
  handleConfirmDel(async () => {
    const res = await delete${className}API(ids)
    deleteNotification(res, () => {
      get${className}List()
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
  get${className}List()
}
function handleCurrentChange(val) {
  get${className}List()
}





const title = ref('')
const dialog=ref(false)
function resetForm() {
  <#list columns as c>
  ${paramsName}.${c.name} = undefined
  </#list>
}
function handleAdd() {
  resetForm()
  dialog.value = true
  title.value = '新增${tableInfo.comment}'
}
async function handleEdit(row) {
  resetForm()
  dialog.value = true
  title.value = '编辑${tableInfo.comment}'
  const res = await get${className}API(row.id)
  Object.assign(${paramsName}, res.data)

}

async function submit() {
  await formRef.value.validate()
  if (${paramsName}.id) {
    const res = await edit${className}API(${paramsName})
    updateNotification(res, () => {
      get${className}List()
      dialog.value = false
    })
  } else {
    const res = await add${className}API(${paramsName})
    addNotification(res, () => {
      get${className}List()
      dialog.value = false
    })
  }
}

async function get${className}List() {
  const res = await list${className}API(req)
  if (res.code === 200) {
    tableData.value = res.data
    total.value = Number(res.total)
  }
}

<#list columns as c>
<#if c.img=='y'>
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
    const res = await upload${className}API(formData)
    updateNotification(res, ()=>{
        ${paramsName}.${c.name} = res.data
    })
}
</#if>
</#list>
onMounted(() => {
  get${className}List()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline @keyup.enter="get${className}List">
        <#list columns as c>
        <#if c.select == 'n'>
        <#if c.search=='y'>
        <el-form-item label="${c.comment}">
          <el-input v-model="req.${c.name}" placeholder="请输入${c.comment}" clearable class="input-width"></el-input>
        </el-form-item>
        </#if>
        <#else>
        <el-form-item label="${c.comment}">
          <el-select v-model="req.${c.name}" class="input-width" @change="get${className}List" clearable>
            <el-option v-for="(val,key) in ${tableInfo.tableName}$${c.dbName}Map" :key="key" :label="val" :value="Number(key)"/>
          </el-select>
        </el-form-item>
        </#if>
        </#list>
      </el-form>
    </div>
    <div class="operation-box">
        <el-button icon="Search" @click="get${className}List">查询</el-button>
        <el-button type="primary" icon="Plus" @click="handleAdd">新增</el-button>
        <el-button type="info" icon="refresh" @click="reset">重置</el-button>
        <el-button type="danger" icon="Delete" @click="deleteBatch">删除</el-button>
    </div>
    <el-table :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column label="序号" type="index" width="80"></el-table-column>
      <#list columns as c>
      <#if c.select == 'n'>
       <#if c.img == 'y'>
            <el-table-column label="${c.comment}" prop="${c.name}">
          <template #default="{row}">
              <el-image
                      style="width: 50px; height: 50px"
                      preview-teleported
                      :src="row.${c.name}"
                      :zoom-rate="1.2"
                      :max-scale="7"
                      :min-scale="0.2"
                      :preview-src-list="[row.${c.name}]"
                      :initial-index="0"
                      fit="cover"
              />
          </template>
      </el-table-column>
      <#else>
      <el-table-column label="${c.comment}" prop="${c.name}"></el-table-column>
       </#if>
      <#else>
      <el-table-column label="${c.comment}" prop="${c.name}">
          <template #default="{row}">
            <el-tag type="primary">{{ ${tableInfo.tableName}$${c.dbName}Map[row.${c.name}]}}</el-tag>
          </template>
      </el-table-column>
      </#if>
      </#list>
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
      <el-form :model="${paramsName}" :rules="formRules" label-width="80px" ref="formRef">
        <#list columns as c>
        <#if c.name != 'id'>
        <#if c_index %2 = 1>
       <el-row :gutter="30">
        <el-col :span="12">
           <el-form-item label="${c.comment}" prop="${c.name}">
               <#if c.select == 'n'>
               <#if c.img=='y'>
               <el-upload
                       class="avatar-uploader"
                       action="void"
                       :http-request="handleUpload"
                       accept="image/*"
                       :show-file-list="false"
                       :before-upload="beforeUpload"
               >
                   <img v-if="${paramsName}.${c.name}" :src="${paramsName}.${c.name}" class="avatar"/>
                   <el-icon v-else class="avatar-uploader-icon">
                       <Plus/>
                   </el-icon>
               </el-upload>
               <#else>
               <el-input v-model="${paramsName}.${c.name}" placeholder="请输入${c.comment}" clearable class="input-width" ${c.disabled}></el-input>
               </#if>
           <#else>
           <el-select v-model="${paramsName}.${c.name}" class="input-width">
            <el-option v-for="(val,key) in ${tableInfo.tableName}$${c.dbName}Map" :key="key" :label="val" :value="Number(key)"/>
          </el-select>
           </#if>
           </el-form-item>
            </el-col>
   <#if !c_has_next>
        </el-row>
   </#if>
        <#else>
        <el-col :span="12">
           <el-form-item label="${c.comment}" prop="${c.name}">
               <#if c.select == 'n'>
               <#if c.img=='y'>
               <el-upload
                       class="avatar-uploader"
                       action="void"
                       :http-request="handleUpload"
                       accept="image/*"
                       :show-file-list="false"
                       :before-upload="beforeUpload"
               >
                   <img v-if="${paramsName}.${c.name}" :src="${paramsName}.${c.name}" class="avatar"/>
                   <el-icon v-else class="avatar-uploader-icon">
                       <Plus/>
                   </el-icon>
               </el-upload>
               <#else>
               <el-input v-model="${paramsName}.${c.name}" placeholder="请输入${c.comment}" clearable class="input-width" ${c.disabled}></el-input>
               </#if>
           <#else>
           <el-select v-model="${paramsName}.${c.name}" class="input-width">
            <el-option v-for="(val,key) in ${tableInfo.tableName}$${c.dbName}Map" :key="key" :label="val" :value="Number(key)"/>
          </el-select>
           </#if>
          </el-form-item>
            </el-col>
            </el-row>
        </#if>
           </#if>
        </#list>
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
<#list  columns as c>
<#if c.img=='y'>
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

</#if>
</#list>
</style>
