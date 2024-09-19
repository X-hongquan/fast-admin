<script setup>

import {computed, onMounted, reactive, ref, watch} from 'vue'
import {

  deleteLogJobInfoAPI,
  listLogJobInfoAPI,

} from "@/api/jobInfo.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification, updateNotification} from "@/utils/notification.js";
import {useRoute} from "vue-router";
import {job_log$handle_statusMap} from "@/utils/dictMap.js";

const tableData = ref([])
//时间间隔
const value2 = ref([])
const req = reactive({
  pageNum: 1,
  pageSize: 10,
  jobId: undefined,
  jobName: undefined,
  handleTime: undefined,
  handleStatus: undefined,
})

const total = ref(0)


function reset() {
  req.jobId = undefined
  req.jobName = undefined
  req.handleStatus = undefined
  req.handleTime = undefined
  req.endTime = undefined
  req.startTime = undefined
  value2.value = []
  getJobLogList()
}

async function getJobLogList() {
  if (value2.value.length == 2) {
    for (let i = 0; i < value2.value.length; i++) {
      req.startTime = value2.value[0]
      req.endTime = value2.value[1]
    }
  }
  const res = await listLogJobInfoAPI(req)
  if (res.code === 200) {
    tableData.value = res.data
    total.value = Number(res.total)
  }
}

const selection = ref([])

function handleSelectionChange(val) {
  selection.value = val
}

function del() {
  handleConfirmDel(async () => {
        const ids = selection.value.map(item => item.id)
        const res = await deleteLogJobInfoAPI(ids)
        deleteNotification(res, () => {
          getJobLogList()
        })
      }
  )
}


function getValue2() {

}


function handleSizeChange(val) {
  req.pageNum = 1
  getJobLogList()
}

function handleCurrentChange(val) {
  getJobLogList()
}

const route = useRoute()
req.jobName = route.query.jobName
onMounted(() => {

  getJobLogList()
})

</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline @keyup.enter="getJobLogList">
        <el-form-item label="任务名称">
          <el-input v-model="req.jobName" placeholder="请输入任务名称" clearable></el-input>
        </el-form-item>
        <el-form-item label="处理时间">
          <el-input v-model="req.handleTime" type="number" placeholder="请输入时间大于X(ms)"></el-input>
        </el-form-item>
        <el-form-item label="执行状态">
          <el-select v-model="req.handleStatus" placeholder="请选择触发状态" clearable class="input-width">
            <el-option v-for="(value,key) in job_log$handle_statusMap" :value="Number(key)" :label="value" :key="key"/>
          </el-select>
        </el-form-item>
        <el-form-item label="调度时间">
          <div class="block">
            <el-date-picker
                v-model="value2"
                type="datetimerange"
                @change="getValue2"
                start-placeholder="Start date"
                end-placeholder="End date"
                value-format="YYYY-MM-DD HH:mm:ss"
            />
          </div>
        </el-form-item>
      </el-form>
    </div>
    <div class="operation-box">
      <el-button icon="Search" @click="getJobLogList">查询</el-button>
      <el-button type="info" icon="refresh" @click="reset">重置</el-button>
      <el-button type="danger" icon="Delete" @click="del">删除</el-button>
    </div>
    <el-table :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column type="index" label="序号" width="80"></el-table-column>
      <el-table-column prop="jobName" label="任务"></el-table-column>
      <el-table-column prop="handleTime" label="处理时间"></el-table-column>
      <el-table-column prop="triggerTime" label="调度时间"></el-table-column>
      <el-table-column prop="handleStatus" label="处理状态">
        <template v-slot="{row}">
          <el-tag>{{ job_log$handle_statusMap[row.handleStatus] }}</el-tag>
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

</style>
