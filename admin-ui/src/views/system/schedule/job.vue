<script setup>

import {onMounted, reactive, ref} from 'vue'
import {
  addJobInfoAPI,
  deleteJobInfoAPI,
  editJobInfoAPI,
  getJobInfoAPI,
  listJobInfoAPI,
  startJobInfoAPI,
  stopJobInfoAPI
} from "@/api/job.js";
import {handleConfirmDel} from "@/utils/confirm.js";
import {addNotification, deleteNotification, updateNotification} from "@/utils/notification.js";
import {useRouter} from "vue-router";

const tableData = ref([])
const req = reactive({
  pageNum: 1,
  pageSize: 10,
  jobName: undefined,
  jobDesc: undefined,
  triggerStatus: undefined
})
const total = ref(0)

const jobInfo = reactive({
  id: undefined,
  jobName: undefined,
  jobDesc: undefined,
  jobType: undefined,
  jobNextTime: undefined,
  nextTime: undefined,
  jobRate: undefined,
  jobCron: undefined,
  triggerStatus: 0,
  triggerLastTime: undefined,
  remark: undefined,
  method: undefined,
  cron: undefined,
  createBy: undefined,
  createTime: undefined,
  updateBy: undefined,
  updateTime: undefined
})

const startTime = ref('')


function reset() {
  req.jobName = undefined
  req.jobDesc = undefined
  req.triggerStatus = undefined
}

async function getJobList() {
  const res = await listJobInfoAPI(req)
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
        const res = await deleteJobInfoAPI(ids)
        deleteNotification(res, () => {
          getJobList()
        })
      }
  )
}


async function startJob(row) {
  const res = await startJobInfoAPI(row)
  updateNotification(res, () => {
    row.triggerStatus = 1
  })
}

async function stopJob(row) {
  const res = await stopJobInfoAPI(row)
  updateNotification(res, () => {
    row.triggerStatus = 0
  })
}


const dialog = ref(false)
const dialogTitle = ref('新增任务')

function resetForm() {
  Object.keys(jobInfo).forEach(key => {
    jobInfo[key] = undefined
  })
  jobInfo.triggerStatus = 0;
}

function handleAdd() {
  dialogTitle.value = '新增任务'
  dialog.value = true
  resetForm()
}

async function handleEdit(row) {
  dialogTitle.value = '编辑任务'
  const res = await getJobInfoAPI(row.id)
  resetForm()
  Object.assign(jobInfo, res.data)
  dialog.value = true
}

async function submit() {
  if (jobInfo.id) {
    const res = await editJobInfoAPI(jobInfo)
    updateNotification(res, () => {
      getJobList()
      dialog.value = false
    })
  } else {
    const res = await addJobInfoAPI(jobInfo)
    addNotification(res, () => {
      getJobList()
      dialog.value = false
    })
  }
}


function handleSizeChange(val) {
  req.pageNum = 1
  getJobList()
}

function handleCurrentChange(val) {
  getJobList()
}

const router = useRouter()

function handleGoLog(row) {
  router.push({
    name: 'scheduleLog',
    query: {
      jobName: row.jobName
    }
  })
}

onMounted(() => {
  getJobList()
})


</script>

<template>
  <div class="content-box">
    <div class="search-box">
      <el-form inline>
        <el-form-item label="任务名称">
          <el-input v-model="req.jobName" placeholder="请输入任务名称" clearable></el-input>
        </el-form-item>
        <el-form-item label="任务描述">
          <el-input v-model="req.jobDesc" placeholder="请输入任务描述" clearable></el-input>
        </el-form-item>
        <el-form-item label="触发状态">
          <el-select v-model="req.triggerStatus" placeholder="请选择触发状态" clearable class="input-width">
            <el-option label="运行" :value="1"></el-option>
            <el-option label="停止" :value="0"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
    </div>
    <div class="operation-box">
      <el-button icon="Search" @click="getJobList">查询</el-button>
      <el-button type="primary" icon="Plus" @click="handleAdd">新增</el-button>
      <el-button type="info" icon="refresh" @click="reset">重置</el-button>
      <el-button type="danger" icon="Delete" @click="del">删除</el-button>
    </div>
    <el-table :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column type="index" label="序号" width="80"></el-table-column>
      <el-table-column prop="jobName" label="任务名"></el-table-column>
      <el-table-column prop="jobDesc" label="描述"></el-table-column>
      <el-table-column prop="jobCron" label="cron表达式"></el-table-column>
      <el-table-column prop="nextTime" label="下次执行时间"></el-table-column>
      <el-table-column prop="jobRate" label="周期(s)"></el-table-column>

      <el-table-column label="操作">
        <template #default="{row}">
          <el-button @click="startJob(row)" v-if="row.triggerStatus === 0">启动</el-button>
          <el-button type="danger" @click="stopJob(row)" v-else>停止</el-button>
          <el-button type="text" @click="handleEdit(row)">编辑</el-button>
          <el-button type="info" @click="handleGoLog(row)">日志</el-button>
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

    <el-dialog v-model="dialog" :title="dialogTitle" width="500px">
      <el-form label-width="80px">
        <el-form-item label="任务名称" required>
          <el-input v-model="jobInfo.jobName" placeholder="请输入任务名称" clearable></el-input>
        </el-form-item>
        <el-form-item label="任务描述" required>
          <el-input type="textarea" v-model="jobInfo.jobDesc" placeholder="请输入任务描述" clearable></el-input>
        </el-form-item>
        <el-form-item label="触发状态">
          <el-select v-model="jobInfo.triggerStatus" placeholder="请选择触发状态" clearable class="input-width">
            <el-option label="正常" :value="1"></el-option>
            <el-option label="暂停" :value="0"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="模式" required>
          <el-select v-model="jobInfo.jobType" placeholder="请选择触发模式" clearable class="input-width">
            <el-option label="fixedRate" :value="1"></el-option>
            <el-option label="cron" :value="2"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="开始时间" v-if="jobInfo.jobType==1">
          <el-date-picker v-model="jobInfo.nextTime" type="datetime" placeholder="选择日期时间" clearable
                          value-format="YYYY-MM-DD HH:mm:ss">

          </el-date-picker>
        </el-form-item>
        <el-form-item label="周期(s)" required v-if="jobInfo.jobType==1">
          <el-input v-model="jobInfo.jobRate" placeholder="请输入周期(s)" clearable></el-input>
        </el-form-item>
        <el-form-item label="cron" required v-if="jobInfo.jobType==2">
          <el-input v-model="jobInfo.jobCron" placeholder="请输入cron表达式" clearable></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialog = false">取 消</el-button>
        <el-button type="primary" @click="submit">确 定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped lang="scss">

</style>
