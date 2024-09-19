<script setup>
import {ref, reactive, onMounted} from "vue";
import {
  list${className}API,
  delete${className}API,
  get${className}API,
  edit${className}API,
  add${className}API
} from "@/api/${paramsName}.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification, updateNotification} from "@/utils/notification.js";
import {ElMessage} from "element-plus";

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

onMounted(() => {
  get${className}List()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline>
        <#list columns as c>
        <#if c.name != 'id'>
        <el-form-item label="${c.comment}">
          <el-input v-model="req.${c.name}" placeholder="请输入${c.name}" clearable class="input-width"></el-input>
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
      <el-table-column label="${c.comment}" prop="${c.name}"></el-table-column>
      </#list>
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
      <el-form :model="${paramsName}" :rules="formRules" label-width="80px" ref="formRef">
        <#list columns as c>
        <#if c.name != 'id'>
        <#if c_index %2 = 1>
       <el-row :gutter="30">
        <el-col :span="12">
        <el-form-item label="${c.comment}" prop="${c.name}">
          <el-input v-model="${paramsName}.${c.name}" placeholder="请输入${c.comment}" clearable class="input-width"></el-input>
        </el-form-item>
        </el-col>
   <#if !c_has_next>
        </el-row>
   </#if>
        <#else>
        <el-col :span="12">
        <el-form-item label="${c.comment}" prop="${c.name}">
          <el-input v-model="${paramsName}.${c.name}" placeholder="请输入${c.comment}" clearable class="input-width"></el-input>
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

</style>
