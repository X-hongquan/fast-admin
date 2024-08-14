<script setup>

import {ref, onMounted, reactive} from "vue";
import {getLogListAPI} from "@/api/log/index.js";
import CodeBox from '@/components/CodeBox/index.vue'

const tableData = ref([])
const req = reactive({
  pageNum: 1,
  pageSize: 10,
  status: undefined,
  businessType: undefined,
  requestMethod: undefined
})
const total = ref(0)
const mode = ref(false)

function resetReq() {
  for (const key in req) {
    req[key] = undefined
  }
  req.pageNum = 1
  req.pageSize = 10
  getLogList()
}


async function getLogList() {
  const res = await getLogListAPI(req)
  if (res.code === 200) {
    const arr = res.data
    arr.forEach(item => {
      switch (item.businessType) {
        case 0:
          item.businessTypeLabel = '其他'
          break
        case 1:
          item.businessTypeLabel = '新增'
          break
        case 2:
          item.businessTypeLabel = '修改'
          break
        case 3:
          item.businessTypeLabel = '删除'
          break
        case 4:
          item.businessTypeLabel = '授权'
          break
      }
    })
    tableData.value = arr
    total.value = Number(res.total)
  }
}

function handleSizeChange(val) {
  req.pageNum = 1
  getLogList()
}

function handleCurrentChange(val) {
  getLogList()
}

const logEntity = reactive({
  title: undefined,
  operationParam: undefined,
  jsonResult: undefined,
  costTime: undefined,
  method: undefined,
  requestMethod: undefined,
  operationTime: undefined,
  operationName: undefined,
  businessType: undefined,
  businessTypeLabel: undefined,
  status: undefined,
  errorMsg: undefined
})

function handleDetail(row) {
  const p={...row}
  p.operationParam = JSON.stringify(JSON.parse(row.operationParam), null, 2)
  p.jsonResult = JSON.stringify(JSON.parse(row.jsonResult), null, 2)
  Object.assign(logEntity, p)
  mode.value = true

}






onMounted(() => {
  getLogList()
})
</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline>
        <el-form-item label="状态">
          <el-select v-model="req.status" placeholder="请选择" class="input-width" clearable>
            <el-option label="成功" :value="0"></el-option>
            <el-option label="失败" :value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="操作类型">
          <el-select v-model="req.businessType" placeholder="请选择" class="input-width" clearable>
            <el-option label="其他" :value="0"></el-option>
            <el-option label="新增" :value="1"></el-option>
            <el-option label="修改" :value="2"></el-option>
            <el-option label="删除" :value="3"></el-option>
            <el-option label="授权" :value="4"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="方法名">
          <el-input v-model="req.requestMethod" placeholder="请输入" class="input-width"></el-input>
        </el-form-item>
      </el-form>
    </div>
    <div class="operation-box">
      <el-button type="primary" @click="getLogList">查询</el-button>
      <el-button type="primary" @click="resetReq">重置</el-button>
    </div>
    <el-table :data="tableData">

      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column label="标题" prop="title"></el-table-column>
      <el-table-column label="方法名" prop="method" width="400"></el-table-column>
      <el-table-column label="操作类型" prop="businessTypeLabel">
        <template #default="{row}">
          <el-tag> {{ row.businessTypeLabel }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="请求方法" prop="requestMethod"></el-table-column>
      <el-table-column label="状态" prop="status">
        <template #default="{row}">
          <el-tag v-if="row.status===0">成功</el-tag>
          <el-tag v-else type="danger">失败</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作人" prop="operationName">
        <template #default="{row}">
          <el-tag>{{ row.operationName }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作时间" prop="operationTime"></el-table-column>
      <el-table-column label="操作" width="100">
        <template #default="{row}">
          <el-button type="text" @click="handleDetail(row)">详细</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
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

  <el-dialog :title="logEntity.title" v-model="mode">
    <p class="my-h">方法名: {{ logEntity.method }}</p>
    <p class="my-h">花费时间: {{ logEntity.costTime }}ms</p>
    <p class="my-h">请求方式: {{ logEntity.requestMethod }}</p>
    <p class="my-h">操作人: {{ logEntity.operationName }}</p>
    <p class="my-h">操作时间: {{ logEntity.operationTime }}</p>
    <p class="my-h">操作类型: {{ logEntity.businessTypeLabel }}</p>
    <p class="my-h">状态: {{ logEntity.status === 0 ? '成功' : '失败' }}</p>
    <p class="my-h">请求参数</p>
    <CodeBox :data="logEntity.operationParam"></CodeBox>
    <p class="my-h">响应数据</p>
    <CodeBox :data="logEntity.jsonResult"></CodeBox>
    <p class="my-h">异常信息</p>
    <CodeBox :data="logEntity.errorMsg"></CodeBox>

  </el-dialog>
</template>

<style scoped lang="scss">

.my-h {
  font-size: 25px;
  font-weight: bold;
  margin: 20px 0;

}


</style>
