<script setup>
import {ref, reactive, onMounted, nextTick} from "vue";
import {
  listOperationLogAPI,
  deleteOperationLogAPI,
} from "@/api/system/operationLog.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {deleteNotification} from "@/utils/notification.js";
import {ElMessage} from "element-plus";
import CodeBox from '@/components/CodeBox/index.vue'
import {
  operation_log$business_typeMap,
  operation_log$operator_typeMap,
  operation_log$statusMap
} from "../../../utils/dictMap.js";


const tableData = ref([])
const req = reactive({
  pageNum: 1,
  pageSize: 10,
  id: undefined,
  title: undefined,
  businessType: undefined,
  method: undefined,
  requestMethod: undefined,
  operatorType: undefined,
  operationName: undefined,
  operationParam: undefined,
  jsonResult: undefined,
  status: undefined,
  errorMsg: undefined,
  operationTime: undefined,
  costTime: undefined
})

function reset() {
  req.id = undefined
  req.title = undefined
  req.businessType = undefined
  req.method = undefined
  req.requestMethod = undefined
  req.operatorType = undefined
  req.operationName = undefined
  req.operationParam = undefined
  req.jsonResult = undefined
  req.status = undefined
  req.errorMsg = undefined
  req.operationTime = undefined
  req.costTime = undefined
  getOperationLogList()
}

const total = ref(0)


const selections = ref([])

function handleSelectionChange(val) {
  selections.value = val
}


function del(ids) {
  handleConfirmDel(async () => {
    const res = await deleteOperationLogAPI(ids)
    deleteNotification(res, () => {
      getOperationLogList()
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
  getOperationLogList()
}

function handleCurrentChange(val) {
  getOperationLogList()
}

let p = reactive({})
const dialog = ref(false)

function handleDetail(row) {
  dialog.value = true
  const c = {...row}
  if (row.operationParam)
    c.operationParam = JSON.stringify(JSON.parse(row.operationParam), null, 2)
  if (row.jsonResult)
    c.jsonResult = JSON.stringify(JSON.parse(row.jsonResult), null, 2)
  Object.assign(p, c)
}


async function getOperationLogList() {
  const res = await listOperationLogAPI(req)
  if (res.code === 200) {
    tableData.value = res.data
    total.value = Number(res.total)
  }
}



onMounted(() => {
  getOperationLogList()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline @keyup.enter="getOperationLogList">
        <el-form-item label="模块标题">
          <el-input v-model="req.title" placeholder="请输入标题" clearable class="input-width"></el-input>
        </el-form-item>
        <el-form-item label="业务类型">
          <el-select v-model="req.businessType" placeholder="请选择日志类型" clearable
                    class="input-width">
            <el-option v-for="(val,key) in operation_log$business_typeMap" :key="key" :label="val" :value="Number(key)"/>
          </el-select>
        </el-form-item>
        <el-form-item label="方法名称">
          <el-input v-model="req.method" placeholder="请输入method" clearable class="input-width"></el-input>
        </el-form-item>
        <el-form-item label="请求方式">
          <el-input v-model="req.requestMethod" placeholder="请输入requestMethod" clearable
                    class="input-width"></el-input>
        </el-form-item>
        <el-form-item label="操作类别">
          <el-select v-model="req.operatorType" placeholder="请选择操作类型" clearable
                    class="input-width">
            <el-option v-for="(val,key) in operation_log$operator_typeMap" :key="key" :label="val" :value="Number(key)"/>
          </el-select>
        </el-form-item>
        <el-form-item label="操作人员">
          <el-input v-model="req.operationName" placeholder="请输入操作者" clearable
                    class="input-width"></el-input>
        </el-form-item>

        <el-form-item label="操作状态">
          <el-select v-model="req.status" class="input-width">
            <el-option v-for="(val,key) in operation_log$statusMap" :key="key" :label="val" :value="Number(key)"/>
          </el-select>
        </el-form-item>
        <el-form-item label="错误消息">
          <el-input v-model="req.errorMsg" placeholder="请输入errorMsg" clearable class="input-width"></el-input>
        </el-form-item>

      </el-form>
    </div>
    <div class="operation-box">
      <el-button icon="Search" @click="getOperationLogList">查询</el-button>
      <el-button type="info" icon="refresh" @click="reset">重置</el-button>
      <el-button type="danger" icon="Delete" @click="deleteBatch">删除</el-button>
    </div>
    <el-table :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column label="序号" type="index" width="80"></el-table-column>
      <el-table-column label="模块标题" prop="title"></el-table-column>
      <el-table-column label="业务类型" prop="businessType">
        <template #default="{row}">
          {{ operation_log$business_typeMap[row.businessType] }}
        </template>
      </el-table-column>
      <el-table-column label="方法名称" prop="method"></el-table-column>
      <el-table-column label="请求方式" prop="requestMethod"></el-table-column>
      <el-table-column label="操作类别" prop="operatorType">
        <template #default="{row}">
          {{ operation_log$operator_typeMap[row.operatorType] }}
        </template>
      </el-table-column>
      <el-table-column label="操作人员" prop="operationName"></el-table-column>
      <el-table-column label="操作状态" prop="status">
        <template #default="{row}">
          {{ operation_log$statusMap[row.status] }}
        </template>
      </el-table-column>
      <el-table-column label="操作时间" prop="operationTime"></el-table-column>
      <el-table-column label="消耗时间,单位ms" prop="costTime"></el-table-column>
      <el-table-column label="操作" width="300">
        <template #default="{row}">
          <el-button type="primary" @click="handleDetail(row)">详细</el-button>
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
    <el-dialog v-model="dialog" title="操作日志详细">
      <el-form label-width="80px">
        <el-form-item label="模块标题">
          {{ p.title }}
        </el-form-item>
        <el-form-item label="操作类型">
          {{ p.operationTime }}
        </el-form-item>
        <el-form-item label="业务类型">
          {{ operation_log$business_typeMap[p.businessType] }}
        </el-form-item>
        <el-form-item label="方法名称">
          {{ p.method }}
        </el-form-item>
        <el-form-item label="请求方式">
          {{ p.requestMethod }}
        </el-form-item>
        <el-form-item label="操作类别">
          {{ operation_log$operator_typeMap[p.operatorType] }}
        </el-form-item>
        <el-form-item label="操作人员">
          {{ p.operationName }}
        </el-form-item>
        <el-form-item label="操作状态">
          {{ operation_log$statusMap[p.status] }}
        </el-form-item>
        <CodeBox :data="p.operationParam" header="请求参数"></CodeBox>
        <CodeBox :data="p.jsonResult" header="响应数据" ></CodeBox>
        <el-form-item label="错误消息">
          {{ p.errorMsg }}
        </el-form-item>

      </el-form>
    </el-dialog>

  </div>
</template>

<style scoped lang="scss">

</style>
